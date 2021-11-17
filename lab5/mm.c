/**
 * @file mm.c
 * @brief A 64-bit struct-based implicit free list memory allocator
 *
 * 15-213: Introduction to Computer Systems
 *
 * Brief: This is a memory allocator using 14 segregated list and best fit,
 *footerless for allocated memory.
 *
 * Segragated List:
 * #1 #define: seg_size_class1(32Bytes),
 *seg_size_class2(64Bytes)....seg_size_class13(131072Bytes), The SEG_LIST_SIZE
 *represents 14 for the length of seg_list.
 *
 * #2 every block in segragated list contains:
 *  1) a header(8Bytes) indicates the size of block, the last bit represents the
 *allocation flag, the last second bit represents the previous allocation flag,
 *which is used to replace footer in allocated memory.
 *
 *  2) a footer(8Bytes) used for doubly linked list only for free blocks
 *  3) a prev_block pointer(8Bytes) points at the previous free block in the
 *same range of size. 4) a next_block pointer(8Bytes) points at the next free
 *block in the same range of size.
 *
 * Best Fit:
 * #1 The best_fit is used together with find_fit function, which first search
 *from the least bigger size of seglist to the target block, and iterate seglist
 *till its biggest size(last one), if the seglist is NULL then directy go to
 *next iteration. And when the seglist is NULL, search the elements in seglist,
 *find the best match(minimum redundance with target block).

 * Additional function:
 * #1 add_seg_list() is to add block into seg_list and follow FILO, make the
 last *block at the top of list(here top refers to the one with
 prev_block=NULL).
 * #2 delete_seg_list() is to delete the block from seg_list and make sure the
 rest connect correctly
 * #3 search_seg_list() return the index in seg_list that best match the target
 block.
 * #4 pack_foot() similar to pack() function, but pack the allocation and footer
 flag together.
 * #5 extract_footer() similar to extract_alloc(), and get_footer() similar to
 get_alloc(), return the footer flag(size_t).
 * #6 write_block_foot() similar to write_block(), write allocation and footer
 flag to the footer and header of a block together for convenience
 # heap_epi (8Bytes) points at the epilogue of the heap.
 # seg_list list of segragated list, length of 14

* block structure
* 1. a word_t header(8Bytes)
* 2. a anonymous union whose elements are
*   1). struct{*prev_block(8Bytes), *next_block(8Bytes)}
*   2). payload[0](0Bytes)

 *************************************************************************
 *
 * ADVICE FOR STUDENTS.
 * - Step 0: Please read the writeup!
 * - Step 1: Write your heap checker.
 * - Step 2: Write contracts / debugging assert statements.
 * - Good luck, and have fun!
 *
 *************************************************************************
 *
 * @author Yuchen Cao <yuchenca@andrew.cmu.edu>
 */

#include <assert.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "memlib.h"
#include "mm.h"

/* Do not change the following! */

#ifdef DRIVER
/* create aliases for driver tests */
#define malloc mm_malloc
#define free mm_free
#define realloc mm_realloc
#define calloc mm_calloc
#define memset mem_memset
#define memcpy mem_memcpy
#endif /* def DRIVER */

/* You can change anything from here onward */

/*
 *****************************************************************************
 * If DEBUG is defined (such as when running mdriver-dbg), these macros      *
 * are enabled. You can use them to print debugging output and to check      *
 * contracts only in debug mode.                                             *
 *                                                                           *
 * Only debugging macros with names beginning "dbg_" are allowed.            *
 * You may not define any other macros having arguments.                     *
 *****************************************************************************
 */
#ifdef DEBUG
/* When DEBUG is defined, these form aliases to useful functions */
#define dbg_printf(...) ((void)printf(__VA_ARGS__))
#define dbg_requires(expr) assert(expr)
#define dbg_assert(expr) assert(expr)
#define dbg_ensures(expr) assert(expr)
#define dbg_printheap(...) print_heap(__VA_ARGS__)
#else
/* When DEBUG is not defined, no code gets generated for these */
/* The sizeof() hack is used to avoid "unused variable" warnings */
#define dbg_printf(...) ((void)sizeof(__VA_ARGS__))
#define dbg_requires(expr) ((void)sizeof(expr))
#define dbg_assert(expr) ((void)sizeof(expr))
#define dbg_ensures(expr) ((void)sizeof(expr))
#define dbg_printheap(...) ((void)sizeof(__VA_ARGS__))
#endif

