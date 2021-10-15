/**
 * @file test-trans.c
 * @brief Checks the student's transpose functions
 *
 * This program checks the correctness and performance of all of the
 * student's transpose functions and records the results for their
 * official submitted version as well.
 */

#include <assert.h>
#include <errno.h>
#include <getopt.h>
#include <limits.h> // for LONG_MAX
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h> // for WEXITSTATUS
#include <unistd.h>

#include "cachelab.h"

#define CMD_BUFSIZE 334
#define FILENAME_BUFSIZE 255

/* Globals set on the command line */
static size_t M = 0;
static size_t N = 0;

/** @brief Results of testing the submitted transpose function */
static struct {
    int funcid;
    bool correct;
    csim_stats_t stats;
} results = {-1, false, {LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX}};

/**
 * @brief Calculates the number of clock cycles for the trace
 */
static unsigned long get_clock_cycles(unsigned long hits,
                                      unsigned long misses) {
    return HIT_CYCLES * hits + MISS_CYCLES * misses;
}

/**
 * @brief Generates a trace file for a specific transpose function.
 *
 * @param[in] file_name File name where the trace should be stored
 * @param[in] i         Index of the transpose function to use
 *
 * @return True if the function succeeded, and false otherwise
 */
static bool generate_trace(const char *file_name, int i) {
    char cmd[CMD_BUFSIZE];
    snprintf(cmd, sizeof(cmd),
             "CONTECH_TRACE=%s ./tracegen-ct -M %ld -N %ld -F %d", file_name, M,
             N, i);

    int status = system(cmd);
    if (status < 0) {
        printf("Failed to run tracegen-ct: %s\n", strerror(errno));
        return false;
    }

    if (!WIFEXITED(status)) {
        printf("Internal error: ./tracegen-ct aborted for unknown "
               "reason (status %x).\n",
               status);
        printf("Command run: %s\n", cmd);
        return false;
    }

    if (WEXITSTATUS(status) != 0) {
        printf("Validation error at function %d! Run ./tracegen-ct -v -M "
               "%zd -N %zd -F %d for details.\n",
               i, M, N, i);
        printf("Exit status %d\n", WEXITSTATUS(status));
        return false;
    }

    return true;
}

/**
 * @brief Compute statistics for a trace using the reference simulator.
 *
 * @param[in]  file_name File name where the trace is be stored
 * @param[in]  s         log2 of the number of sets
 * @param[in]  E         associativity
 * @param[in]  b         log2 of the block size
 * @param[out] stats     Statistics computed from the trace file
 *
 * @return True if the function succeeded, and false otherwise
 */
static bool compute_stats(const char *file_name, unsigned int s, unsigned int E,
                          unsigned int b, csim_stats_t *stats) {
    char cmd[CMD_BUFSIZE];
    snprintf(cmd, sizeof(cmd), "./csim-ref -s %u -E %u -b %u -t %s > /dev/null",
             s, E, b, file_name);

    int status = system(cmd);
    if (status < 0) {
        printf("Failed to run csim-ref: %s\n", strerror(errno));
        return false;
    }

    int flag = WEXITSTATUS(status);
    if (flag != 0) {
        printf("Cache simulator error.  The reference simulator exited "
               "with value %d\n",
               flag);
        return false;
    }

    /* Collect results from the reference simulator */
    bool success = loadSummary(stats);
    if (!success) {
        printf("Cache simulator error.  Simulator generated invalid "
               "results\n");
        return false;
    }

    return true;
}

/**
 * @brief Evaluate the performance of the registered transpose functions
 */
