/**
 * @file mm.h
 * @brief Provides an interface for the memory allocator used in malloclab
 */

#ifndef MM_H__
#define MM_H__ 1

#include <stdbool.h>
#include <stdio.h>

#ifdef DRIVER

/* declare functions for driver tests */
extern void *mm_malloc(size_t size);
extern void mm_free(void *ptr);
extern void *mm_realloc(void *ptr, size_t size);
extern void *mm_calloc(size_t nmemb, size_t size);

#else

/* declare functions for interpositioning */

/**
 * @brief  Allocate memory in the heap of at least `size` bytes.
 *
 * @param[in] size  The minimum size of bytes to allocate.
 *
 * @return  A pointer to the beginning of the allocated bytes.
 */
extern void *malloc(size_t size);

/**
 * @brief  Marks an allocated block as free.
 *
 * @param[in] ptr A pointer to the beginning of the allocated payload.
 */
extern void free(void *ptr);

/**
 * @brief  Resize an allocated block.
 *
 * @param[in] ptr  A pointer to the beginning of the allocated payload.
 * @param[in] size  The new size of the allocated block.
 *
 * @return  A pointer to the beginning of the allocated bytes.
 */
extern void *realloc(void *ptr, size_t size);

/**
 * @brief  Allocate an array of `nmemb` elements of `size` bytes each
 *
 * Allocate memory in the heap of at least `size` * `nmemb` bytes
 * initialized to all zeros.
 *
 * @param[in] nmemb  The number of elements in the array.
 * @param[in] size  The size of each element of the array.
 *
 * @return A pointer to the first element of the array.
 */
extern void *calloc(size_t nmemb, size_t size);
#endif

/**
 * @brief  Initialize the heap.
 *
 * @return  True on success, False otherwise.
 */
extern bool mm_init(void);

/* This is for debugging.  Returns false if error encountered */
/**
 * @brief  Check the heap for inconsistencies.
 *
 * @param[in] line  The line number this function is being called at.
 *
 * @return  True if the heap is consistent, False otherwise.
 */
extern bool mm_checkheap(int line);

#endif /* mm.h */
