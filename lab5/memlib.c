/*
 * memlib.c - a module that simulates the memory system.  Needed
 * because it allows us to interleave calls from the student's malloc
 * package with the system's malloc package in libc.
 *
 * This version has been updated to enable sparse emulation of very large heaps.
 *  Sparse emulation uses the same mmap pages for the normal heap but instead
 *  uses them as part of a map.  Using the same amount of space, designs should
 *  fit reasonably into both dense and sparse.  However, mdriver was modified
 *  to reduce its writing of payload bytes, as these bytes accounted for
 *  additional load on the emulation system and pushed some implementations to
 *  run out of emulation memory.
 *
 * map(emulated address / PAGE_SIZE) -> mem_block_t
 * map(mem_block_t, emulated address % PAGE_SIZE) -> byte(s)
 *
 * This mapping is for a single address; however, accesses can span two blocks
 *  so the mapping sequence checks accounts for size and can perform two
 *  lookups if necessary.
 *
 * Storing in the sparse emulation goes through the above lookup process and
 *  then memcpy's the bytes into the block.
 *
 * Loading from the sparse emulation uses the above lookup and then aggregates
 *  the data into a return value.
 *
 * If an emulated access is made to an address outside of the current
 *  bounds (mem_heap_lo, mem_heap_hi), then the address is assumed to be to
 *  a non-heap location, such as stack, global variables, etc.  For some
 *  implementations, this access is meant to be to the heap and was "safe"
 *  in non-emulation, as it was to the same page as actual heap data.  But
 *  sparse emulation has tighter checks.  Commonly, the CPU reports a
 *  BUS ERROR on these accesses, and should be debugged as segmentation faults.
 */
#define _XOPEN_SOURCE 700
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>

#ifdef USE_ASAN
#include <sanitizer/asan_interface.h>
#endif

#ifdef USE_MSAN
#include <sanitizer/msan_interface.h>
void markGlobalsUninit(void);
#endif

/* sbrk() is not declared by unistd.h in strict conformance mode.
   FIXME: we shouldn't be calling sbrk at all due to conflicts with
   libc malloc.  */
extern void *sbrk(intptr_t);

#include "config.h"
#include "memlib.h"

/* Data structure used to implement pages in sparse memory emulation */
typedef struct MBLK {
    size_t id;         /* Page ID.  Counts number of pages from start of heap */
    struct MBLK *next; /* Link for hash table */
    unsigned char initSet[SPARSE_PAGE_SIZE / 8];
    unsigned char bytes[SPARSE_PAGE_SIZE]; /* Page contents */
} mem_block_t;

/* private global variables */
static bool sparse = false;         /* Use sparse memory emulation */
static unsigned char *heap;         /* Starting address of heap */
static unsigned char *mem_brk;      /* Current position of break */
static unsigned char *mem_max_addr; /* Maximum allowable heap address */
static size_t mmap_length =
    MAX_DENSE_HEAP; /* Number of bytes allocated by mmap */
static bool show_stats =
    false; /* Should program print allocation information? */
static bool stats_printed =
    false; /* Has information been printed about allocation */

/* Sparse memory representation */
static mem_block_t *next_free_page = NULL; /* Next free page */
static size_t num_pages = 0;               /* Total number of pages */
static size_t num_free_pages = 0;          /* Number of free pages */
static mem_block_t **page_table = NULL;    /* Hash table from page ID to page */
static size_t num_buckets = 0;             /* Number of buckets in page table */

#ifdef NO_CHECK_UB
static const bool checkUB = false;
void setUBCheck(bool val) {}
#else
static bool checkUB = true; /* should sparse check for UB */
void setUBCheck(bool val) {
    checkUB = val;
}
#endif

#ifdef USE_ASAN
const char *__asan_default_options(void) {
    return "abort_on_error=true:detect_leaks=0";
}
#endif

#ifdef USE_MSAN
const char *__msan_default_options(void) {
    return "abort_on_error=true";
}
#endif

/*
 * Forward declarations
 */
static size_t page_id(const void *addr);
static void *page_start(size_t id);
static void *get_mem(const void *addr, size_t, bool);
static void print_stats(void);

/*
 * mem_init - initialize the memory system model
 */