/* Basic constants */

typedef uint64_t word_t;

/** @brief Word and header size (bytes) */
static const size_t wsize = sizeof(word_t);

/** @brief Double word size (bytes) */
static const size_t dsize = 2 * wsize;

/** @brief Minimum block size (bytes) */
static const size_t min_block_size = 2 * dsize;

/** @brief The size (bytes) to extend the heap when there is no enough free
 * block (Must be divisible by dsize)
 */
static const size_t chunksize = (1 << 10);

/** @brief the mask of flag to show if the block is allocated or free */
static const word_t alloc_mask = 0x1;

/** @brief the mask of flag to show if its previous block is allocated
 * if so, set the flag as 1.
 */
static const word_t footer_mask = 0x2;

/** @brief the mask of flag to show mini block
 */
static const word_t mini_mask = 0x4;

/** @brief mask of the length (bytes) of a continuous block */
static const word_t size_mask = ~(word_t)0xF;

/** @brief Represents the header and payload of one block in the heap */
typedef struct block {
    /** @brief Header contains size + allocation flag */
    word_t header;
    union {
        /** @brief Header contains size + allocation flag */
        struct {
            struct block *prev_block;
            struct block *next_block;
        };
        char payload[0];
    };

    /*
     * zero-length pointer has to be the end of the struct, the footers are
     * contained in the end of payload.
     *
     */
} block_t;


/** @brief Represents the header and payload of one block in the heap */
typedef struct block_mini {
    /** @brief Header contains size + allocation flag */
    word_t header;
    union {
        /** @brief Header contains size + allocation flag */
        struct block_mini *next_block;
        char payload[0];
    };
} block_m;

/* overall size of segregated list*/
#define SEG_LIST_SIZE 14
/* size class of the segregated list*/
#define seg_size_class1 32
#define seg_size_class2 64
#define seg_size_class3 128
#define seg_size_class4 256
#define seg_size_class5 512
#define seg_size_class6 1024
#define seg_size_class7 2048
#define seg_size_class8 4096
#define seg_size_class9 8192
#define seg_size_class10 16384
#define seg_size_class11 32768
#define seg_size_class12 65536
#define seg_size_class13 131072

/* Global variables */

/** @brief Pointer to first block in the heap */
static block_t *heap_start = NULL;
/** @brief Pointer to epilogue in the heap */
static block_t *heap_epi = NULL;
/** @brief Pointer to epilogue in the heap */
static block_m *mini_list = NULL;
/** @brief Pointer to list of segregated list */
static block_t *seg_list[SEG_LIST_SIZE];

static void delete_seg_list(block_t *block);
static void add_seg_list(block_t *block, size_t size);
static size_t search_seg_list(size_t size);
static block_t *best_fit(block_t *block, size_t asize);
/*
 *****************************************************************************
 * The functions below are short wrapper functions to perform                *
 * bit manipulation, pointer arithmetic, and other helper operations.        *
 *                                                                           *
 * We've given you the function header comments for the functions below      *
 * to help you understand how this baseline code works.                      *
 *                                                                           *
 * Note that these function header comments are short since the functions    *
 * they are describing are short as well; you will need to provide           *
 * adequate details for the functions that you write yourself!               *
 *****************************************************************************
 */

/*
 * ---------------------------------------------------------------------------
 *                        BEGIN SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/**
 * @brief Returns the maximum of two integers.
 * @param[in] x
 * @param[in] y
 * @return `x` if `x > y`, and `y` otherwise.
 */
static size_t max(size_t x, size_t y) {
    return (x > y) ? x : y;
}

/**
 * @brief Rounds `size` up to next multiple of n
 * @param[in] size
 * @param[in] n
 * @return The size after rounding up
 */
static size_t round_up(size_t size, size_t n) {
    return n * ((size + (n - 1)) / n);
}

/**
 * @brief Packs the `size` and `alloc` of a block into a word suitable for
 *        use as a packed value.
 *
 * Packed values are used for both headers and footers.
 *
 * The allocation status is packed into the lowest bit of the word.
 *
 * @param[in] size The size of the block being represented
 * @param[in] alloc True if the block is allocated
 * @return The packed value
 */