static void eval_perf(unsigned int s, unsigned int E, unsigned int b,
                      bool submission_only) {

    registerFunctions();

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

        /* Run and generate a trace file */
        char file_name[FILENAME_BUFSIZE];
        sprintf(file_name, "trace.f%d", i);

        printf("\nFunction %d out of %d (%s)\n", i, func_counter,
               func_list[i].description);
        printf("Step 1: Validating and generating memory traces\n");

        if (!generate_trace(file_name, i)) {
            continue;
        }

        /* Run the reference simulator */
        csim_stats_t stats;

        printf("Step 2: Evaluating performance (s=%d, E=%d, b=%d)\n", s, E, b);
        if (!compute_stats(file_name, s, E, b, &stats)) {
            continue;
        }

        (void)remove(".csim_results");

        /* Mark this function as correct */
        printf("Results for func %d (%s): hits:%ld, misses:%ld, evictions:%ld, "
               "clock_cycles:%ld\n",
               i, func_list[i].description, stats.hits, stats.misses,
               stats.evictions, get_clock_cycles(stats.hits, stats.misses));

        /* If it is transpose_submit(), record number of misses */
        if (results.funcid == i) {
            memcpy(&results.stats, &stats, sizeof(results.stats));
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
    printf("  -l          Simulate large (Haswell L1) cache\n");
    printf("  -M <rows>   Number of destination matrix rows (max %d)\n", MAXN);
    printf("  -N <cols>   Number of destination matrix columns (max %d)\n",
           MAXN);
    printf("Example: %s -M 8 -N 8\n", argv[0]);
}

/**
 * @brief SIGSEGV handler
 */
static void sigsegv_handler(int signum) {
    const char *msg = "Error: Segmentation Fault.\n"
                      "TEST_TRANS_RESULTS=0:0\n";
    ssize_t res = write(STDOUT_FILENO, msg, strlen(msg));
    (void)res;
    _exit(1);
}

/**
 * @brief SIGALRM handler
 */
static void sigalrm_handler(int signum) {
    const char *msg = "Error: Program timed out.\n"
                      "TEST_TRANS_RESULTS=0:0\n";
    ssize_t res = write(STDOUT_FILENO, msg, strlen(msg));
    (void)res;
    _exit(1);
}

/**
 * @brief Main routine
 */
int main(int argc, char *argv[]) {
    int status;
    int c;

    bool submission_only = false;
    bool use_large_cache = false;

    while ((c = getopt(argc, argv, "hcslM:N:")) != -1) {
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
        case 'l':
            use_large_cache = true;
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

    /* Install SIGSEGV and SIGALRM handlers */
    if (signal(SIGSEGV, sigsegv_handler) == SIG_ERR) {
        fprintf(stderr, "Unable to install SIGALRM handler\n");
        exit(1);
    }

    if (signal(SIGALRM, sigalrm_handler) == SIG_ERR) {
        fprintf(stderr, "Unable to install SIGALRM handler\n");
        exit(1);
    }

    /* Time out and give up after a while */
    alarm(360);

    /* Check the performance of the student's transpose function */
    if (use_large_cache) {
        /* Use Haswell L1 cache */
        eval_perf(HASWELL_L1_SET, HASWELL_L1_ASSOC, HASWELL_L1_BLOCK,
                  submission_only);
    } else {
        /* Use original cache otherwise */
        eval_perf(TEST_LOG_SET, TEST_ASSOC, TEST_LOG_BLOCK, submission_only);
    }

    /* Emit the results for this particular test */
    if (results.funcid == -1) {
        printf("\nError: We could not find your transpose_submit() function\n");
        printf(
            "Error: Please ensure that description field is exactly \"%s\"\n",
            SUBMIT_DESCRIPTION);
        printf("\nTEST_TRANS_RESULTS=0:0\n");
        status = 1;
    } else {
        printf("\nSummary for official submission (func %d): correctness=%d "
               "cycles=%ld\n",
               results.funcid, results.correct,
               get_clock_cycles(results.stats.hits, results.stats.misses));
        printf("\nTEST_TRANS_RESULTS=%d:%ld\n", results.correct,
               get_clock_cycles(results.stats.hits, results.stats.misses));
    }

    /* Remove hidden trace files */
    for (int i = 0; i < MAX_TRANS_FUNCS; i++) {
        char traceFile[FILENAME_BUFSIZE];
        snprintf(traceFile, sizeof(traceFile), "trace.f%d", i);
        remove(traceFile);
    }

    return status;
}