void mem_init(bool do_sparse) {
    sparse = do_sparse;
    if (sparse) {
        /* Want sparse total allocation to approximately match the dense heap
         * size */
        /* Account for both page itself and its amortized contribution to the
         * page table */
        double fbytes_per_page =
            sizeof(mem_block_t) + sizeof(mem_block_t *) / HASH_LOAD;
        num_pages = (size_t)(MAX_DENSE_HEAP / fbytes_per_page);
        num_buckets = (size_t)((double)num_pages / HASH_LOAD);
        mmap_length = num_buckets * sizeof(mem_block_t *) + // Page table
                      num_pages * sizeof(mem_block_t) +     // Pages
                      sizeof(uint64_t);                     // Padding
        setUBCheck(true);
    } else {
        /* Dense allocation */
        next_free_page = NULL;
        num_pages = 0;
        page_table = NULL;
        num_buckets = 0;
        mmap_length = MAX_DENSE_HEAP;
    }

    int dev_zero = open("/dev/zero", O_RDWR);
    void *start = sparse ? NULL : TRY_DENSE_HEAP_START;
    void *addr = mmap(start,                  /* suggested start*/
                      mmap_length,            /* length */
                      PROT_READ | PROT_WRITE, /* permissions */
                      MAP_PRIVATE,            /* private or shared? */
                      dev_zero,               /* fd */
                      0);                     /* offset */
    if (addr == MAP_FAILED) {
        fprintf(stderr, "FAILURE.  mmap couldn't allocate space for heap\n");
        exit(1);
    }
    if (sparse) {
        /* Use initial space for page table */
        page_table = (mem_block_t **)addr;
        heap = SPARSE_HEAP_START;
        mem_max_addr = heap + MAX_SPARSE_HEAP;
    } else {
        heap = addr;
        mem_max_addr = heap + MAX_DENSE_HEAP;
    }
    stats_printed = false;
    mem_brk = heap;
}

/*
 * mem_deinit - free the storage used by the memory system model
 */
void mem_deinit(void) {
    print_stats();
    munmap(heap, mmap_length);
    next_free_page = NULL;
    num_free_pages = 0;
    page_table = NULL;
    num_buckets = 0;
}

/*
 * mem_reset_brk - reset the simulated brk pointer to make an empty heap
 */
void mem_reset_brk(void) {
    print_stats();
    if (sparse) {
        /* Clear page table */
        size_t ptb = num_buckets * sizeof(mem_block_t *);
        memset((void *)page_table, 0, ptb);
        /* First page is just beyond page table */
        next_free_page = (mem_block_t *)((unsigned char *)page_table + ptb);
        num_free_pages = num_pages;
    } else {
#ifdef USE_ASAN
        /* Mark the entire heap as unaddressable */
        __asan_poison_memory_region(heap, MAX_DENSE_HEAP);
#endif
#ifdef USE_MSAN
        /* Mark global variables as uninitialized */
        markGlobalsUninit();

        /* Mark heap as uninitialized (though payloads may be overwritten by
         * driver!) */
        __msan_allocated_memory(heap, MAX_DENSE_HEAP);
#endif
    }
    mem_brk = heap;
}

/*
 * mem_sbrk - simple model of the sbrk function. Extends the heap
 *                by incr bytes and returns the start address of the new area.
 * In this model, the heap cannot be shrunk.
 */
void *mem_sbrk(intptr_t incr) {
    unsigned char *old_brk = mem_brk;

    bool ok = true;
    if (incr < 0) {
        ok = false;
        fprintf(stderr,
                "ERROR: mem_sbrk failed.  Attempt to expand heap by negative "
                "value %ld\n",
                (long)incr);
    } else if (mem_brk + incr > mem_max_addr) {
        ok = false;
        ptrdiff_t alloc = mem_brk - heap + incr;
        fprintf(stderr,
                "ERROR: mem_sbrk failed. Ran out of memory.  Would require "
                "heap size of %td (0x%zx) bytes\n",
                alloc, alloc);
    }
#if !defined DEBUG && !defined USE_MSAN && !defined USE_ASAN
    else if (!sparse && sbrk(incr) == (void *)-1) {
        ok = false;
        fprintf(
            stderr,
            "ERROR: mem_sbrk failed.  Could not allocate more heap space\n");
    }
#endif

    if (ok) {
#ifdef USE_ASAN
        /* Mark the extended section of the heap as addressable */
        __asan_unpoison_memory_region(mem_brk, (size_t)incr);
#endif
        mem_brk += incr;
        return (void *)old_brk;
    } else {
        errno = ENOMEM;
        return (void *)-1;
    }
}

/*
 * mem_heap_lo - return address of the first heap byte
 */
void *mem_heap_lo(void) {
    return (void *)heap;
}

/*
 * mem_heap_hi - return address of last heap byte
 */
void *mem_heap_hi(void) {
    return (void *)(mem_brk - 1);
}

/*
 * mem_heapsize() - returns the heap size in bytes
 */
size_t mem_heapsize(void) {
    return (size_t)(mem_brk - heap);
}

/*
 * mem_pagesize() - returns the page size of the system
 */
size_t mem_pagesize(void) {
    return (size_t)sysconf(_SC_PAGESIZE);
}

/*************** Memory emulation  *******************/

__int128_t mem_read128(const void *addr) {
    __int128_t r;
    r = (((__int128_t)mem_read((char *)addr + 8, 8)) << 64) | mem_read(addr, 8);

    return r;
}