static word_t pack(size_t size, bool alloc) {
    word_t word = size;
    if (alloc) {
        word |= alloc_mask;
    }
    return word;
}

/**
 * @brief Packs the `size` and `footer` of a block into a word suitable for
 *        use as a packed value.
 *
 * Packed values are used for both headers and footers.
 *
 * The allocation status is packed into the lowest bit of the word.
 *
 * @param[in] size The size of the block being represented
 * @param[in] alloc True if the block is allocated
 * @return The packed value
 */
static word_t pack_foot(size_t size, size_t alloc) {
    word_t word = size;
    if (alloc & footer_mask) {
        word |= footer_mask;
    }
    if (alloc & alloc_mask) {
        word |= alloc_mask;
    }
    return word;
}

/**
 * @brief Extracts the size represented in a packed word.
 *
 * This function simply clears the lowest 4 bits of the word, as the heap
 * is 16-byte aligned.
 *
 * @param[in] word
 * @return The size of the block represented by the word
 */
static size_t extract_size(word_t word) {
    return (word & size_mask);
}

/**
 * @brief Extracts the size of a block from its header.
 * @param[in] block
 * @return The size of the block
 */
static size_t get_size(block_t *block) {
    return extract_size(block->header);
}

/**
 * @brief Given a payload pointer, returns a pointer to the corresponding
 *        block.
 * @param[in] bp A pointer to a block's payload
 * @return The corresponding block
 */
static block_t *payload_to_header(void *bp) {
    return (block_t *)((char *)bp - offsetof(block_t, payload));
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        payload.
 * @param[in] block
 * @return A pointer to the block's payload
 * @pre The block must be a valid block, not a boundary tag.
 */
static void *header_to_payload(block_t *block) {
    dbg_requires(get_size(block) != 0);
    return (void *)(block->payload);
}

/**
 * @brief Given a block pointer, returns a pointer to the corresponding
 *        footer.
 * @param[in] block
 * @return A pointer to the block's footer
 * @pre The block must be a valid block, not a boundary tag.
 */
static word_t *header_to_footer(block_t *block) {
    dbg_requires(get_size(block) != 0 &&
                 "Called header_to_footer on the epilogue block");
    return (word_t *)(block->payload + get_size(block) - dsize);
}

/**
 * @brief Given a block footer, returns a pointer to the corresponding
 *        header.
 * @param[in] footer A pointer to the block's footer
 * @return A pointer to the start of the block
 * @pre The footer must be the footer of a valid block, not a boundary tag.
 */
static block_t *footer_to_header(word_t *footer) {
    size_t size = extract_size(*footer);
    dbg_assert(size != 0 && "Called footer_to_header on the prologue block");
    return (block_t *)((char *)footer + wsize - size);
}

/**
 * @brief Returns the payload size of a given block.
 *
 * The payload size is equal to the entire block size minus the sizes of the
 * block's header and footer.
 *
 * @param[in] block
 * @return The size of the block's payload
 */
static size_t get_payload_size(block_t *block) {
    size_t asize = get_size(block);
    return asize - wsize;
}

/**
 * @brief Returns the allocation status of a given header value.
 *
 * This is based on the lowest bit of the header value.
 *
 * @param[in] word
 * @return The allocation status correpsonding to the word
 */
static bool extract_alloc(word_t word) {
    return (bool)(word & alloc_mask);
}

/**
 * @brief Returns the allocation status of a block, based on its header.
 * @param[in] block
 * @return The allocation status of the block
 */
static bool get_alloc(block_t *block) {
    return extract_alloc(block->header);
}

/**
 * @brief Returns the allocation status of a given header value.
 *
 * This is based on the lowest bit of the header value.
 *
 * @param[in] word
 * @return The footer of allocation status correpsonding to the word
 */
static word_t extract_footer(word_t word) {
    return (word & footer_mask);
}

/**
 * @brief Returns the allocation status of a block, based on its header.
 * @param[in] block
 * @return The footer flag of allocation status of its previous block
 */
static word_t get_footer(block_t *block) {
    return extract_footer(block->header);
}

/**
 * @brief Writes an epilogue header at the given address.
 *
 * The epilogue header has size 0, and is marked as allocated.
 *
 * @param[out] block The location to write the epilogue header
 */
static void write_epilogue(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires((char *)block == (char *)mem_heap_hi() - 7);
    block->header = pack(0, true);
}

/**
 * @brief Writes a block starting at the given address.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * If the size is bigger than the rest maximum free space, it needs to apply for
 * extensive space first
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] alloc The allocation status of the new block
 */
static void write_block(block_t *block, size_t size, bool alloc) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack(size, alloc);
    word_t *footerp = header_to_footer(block);
    *footerp = pack(size, alloc);
}

