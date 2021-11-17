/**
 * @file memlib.h
 * @brief Support functions to assist with malloclab
 *
 * This file exists to support the emulated mode of malloclab. Much more
 * extensive documentation exists in memlib.c.
 */
#ifndef MEMLIB_H__
#define MEMLIB_H__ 1

#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>

/**
 * @brief
 * @param[in] sparse
 */
void mem_init(bool sparse);

/**
 * @brief
 */
void mem_deinit(void);

/**
 * @brief Extends the heap by incr bytes.
 *
 * This function is a simple model of the sbrk() function, except for that
 * with this implementation, the heap cannot be shrunk.
 *
 * @param[in] incr The amount of bytes by which to extend the heap
 * @return The start address of the new heap area (i.e. the previous
 *         breakpoint)
 * @pre `incr > 0`
 */
void *mem_sbrk(intptr_t incr);

/**
 * @brief Resets the simulated brk pointer to make an empty heap.
 */
void mem_reset_brk(void);

/**
 * @brief Finds the low address of the heap.
 * @return The address of the first valid byte in the heap.
 */
void *mem_heap_lo(void);

/**
 * @brief Finds the high address of the heap.
 *
 * Note that this address may not be aligned: if the heap is 8 bytes large,
 * then the value returned will be 7 bytes from the start of the heap.
 *
 * @return The address of the last valid byte in the heap.
 */
void *mem_heap_hi(void);

/**
 * @brief Returns the number of bytes being used by the heap.
 * @return The size of the heap, in bytes
 */
size_t mem_heapsize(void);

/**
 * @brief Returns the system page size.
 * @return The page size of the system, in bytes
 */
size_t mem_pagesize(void);

/* Functions used for memory emulation */

/**
 * @brief Performs a simulated memory read at an address.
 * @param[in] addr Simulated memory address to read from
 * @param[in] len  Number of bytes to read
 * @return The value read at the address, zero-extended to 64 bits
 * @pre `0 <= len && len <= 8`
 */
uint64_t mem_read(const void *addr, size_t len);

/**
 * @brief Performs a simulated 128-bit memory read at an address.
 * @param[in] addr Simulated memory address to read from
 * @return The value read at the address
 */
__int128_t mem_read128(const void *addr);

/**
 * @brief Performs a simulated memory write at an address.
 * @param[in] addr Simulated memory address to write to
 * @param[in] val  Value to write (the lower-order `len` bits are used)
 * @param[in] len  The number of bytes to write
 * @pre `0 <= len && len <= 8`
 */
void mem_write(void *addr, uint64_t val, size_t len);

/*
 * @brief Performs a simulated 128-bit memory write at an address.
 * @param[in] addr Simulated memory address to write to
 * @param[in] val  Value to write
 */
void mem_write128(void *addr, __int128_t val);

/**
 * @brief Emulation of memcpy
 * @param[in] dst
 * @param[in] src
 * @param[in] n
 * @return
 */
void *mem_memcpy(void *dst, const void *src, size_t n);

/**
 * @brief Emulation of memset
 * @param[in] dst
 * @param[in] c
 * @param[in] n
 * @return
 */
void *mem_memset(void *dst, int c, size_t n);

/**
 * @brief Debugging function to view region of heap
 * @param[in] ptr
 * @param[in] offset
 * @param[in] count
 */
void hprobe(void *ptr, int offset, size_t count);

/**
 * @brief Set whether the driver should check for UB
 */
void setUBCheck(bool);

#endif /* memlib.h */
