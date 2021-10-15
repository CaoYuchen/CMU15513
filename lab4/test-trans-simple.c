/**
 * @file test-trans-simple.c
 * @brief Checks the student's transpose functions
 *
 * This program checks the correctness and performance of all of the
 * student's transpose functions and records the results for their
 * official submitted version as well.
 */

#define _XOPEN_SOURCE 600 // posix_memalign

#include <assert.h>
#include <errno.h>
#include <getopt.h>
#include <limits.h> // for LONG_MAX
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "cachelab.h"

/** @brief Results of testing the submitted transpose function */
static struct {
    int funcid;
    bool correct;
} results = {-1, false};

const char *__asan_default_options(void) {
    return "abort_on_error=true:detect_leaks=0";
}

const char *__ubsan_default_options(void) {
    return "abort_on_error=true:print_stacktrace=1";
}

/**
 * @brief Allocates aligned memory, exiting on failure
 */
void *xaligned_alloc(size_t alignment, size_t size) {
    void *ptr;
    int res = posix_memalign(&ptr, alignment, size);
    if (res != 0) {
        fprintf(stderr, "Failed to allocate memory: %s\n", strerror(res));
        exit(1);
    }
    return ptr;
}

/**
 * @brief Validates the correctness of one transpose function
 */
bool validate_func(int fn, size_t M, size_t N) {
    /* Allocate space for matrices */
    double(*A)[N][M] = xaligned_alloc(64, sizeof(*A));
    double(*B)[M][N] = xaligned_alloc(64, sizeof(*B));
    double(*T)[TMPCOUNT] = xaligned_alloc(64, sizeof(*T));
    double(*Acopy)[N][M] = xaligned_alloc(64, sizeof(*Acopy));

    /* Clear out matrices */
    memset(A, 0, sizeof(*A));
    memset(B, 0, sizeof(*B));
    memset(T, 0, sizeof(*T));
    memset(Acopy, 0, sizeof(*Acopy));

    /* Fill A with data */
    initMatrix(M, N, *A, *B);
    copyMatrix(M, N, *Acopy, *A);

    /* Invoke selected transpose function */
    (*func_list[fn].func_ptr)(M, N, *A, *B, *T);

    bool correct = true;

    /* Check correctness of transpose */
    for (size_t i = 0; i < M; i++) {
        for (size_t j = 0; j < N; j++) {
            if ((*B)[i][j] != (*Acopy)[j][i]) {
                fprintf(stderr,
                        "Validation failed on function %d! Expected %.3f but "
                        "got %.3f at B[%zd][%zd]\n",
                        fn, (*Acopy)[j][i], (*B)[i][j], i, j);
                correct = false;
                goto cleanup;
            }
        }
    }

    /* Look for changes to A */
    for (size_t j = 0; j < N; j++) {
        for (size_t i = 0; i < M; i++) {
            if ((*A)[j][i] != (*Acopy)[j][i]) {
                fprintf(
                    stderr,
                    "Validation failed on function %d! A[%zd][%zd] corrupted\n",
                    fn, i, j);
                correct = false;
                goto cleanup;
            }
        }
    }

cleanup:
    free(A);
    free(B);
    free(T);
    free(Acopy);
    return correct;
}

/**
 * @brief Evaluate the correctness of the registered transpose functions
 */
static void eval_trans(size_t M, size_t N, bool submission_only) {

    /* Evaluate the performance of each registered transpose function */
    for (int i = 0; i < func_counter; i++) {
        /* Remember if this function is the submission */
        if (strcmp(func_list[i].description, SUBMIT_DESCRIPTION) == 0) {
            results.funcid = i;
        }

        /* Skip testing non-submission functions */
        if (submission_only && results.funcid != i) {
            continue;
        }

        printf("Function %d (%s): ", i, func_list[i].description);

        bool correct = validate_func(i, M, N);
        if (!correct) {
            printf("Validation error at function %d!\n", i);
            continue;
        }

        printf("Correct\n");

        /* Save the correctness of the transpose submission */
        if (results.funcid == i) {
            results.correct = true;
        }
    }
}

/**
 * @brief Print usage info
 */
static void usage(char *argv[]) {
    printf("Usage: %s [-h] [-s] -M <rows> -N <cols>\n", argv[0]);
    printf("Options:\n");
    printf("  -h          Print this help message.\n");
    printf("  -s          Check official submission only.\n");
    printf("  -M <rows>   Number of destination matrix rows (max %d)\n", MAXN);
    printf("  -N <cols>   Number of destination matrix columns (max %d)\n",
           MAXN);
    printf("Example: %s -M 8 -N 8\n", argv[0]);
}

/**
 * @brief Main routine
 */
int main(int argc, char *argv[]) {
    int c;
    size_t M = 0;
    size_t N = 0;

    bool submission_only = false;

    while ((c = getopt(argc, argv, "hcsM:N:")) != -1) {
        switch (c) {
        case 'M':
            M = (size_t)atoi(optarg);
            break;
        case 'N':
            N = (size_t)atoi(optarg);
            break;
        case 's':
            submission_only = true;
            break;
        case 'h':
            usage(argv);
            exit(0);
        default:
            usage(argv);
            exit(1);
        }
    }

    if (M == 0 || N == 0) {
        printf("Error: Missing required argument\n");
        usage(argv);
        exit(1);
    }

    if (M > MAXN || N > MAXN) {
        printf("Error: M or N exceeds %d\n", MAXN);
        usage(argv);
        exit(1);
    }

    /* Register transpose functions */
    registerFunctions();

    /* Time out and give up after a while */
    alarm(360);

    /* Check the performance of the student's transpose function */
    eval_trans(M, N, submission_only);

    /* Emit the results for this particular test */
    if (results.funcid == -1) {
        printf("\nError: We could not find your transpose_submit() function\n");
        printf(
            "Error: Please ensure that description field is exactly \"%s\"\n",
            SUBMIT_DESCRIPTION);
    } else {
        printf("\nSummary for official submission (func %d): correctness=%d\n",
               results.funcid, results.correct);
    }
    return 0;
}