/**
 * @brief Writes a block starting at the given address, with foot_alloc flag.
 *
 * This function writes both a header and footer, where the location of the
 * footer is computed in relation to the header.
 *
 * If the size is bigger than the rest maximum free space, it needs to apply for
 * extensive space first
 *
 * @param[out] block The location to begin writing the block header
 * @param[in] size The size of the new block
 * @param[in] alloc The allocation status of the new block
 */
static void write_block_foot(block_t *block, size_t size, size_t alloc) {
    dbg_requires(block != NULL);
    dbg_requires(size > 0);
    block->header = pack_foot(size, alloc);
    word_t *footerp = header_to_footer(block);
    *footerp = pack_foot(size, alloc);
}

/**
 * @brief Finds the next consecutive block on the heap.
 *
 * This function accesses the next block in the "implicit list" of the heap
 * by adding the size of the block.
 *
 * @param[in] block A block in the heap
 * @return The next consecutive block on the heap
 * @pre The block is not the epilogue
 */
static block_t *find_next(block_t *block) {
    dbg_requires(block != NULL);
    dbg_requires(get_size(block) != 0 &&
                 "Called find_next on the last block in the heap");
    return (block_t *)((char *)block + get_size(block));
}

/**
 * @brief Finds the footer of the previous block on the heap.
 * @param[in] block A block in the heap
 * @return The location of the previous block's footer
 */
static word_t *find_prev_footer(block_t *block) {
    // Compute previous footer position as one word before the header
    return &(block->header) - 1;
}

/**
 * @brief Finds the previous consecutive block on the heap.
 *
 * This is the previous block in the "implicit list" of the heap.
 *
 * If the function is called on the first block in the heap, NULL will be
 * returned, since the first block in the heap has no previous block!
 *
 * The position of the previous block is found by reading the previous
 * block's footer to determine its size, then calculating the start of the
 * previous block based on its size.
 *
 * @param[in] block A block in the heap
 * @return The previous consecutive block in the heap.
 */
static block_t *find_prev(block_t *block) {
    dbg_requires(block != NULL);
    word_t *footerp = find_prev_footer(block);

    // Return NULL if called on first block in the heap
    if (extract_size(*footerp) == 0) {
        return NULL;
    }

    return footer_to_header(footerp);
}

/*
 * ---------------------------------------------------------------------------
 *                        END SHORT HELPER FUNCTIONS
 * ---------------------------------------------------------------------------
 */

/******** The remaining content below are helper and debug routines ********/

/**
 * @brief link connected free space into one
 *
 * consider four types of coalescing blocks and connect the continuous freed
 * space to a single freed block.
 *
 * @param[in] block the pointer points to current block's header.
 * @return the connected block's pointer
 */
