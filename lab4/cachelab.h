/**
 * @file cachelab.h
 * @brief Prototypes for Cache Lab helper functions
 */

#ifndef CACHELAB_TOOLS_H
#define CACHELAB_TOOLS_H

#include <stdbool.h>
#include <stdlib.h>

/**
 * @brief Struct representing simulation statistics for a trace
 */
typedef struct {
    unsigned long hits;            /* number of hits */
    unsigned long misses;          /* number of misses */
    unsigned long evictions;       /* number of evictions */
    unsigned long dirty_bytes;     /* number of dirty bytes in cache at end */
    unsigned long dirty_evictions; /* number of evictions of dirty lines */
} csim_stats_t;

/** @brief Store a summary of the cache simulation statistics. */
void printSummary(const csim_stats_t *stats);

/* @brief Load the stored summary of the cache simulation statistics. */
bool loadSummary(csim_stats_t *stats);

/* Grading parameters for transpose */

/** @brief Number of clock cycles for hit */
#define HIT_CYCLES 4

/** @brief Number of clock cycles for miss */
#define MISS_CYCLES 100

/** @brief Log number of sets */
#define TEST_LOG_SET 5

/** @brief Associativity */
#define TEST_ASSOC 1

/** @brief Log number of bytes / block */
#define TEST_LOG_BLOCK 6

/** @brief Number of sets for Haswell L1 Cache */
#define HASWELL_L1_SET 6

/** @brief Haswell L1 Associativity */
#define HASWELL_L1_ASSOC 8

/** @brief Haswell L1 number of bytes / block */
#define HASWELL_L1_BLOCK 6

/** @brief Maximum number of transpose functions that can be registered */
#define MAX_TRANS_FUNCS 100

/** @brief The description string for the transpose_submit() function that the
           student submits for credit */
#define SUBMIT_DESCRIPTION "Transpose submission"

/** @brief Maximum value of M or N in transpose functions */
#define MAXN 4096

/**
 * @brief Number of temp's allocated in temp array.
 *
 * Designed to fill cache to capacity
 */
#define TMPCOUNT 256

/**
 * @brief Struct representing the execution state of a transpose function
 */
typedef struct trans_func {
    void (*func_ptr)(size_t M, size_t N, double[N][M], double[M][N], double *);
    const char *description;
} trans_func_t;

/* External variables defined in cachelab.c */
extern trans_func_t func_list[MAX_TRANS_FUNCS];
extern int func_counter;

/* External function defined in trans.c */
extern void registerFunctions(void);

/** @brief Fills a matrix with data */
void initMatrix(size_t M, size_t N, double A[N][M], double B[M][N]);

/** @brief Makes a copy of a matrix */
void copyMatrix(size_t M, size_t N, double Adst[N][M], double Asrc[N][M]);

/** @brief The baseline trans function that produces correct results. */
void correctTrans(size_t M, size_t N, double A[N][M], double B[M][N]);

/** @brief Adds a transpose function to the function list */
void registerTransFunction(void (*trans)(size_t M, size_t N, double[N][M],
                                         double[M][N], double *),
                           const char *desc);

#endif /* CACHELAB_TOOLS_H */