void mem_write128(void *addr, __int128_t val) {
    mem_write(addr, (uint64_t)val, 8);
    mem_write((char *)addr + 8, (uint64_t)(val >> 64), 8);
}

/* Read len bytes and return value zero-extended to 64 bits */
uint64_t mem_read(const void *addr, size_t len) {
    uint64_t rdata;
    if (sparse && (unsigned char *)addr >= heap &&
        (unsigned char *)addr + len <= mem_brk) {
        /* Heap read.  Check if it crosses page boundary */
        size_t id = page_id(addr);
        void *paddr = get_mem(addr, len, false);
        rdata = *(uint64_t *)paddr;
        /* Check for split pages */
        void *maddr = (void *)((unsigned char *)addr + len - 1);
        if (id != page_id(maddr)) {
            void *saddr = page_start(id);
            ptrdiff_t offset = (unsigned char *)addr - (unsigned char *)saddr;
            assert(offset >= 0);
            size_t llen = SPARSE_PAGE_SIZE - (size_t)offset;
            /* Must zero out upper bytes of data */
            uint64_t mask = ((uint64_t)1 << (8 * llen)) - 1;
            rdata &= mask;
            void *haddr = (void *)((unsigned char *)addr + llen);
            void *hpaddr = get_mem(haddr, (len - llen), false);
            uint64_t hdata = *(uint64_t *)hpaddr;
            rdata = rdata | (hdata << (8 * llen));
        }
    } else {
        /*
         * Read directly from memory.  Correct for non-emulation and
         *  if the access is outside of the current heap bounds.
         *  Failure here commonly indicates a garbage pointer value or
         *  not updating the heap bounds properly.
         */
        memcpy(&rdata, addr, len);
    }
    if (len < sizeof(uint64_t)) {
        uint64_t mask = ((uint64_t)1 << (8 * len)) - 1;
        rdata &= mask;
    }
    return rdata;
}

/* Write lower order len bytes of val to address */
void mem_write(void *addr, uint64_t val, size_t len) {
    if (sparse && (unsigned char *)addr >= heap &&
        (unsigned char *)addr + len <= mem_brk) {
        /* Heap write.  Check to see if it crosses page boundary */
        size_t id = page_id(addr);
        void *paddr = get_mem(addr, len, true);
        void *saddr = page_start(id);
        ptrdiff_t offset = (unsigned char *)addr - (unsigned char *)saddr;
        assert(offset >= 0);
        size_t llen = SPARSE_PAGE_SIZE - (size_t)offset;
        if (llen < len) {
            /* Two page write */
            memcpy(paddr, (void *)&val, llen);
            size_t ulen = len - llen;
            void *haddr = (void *)((unsigned char *)addr + llen);
            void *hpaddr = get_mem(haddr, ulen, true);
            unsigned char *src = (unsigned char *)&val + llen;
            memcpy(hpaddr, (void *)src, ulen);
        } else {
            /* Single page write */
            if (len == sizeof(uint64_t))
                *(uint64_t *)paddr = val;
            else
                memcpy(paddr, (void *)&val, len);
        }
    } else {
        /*
         * Write directly to memory.  Correct for non-emulation and
         *  if the access is outside of the current heap bounds.
         *  Failure here commonly indicates a garbage pointer value or
         *  not updating the heap bounds properly.
         */
        if (len == sizeof(uint64_t))
            *(uint64_t *)addr = val;
        else
            memcpy(addr, (void *)&val, len);
    }
}

/* Emulation of memcpy */
void *mem_memcpy(void *dst, const void *src, size_t num_bytes) {
    void *savedst = dst;
    size_t word_size = sizeof(uint64_t);
    while (num_bytes >= word_size) {
        uint64_t data = mem_read(src, word_size);
        mem_write(dst, data, word_size);
        num_bytes -= word_size;
        src = (void *)((unsigned char *)src + word_size);
        dst = (void *)((unsigned char *)dst + word_size);
    }
    if (num_bytes) {
        uint64_t data = mem_read(src, num_bytes);
        mem_write(dst, data, num_bytes);
    }
    return savedst;
}

/* Emulation of memset */
void *mem_memset(void *dst, int c, size_t num_bytes) {
    void *savedst = dst;
    uint64_t byte = c & 0xFF;
    uint64_t data = 0;
    size_t word_size = sizeof(uint64_t);
    size_t i;
    for (i = 0; i < word_size; i++) {
        data = data | (byte << (8 * i));
    }
    while (num_bytes >= word_size) {
        mem_write(dst, data, word_size);
        num_bytes -= word_size;
        dst = (void *)((unsigned char *)dst + word_size);
    }
    if (num_bytes) {
        mem_write(dst, data, num_bytes);
    }
    return savedst;
}