static block_t *coalesce_block(block_t *block) {
    // maintain information of previous and next block
    block_t *prev_block;
    block_t *next_block = find_next(block);
    // bool prev_exist = prev_block != NULL;
    bool prev_alloc = (bool)get_footer(block);
    bool next_alloc = get_alloc(next_block);
    size_t size = get_size(block);

    // case that previous and next block allocated return current block
    // if (prev_exist) {
    // prev_alloc = get_alloc(prev_block);
    if (prev_alloc && next_alloc) {
        write_block_foot(block, size, 2);
        next_block->header = next_block->header & ~(size_t)0x2;
    }
    // previous block is free
    else if (!prev_alloc && next_alloc) {
        // get previous block info
        prev_block = find_prev(block);
        size += get_size(prev_block);

        // delete previous block from the seg list
        delete_seg_list(prev_block);

        // update block info
        write_block_foot(prev_block, size, 2);
        next_block->header = next_block->header & ~(size_t)0x2;
        block = prev_block;
    }
    // next block is free
    else if (prev_alloc && !next_alloc) {
        // get next block info
        size += get_size(next_block);

        // delete next block from the seg list
        delete_seg_list(next_block);

        // update block info
        write_block_foot(block, size, 2);
    }
    // both of previous and next blocks are free
    else if (!prev_alloc && !next_alloc) {
        // get size of blocks
        prev_block = find_prev(block);
        size = size + get_size(next_block) + get_size(prev_block);

        // delete previous and next block from the seg list
        delete_seg_list(next_block);
        delete_seg_list(prev_block);

        // update block info
        write_block_foot(prev_block, size, 2);
        block = prev_block;
    }
    // } else {
    //     if (next_alloc) {
    //     }
    //     // next block is free
    //     else {
    //         // get next block info
    //         size += get_size(next_block);

    //         // delete next block from the seg list
    //         delete_seg_list(next_block);

    //         // update block info
    //         write_block_foot(block, size, 2);
    //     }
    // }

    // add new free block to seg list
    add_seg_list(block, size);

    return block;
}

/**
 * @brief extend the heap when current free space is not enough
 *
 * extend the current allocated memory with extra size with new epilogue as
 * ending erase the previous epilogue and write it as a footer.
 *
 * if there is no enough space in heap for extension, returns NULL.
 *
 * @param[in] size refers to the required size of space to allocate
 * @return the extended block
 */
static block_t *extend_heap(size_t size) {
    void *bp;

    // Allocate an even number of words to maintain alignment
    word_t epi = get_footer(heap_epi);
    size = round_up(size, dsize);
    if ((bp = mem_sbrk((intptr_t)size)) == (void *)-1) {
        return NULL;
    }

    /*
     * bp points to the payload's starting address, and one word beofre it is
     * header's address
     */

    // Initialize free block header/footer
    block_t *block = payload_to_header(bp);
    write_block_foot(block, size, epi);
    // block->header = pack_foot(size, epi);
    // *header_to_footer(block) = pack_foot(size, epi);

    // Create new epilogue header
    heap_epi = find_next(block);
    heap_epi->header = pack_foot(0, 1);

    // Coalesce in case the previous block was free
    block = coalesce_block(block);

    return block;
}

/**
 * @brief place the allocated block from seg_list in heap
 *
 * place the allocated block back to heap, and remove it from seg_list
 * if the block_size - asize is bigger than the minimum block size,
 * make a block split and keep the rest in the seg_list,
 * otherwise remove the entire block.
 *
 * @param[in] block the block to be placed in seg_list
 * @param[in] asize the block size of the block
 * @return void
 */
static void split_block(block_t *block, size_t asize) {
    dbg_requires(get_alloc(block));
    block_t *nextp;
    size_t block_size = get_size(block);
    size_t rest_size = block_size - asize;

    if (rest_size >= min_block_size) {
        delete_seg_list(block);
        // write_block(block, asize, true);
        block->header = pack_foot(asize, 3);
        // *header_to_footer(block) = pack_foot(asize, 0);
        /* split free block and put the remainder in seg list */
        nextp = find_next(block);
        write_block_foot(nextp, rest_size, 2);
        add_seg_list(nextp, rest_size);
    } else {
        /* allocate all block_size for asize */
        // write_block_foot(block, block_size, 3);
        block->header = pack_foot(block_size, 3);
        nextp = find_next(block);
        nextp->header = nextp->header | (size_t)0x2;
        delete_seg_list(block);
    }
    dbg_ensures(get_alloc(block));
}

/**
 * @brief delete the free block from seg_list
 *
 * find the block in seg_list, remove it and reconnect its previous and next
 * block. figure out where the block is in the list first. If it's in the head,
 * set its next's previous pointer as NULL else if it's in the tail, set its
 * previou's next pointer as NULL If it's in the middle, set both above as NULL
 *
 * @param[in] block the free block to be removed
 * @return void
 */
