/**
 * @file cachelab.c
 * @brief Cache Lab helper functions
 */
#include <assert.h>
#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#include "cachelab.h"

trans_func_t func_list[MAX_TRANS_FUNCS];
int func_counter = 0;

/**
 * @brief Store a summary of the cache simulation statistics.
 *
 * Student cache simulators must call this function in order to
 * be properly autograded.
 *
 * @param[in] stats The simulation statistics to be stored
 */
void printSummary(const csim_stats_t *stats) {
    printf("hits:%ld misses:%ld evictions:%ld dirty_bytes_in_cache:%ld "
           "dirty_bytes_evicted:%ld\n",
           stats->hits, stats->misses, stats->evictions, stats->dirty_bytes,
           stats->dirty_evictions);

    FILE *output_fp = fopen(".csim_results", "w");
    if (output_fp == NULL) {
        fprintf(stderr, "Error: failed to open results file: %s\n",
                strerror(errno));
        return;
    }

    fprintf(output_fp, "%ld %ld %ld %ld %ld\n", stats->hits, stats->misses,
            stats->evictions, stats->dirty_bytes, stats->dirty_evictions);
    fclose(output_fp);
}

/**
 * @brief Load the stored summary of the cache simulation statistics.
 *
 * @param[out] stats The simulation statistics that were read
 *
 * @return True if the operation was successful, false otherwise
 */
bool loadSummary(csim_stats_t *stats) {
    /* Get the results from the simulator */
    FILE *fp = fopen(".csim_results", "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed to open .csim_results: %s\n", strerror(errno));
        return false;
    }

    if (fscanf(fp, "%lu %lu %lu %lu %lu", &stats->hits, &stats->misses,
               &stats->evictions, &stats->dirty_bytes,
               &stats->dirty_evictions) < 5) {
        fprintf(stderr, "Error: Results for csim not formatted correctly\n");
        fclose(fp);
        return false;
    }

    fclose(fp);
    return true;
}

/**
 * @brief Initialize the given matrices
 */
void initMatrix(size_t M, size_t N, double A[N][M], double B[M][N]) {
    size_t i, j;
    srand((unsigned int)time(NULL));
    for (i = 0; i < N; i++) {
        for (j = 0; j < M; j++) {
            /* Initialize with data that can't be represented as int or float */
            A[i][j] = (double)rand() / 8.0 + 1e10;
            B[j][i] = (double)rand() / 8.0 + 1e10;
        }
    }
}

/**
 * @brief Make a copy of a matrix
 */
void copyMatrix(size_t M, size_t N, double Adst[N][M], double Asrc[N][M]) {
    size_t i, j;
    for (i = 0; i < N; i++)
        for (j = 0; j < M; j++)
            Adst[i][j] = Asrc[i][j];
}

/**
 * @brief baseline transpose function used to evaluate correctness
 */
void correctTrans(size_t M, size_t N, double A[N][M], double B[M][N]) {
    size_t i, j;
    double tmp;
    for (i = 0; i < N; i++) {
        for (j = 0; j < M; j++) {
            tmp = A[i][j];
            B[j][i] = tmp;
        }
    }
}

/*
 * @brief Add the given trans function into your list of functions to be tested
 */
void registerTransFunction(void (*trans)(size_t M, size_t N, double[N][M],
                                         double[M][N], double *T),
                           const char *desc) {
    func_list[func_counter].func_ptr = trans;
    func_list[func_counter].description = desc;
    func_counter++;
}