/* Function to aid in viewing contents of heap */
void hprobe(void *ptr, int offset, size_t count) {
    unsigned char *cptr = (unsigned char *)ptr;
    unsigned char *cptr_lo = cptr + offset;
    unsigned char *cptr_hi = cptr_lo + count - 1;
    unsigned char *iptr;
    if (cptr_lo < (unsigned char *)mem_heap_lo()) {
        fprintf(stderr, "Invalid probe.  Address %p is below start of heap\n",
                (void *)cptr_lo);
        return;
    }
    if (cptr_hi > (unsigned char *)mem_heap_hi()) {
        fprintf(stderr, "Invalid probe.  Address %p is beyond end of heap\n",
                (void *)cptr_lo);
        return;
    }
    printf("Bytes %p...%p: 0x", (void *)cptr_hi, (void *)cptr_lo);

    bool cUBVal = checkUB;
    setUBCheck(false);
    for (iptr = cptr_hi; iptr >= cptr_lo; iptr--)
        printf("%.2x", (unsigned)mem_read((void *)iptr, 1));
    setUBCheck(cUBVal);
    printf("\n");
}

/*************** Private Functions *******************/

static void print_stats(void) {
    size_t vbytes = mem_heapsize();
    if (!show_stats || vbytes == 0 || stats_printed)
        return;
    if (sparse) {
        size_t ppages = num_pages - num_free_pages;
        size_t pbytes = ppages * SPARSE_PAGE_SIZE;
        printf("Allocated %zu/%zu pages (%zu bytes) to cover %zu heap bytes "
               "(%.4f%% density).  Max address = %p\n",
               ppages, num_pages, pbytes, vbytes,
               100.0 * (double)pbytes / (double)vbytes, (void *)mem_brk);
    } else {
        printf("Allocated %zu heap bytes.  Max address = %p\n", vbytes,
               (void *)mem_brk);
    }
    stats_printed = true;
}

/* Given an address, compute the ID  of its page */
static size_t page_id(const void *addr) {
    ptrdiff_t offset =
        (unsigned char *)addr - (unsigned char *)SPARSE_HEAP_START;
    assert(offset >= 0);
    return (size_t)offset / SPARSE_PAGE_SIZE;
}

/* Given a page ID, compute its starting address */
static void *page_start(size_t id) {
    size_t offset = id * SPARSE_PAGE_SIZE;
    return (void *)((unsigned char *)SPARSE_HEAP_START + offset);
}

/* Get memory to store value.  Allocate page if necessary */
static void *get_mem(const void *addr, size_t size, bool isWrite) {
    size_t id = page_id(addr);
    size_t b = id % num_buckets; // A very simple hash function
    unsigned int i;

    mem_block_t *block = page_table[b];
    while (block && block->id != id)
        block = block->next;
    if (!block) {
        /* Need to allocate a new block */
        if (num_free_pages == 0) {
            /*
             * This will often fail due to student code that either accesses
             *  too many memory locations, such as checking every byte in a
             *  block.  Or more commonly due to poor utilization, such as
             *  leaking or not finding the huge allocations.
             */
            fprintf(stderr, "FAILURE.  Ran out of memory for emulation\n");
            exit(1);
        }
        block = next_free_page++;
        num_free_pages--;
        block->id = id;
        block->next = page_table[b];
        for (i = 0; i < (SPARSE_PAGE_SIZE / 8); i++)
            block->initSet[i] = 0;
        page_table[b] = block;
    }

    // Convert an emulated address into an offset
    void *saddr = page_start(id);
    ptrdiff_t offset = (unsigned char *)addr - (unsigned char *)saddr;
    assert(offset >= 0);

#ifndef NO_CHECK_UB
    // Compute the bit vector lookup for this 'offset'
    size_t offsetIdx = (size_t)offset / 8;
    size_t offsetBit = (size_t)offset & 0x7ul;

    // For each byte in this access, update the bitvector that tracks
    //  the use / initialization of emulated bytes.
    for (i = 0; i < size; i++) {
        if (isWrite) {
            block->initSet[offsetIdx] |= (0x1 << offsetBit);
        } else if (checkUB &&
                   (block->initSet[offsetIdx] & (0x1 << offsetBit)) == 0) {
            // The student code has attempted to read an address that was
            //  never written to.  Students should set a breakpoint on this
            //  line / check and then backtrace to where their code has
            //  made the memory access.
            fprintf(stderr,
                    "Attempt to read uninitialized address %p, see %s:%d for "
                    "details\n",
                    (addr + i), __FILE__, __LINE__);
            abort();
        }
        offsetBit++;
        if (offsetBit == 8) {
            offsetBit = 0;
            offsetIdx++;
        }
        if (offsetIdx == (SPARSE_PAGE_SIZE / 8))
            break;
    }
#endif

    return (void *)&block->bytes[offset];
}