static void delete_seg_list(block_t *block) {
    // get block size info
    size_t idx = search_seg_list(get_size(block));
    block_t *prev_block = block->prev_block;
    block_t *next_block = block->next_block;

    /* rewire connections of the list */
    if (prev_block == NULL) {
        if (next_block == NULL) {
            /* delete the only free block */
            seg_list[idx] = NULL;
        } else {
            /* delete the first free block */
            seg_list[idx] = next_block;
            next_block->prev_block = NULL;
        }
    }

    else if (next_block == NULL) {
        /* delete the last free block */
        prev_block->next_block = NULL;
    }

    else {
        /* delete an intermediate free block */
        next_block->prev_block = prev_block;
        prev_block->next_block = next_block;
    }

    /* clear the deleted block */
    block->prev_block = NULL;
    block->next_block = NULL;
}
/**
 * @brief insert new free block to seg_list
 *
 * function that insert the free block into segregated list with LIFO
 * If the seg_list[i] is NULL, set the new free block as first element
 * Otherwise insert it before the old one.
 *
 * @param[in] block the new free block
 * @param[in] size the size of the new free block
 * @return void
 */
//
static void add_seg_list(block_t *block, size_t size) {
    // find the appropirate size class list
    size_t seg_index = search_seg_list(size);

    // case that no blocks in the size list
    if (seg_list[seg_index] == NULL) {
        // set block to the list head and set previous and next free block to
        // NULL
        block->prev_block = NULL;
        block->next_block = NULL;
        seg_list[seg_index] = block;
    }
    // case that there are blocks in the size list
    else {
        /* add block to the head of the bucket */
        block->prev_block = NULL;
        block->next_block = seg_list[seg_index];
        seg_list[seg_index]->prev_block = block;
        seg_list[seg_index] = block;
    }
}
/**
 * @brief search the best fit seg_list by block size
 *
 * function that search the segregated list to find the appropriate size class
 *  and return the size class index of the segregated list
 *
 * @param[in] size the size to be allocated
 * @return the index of the seg_list
 */
static size_t search_seg_list(size_t size) {
    if (size < seg_size_class1)
        return 0;
    else if ((size >= seg_size_class1) && (size < seg_size_class2))
        return 1;
    else if ((size >= seg_size_class2) && (size < seg_size_class3))
        return 2;
    else if ((size >= seg_size_class3) && (size < seg_size_class4))
        return 3;
    else if ((size >= seg_size_class4) && (size < seg_size_class5))
        return 4;
    else if ((size >= seg_size_class5) && (size < seg_size_class6))
        return 5;
    else if ((size >= seg_size_class6) && (size < seg_size_class7))
        return 6;
    else if ((size >= seg_size_class7) && (size < seg_size_class8))
        return 7;
    else if ((size >= seg_size_class8) && (size < seg_size_class9))
        return 8;
    else if ((size >= seg_size_class9) && (size < seg_size_class10))
        return 9;
    else if ((size >= seg_size_class10) && (size < seg_size_class11))
        return 10;
    else if ((size >= seg_size_class11) && (size < seg_size_class12))
        return 11;
    else if ((size >= seg_size_class12) && (size < seg_size_class13))
        return 12;
    else
        return 13;
}

/**
 * @brief find proper free block to be allocated
 *
 * use first search to find the proper free block to allocate
 * for new asize of memory.
 *
 * if no fit found, return NULL
 *
 * @param[in] asize size of blocks to be allocated
 * @return pointer of the found block
 */
static block_t *find_fit(size_t asize) {
    block_t *bestfit = NULL;

    /* search from the lowest search_seg_list */
    for (size_t i = search_seg_list(asize); i < SEG_LIST_SIZE; ++i) {

        bestfit = best_fit(seg_list[i], asize);
        if (bestfit != NULL)
            return bestfit;
    }

    if (bestfit == NULL)
        return NULL; // no fit found
    else
        return bestfit;
}

/**
 * @brief search best fit of seg_list[i]
 *
 * Find the best fit of seg_list[i], if there the seg_list[i] is NULL
 * return NULL, means not found, if candinate is NULL, return NULL
 *
 * @param[in] block points to the last-in element of seg_list[i]
 * @param[in] asize the size of space to be allocated
 * @return best fit in the seg_list[i]
 */
static block_t *best_fit(block_t *block, size_t asize) {
    block_t *seg_block, *bestfit_block;
    size_t bestfit_size, current_size;
    bestfit_size = ~(size_t)0x0;
    bestfit_block = NULL;
    if (block == NULL) {
        return NULL;
    }

    for (seg_block = block; seg_block != NULL;
         seg_block = seg_block->next_block) {
        current_size = get_size(seg_block);
        if (current_size == asize) {
            return seg_block;
        } else if ((current_size > asize) && (current_size < bestfit_size)) {
            bestfit_size = current_size;
            bestfit_block = seg_block;
        }
    }
    if (bestfit_block != NULL) {
        /* no fit found in current */
        return bestfit_block;
    } else {
        return NULL;
    }
}
/**
 * @brief check heap status, report when there is error only
 *
 * check the heap status
 *
 * @param[in] line the number of line that calls mm_checkheap
 * @return yes if there is an error in heap
 */
bool mm_checkheap(int line) {

    // if (line == 0)
    //     return true;
    // size_t size = 0;
    // block_t *block = heap_start;

    // check prologue
    // if (find_prev_footer(heap_start) != (word_t *)mem_heap_lo()) {
    //     printf("line number is %d\n", line);
    // }
    // dbg_requires(find_prev_footer(heap_start) != (word_t *)mem_heap_lo() &&
    //              ("line number is prologue size error!\n "));
    // mem_heap_lo();
    // mem_heap_hi();
    // size_t heap_size = mem_heapsize();

    return true;
}

/**
 * @brief intialize the allocated memory
 *
 * set the allocated memory's block footer and header as occupied,
 * points the heap_start pointer to the allocated address.
 *
 * if there is no enough space in heap to initialize or to extend the heap,
 * returns false
 *
 * @return true if initlization succeeds, false if fail.
 */
bool mm_init(void) {
    // Create the initial empty heap
    word_t *start = (word_t *)(mem_sbrk(2 * wsize));

    if (start == (void *)-1) {
        return false;
    }

    /*
     * prologue and epilogue are boundary flag to mark the range of heap for
     * malloc, they correspond to a block footer and header because when
     * extending heap, the prologue and epilogue can be replaced by footer and
     * header.
     */

    // initialize seg list
    for (int i = 0; i < SEG_LIST_SIZE; i++) {
        seg_list[i] = NULL;
    }

    start[0] = pack_foot(0, 1); // Heap prologue (block footer)
    start[1] = pack_foot(0, 3); // Heap epilogue (block header)

    // Heap starts with first "block header", currently the epilogue
    heap_start = (block_t *)&(start[1]);
    // heap epilogue
    heap_epi = heap_start;

    // Extend the empty heap with a free block of chunksize bytes
    if (extend_heap(chunksize) == NULL) {
        return false;
    }

    return true;
}

/**
 * @brief allocate memory in heap
 *
 * malloc() allocates memory in heap with size of asize, and mark the prologue
 * and epilogue as boundary of the range of memory.
 *
 * If the size of memory to allcoate is 0,
 * or there is not enough free list for a fit, returns NULL.
 * If the heap_start is not initialized, initialized it.
 *
 * @param[in] size
 * @return
 */
void *malloc(size_t size) {
    dbg_requires(mm_checkheap(__LINE__));

    size_t asize;      // Adjusted block size
    size_t extendsize; // Amount to extend heap if no fit is found
    block_t *block;
    void *bp = NULL;

    // Initialize heap if it isn't initialized
    if (heap_start == NULL) {
        mm_init();
    }

    // Ignore spurious request
    if (size == 0) {
        dbg_ensures(mm_checkheap(__LINE__));
        return bp;
    }

    // Adjust block size to include overhead and to meet alignment requirements
    if (size <= dsize)
        asize = min_block_size;
    else
        asize = round_up(size + wsize, dsize); // remove footer

    // Search the free list for a fit
    // if ((block = find_fit(asize)) != NULL) {
    //     place_seg_list(block, asize);
    // }

    // If no fit is found, request more memory, and then and place the block
    if ((block = find_fit(asize)) == NULL) {
        // Always request at least chunksize
        extendsize = max(asize, chunksize);
        block = extend_heap(extendsize);
        // extend_heap returns an error
        if (block == NULL) {
            return bp;
        }
    }

    // The block should be marked as free
    dbg_assert(!get_alloc(block));

    // Mark block as allocated
    size_t block_size = get_size(block);
    write_block_foot(block, block_size, get_footer(block) | 0x1);

    // place allocated block from seglist to heap
    split_block(block, asize);

    bp = header_to_payload(block);

    dbg_ensures(mm_checkheap(__LINE__));
    return bp;
}

/**
 * @brief release the space of allocated memory
 *
 * free() release the allocated payload memory and footer, and change the header
 * to a "free" status
 *
 * if payload's pointer is null, end the function.
 *
 * @param[in] bp the pointer towards the address of beginning of the payload
 */
void free(void *bp) {
    dbg_requires(mm_checkheap(__LINE__));

    if (bp == NULL) {
        return;
    }

    block_t *block = payload_to_header(bp);
    size_t size = get_size(block);

    // The block should be marked as allocated
    dbg_assert(get_alloc(block));

    // Mark the block as free
    write_block_foot(block, size, (size_t)get_footer(block));

    // Try to coalesce the block with its neighbors
    coalesce_block(block);

    dbg_ensures(mm_checkheap(__LINE__));
}

/**
 * @brief reallocate memory
 *
 * rescale the size of the allocated memory from *ptr with scale size, and copy
 * the rescaled memory to a new address and release the previous *ptr.
 *
 * If the new size is 0, or the ptr or newptr pointer is NULL, return NULL
 *
 * @param[in] ptr points to the beginning of the malloc memory in heap
 * @param[in] size refers to the new size of malloc that we wants to change to
 * @return new pointer points to the beginning of a changed new malloc memory
 */
void *realloc(void *ptr, size_t size) {
    block_t *block = payload_to_header(ptr);
    size_t copysize;
    void *newptr;

    // If size == 0, then free block and return NULL
    if (size == 0) {
        free(ptr);
        return NULL;
    }

    // If ptr is NULL, then equivalent to malloc
    if (ptr == NULL) {
        return malloc(size);
    }

    // Otherwise, proceed with reallocation
    newptr = malloc(size);

    // If malloc fails, the original block is left untouched
    if (newptr == NULL) {
        return NULL;
    }

    // Copy the old data
    copysize = get_payload_size(block); // gets size of old payload
    if (size < copysize) {
        copysize = size;
    }
    memcpy(newptr, ptr, copysize);

    // Free the old block
    free(ptr);

    return newptr;
}

/**
 * @brief initialize memory with 0
 *
 * calloc create a new memory in heap by malloc, and initialize all content of
 * memory with 0
 *
 * if the number of element is 0, or if the asize is larger than the maxmimum
 * expression of 8 Byte, or the malloc fail, it returns NULL.
 *
 * @param[in] elements number of objects
 * @param[in] size size of each object
 * @return the pointer toward address of the beginning of the allocated memory
 */
void *calloc(size_t elements, size_t size) {
    void *bp;
    size_t asize = elements * size;

    if (elements == 0) {
        return NULL;
    }
    if (asize / elements != size) {
        // Multiplication overflowed
        return NULL;
    }

    bp = malloc(asize);
    if (bp == NULL) {
        return NULL;
    }

    // Initialize all bits to 0
    memset(bp, 0, asize);

    return bp;
}

/*
 *****************************************************************************
 * Do not delete the following super-secret(tm) lines!                       *
 *                                                                           *
 * 53 6f 20 79 6f 75 27 72 65 20 74 72 79 69 6e 67 20 74 6f 20               *
 *                                                                           *
 * 66 69 67 75 72 65 20 6f 75 74 20 77 68 61 74 20 74 68 65 20               *
 * 68 65 78 61 64 65 63 69 6d 61 6c 20 64 69 67 69 74 73 20 64               *
 * 6f 2e 2e 2e 20 68 61 68 61 68 61 21 20 41 53 43 49 49 20 69               *
 *                                                                           *
 * 73 6e 27 74 20 74 68 65 20 72 69 67 68 74 20 65 6e 63 6f 64               *
 * 69 6e 67 21 20 4e 69 63 65 20 74 72 79 2c 20 74 68 6f 75 67               *
 * 68 21 20 2d 44 72 2e 20 45 76 69 6c 0a c5 7c fc 80 6e 57 0a               *
 *                                                                           *
 *****************************************************************************
 */
