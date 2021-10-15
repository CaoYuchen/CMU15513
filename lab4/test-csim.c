/*
 * @file test-csim.c
 * @brief Checks the correctness of a student's cache simulator
 *
 * This program checks the correctness of a student's test cache simulator
 * (csim) by comparing its output to a reference simulator provided by the
 * instructors (csim-ref).
 */

#include <errno.h>
#include <getopt.h>
#include <limits.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "cachelab.h"

#define MAX_STR 1024 /* Max string size */

/** @brief Number of tests */
#define N 11

/** @brief Directory where all traces are located */
#define TRACES_DIR "traces/csim/"

typedef struct {
    int s;
    int E;
    int b;
    int weight;
    const char *filename;
} trace_info_t;

/** @brief Information about each trace to test */
static const trace_info_t TRACE_INFO[N] = {
    {.s = 0, .E = 1, .b = 0, .weight = 1, .filename = TRACES_DIR "wide.trace"},
    {.s = 2, .E = 1, .b = 2, .weight = 1, .filename = TRACES_DIR "wide.trace"},
    {.s = 3, .E = 2, .b = 2, .weight = 1, .filename = TRACES_DIR "load.trace"},
    {.s = 1, .E = 1, .b = 1, .weight = 1, .filename = TRACES_DIR "yi2.trace"},
    {.s = 4, .E = 2, .b = 4, .weight = 1, .filename = TRACES_DIR "yi.trace"},
    {.s = 2, .E = 1, .b = 4, .weight = 1, .filename = TRACES_DIR "dave.trace"},
    {.s = 2, .E = 1, .b = 3, .weight = 1, .filename = TRACES_DIR "trans.trace"},
    {.s = 2, .E = 2, .b = 3, .weight = 1, .filename = TRACES_DIR "trans.trace"},
    {.s = 14,
     .E = 1024,
     .b = 3,
     .weight = 1,
     .filename = TRACES_DIR "trans.trace"},
    {.s = 5, .E = 1, .b = 5, .weight = 1, .filename = TRACES_DIR "trans.trace"},
    {.s = 5, .E = 1, .b = 5, .weight = 2, .filename = TRACES_DIR "long.trace"},
};

static int num_runs = 0; // used to randomize input to students' csim

/*
 * usage - Prints usage info
 */
static void usage(char *argv[]) {
    printf("Usage: %s [-h]\n", argv[0]);
    printf("Options:\n");
    printf("  -h    Print this help message.\n");
}

/**
 * @brief SIGALRM handler
 */
static void sigalrm_handler(int signum) {
    const char *msg = "Error: Program timed out.\n"
                      "TEST_CSIM_RESULTS=0,0,0,0,0,0\n";
    ssize_t res = write(STDOUT_FILENO, msg, strlen(msg));
    (void)res;
    _exit(1);
}

/**
 * @brief Runs a cache simulation and collects the resulting statistics.
 *
 * @param[in]  cmd    The command used to invoke csim
 * @param[out] stats  The statistics collected from this simulation run
 *
 * @return false if any problems, true if OK.
 */
static bool run_csim(const char *cmd, csim_stats_t *stats) {
    int status;

    status = unlink(".csim_results");
    if (status < 0 && errno != ENOENT) {
        fprintf(stderr, "Error removing old simulation results: %s\n",
                strerror(errno));
        return false;
    }

    /* Run the simulator command */
    status = system(cmd);
    if (status < 0) {
        fprintf(stderr, "Error invoking csim: %s\n", strerror(errno));
        return false;
    }
    if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
        fprintf(stderr, "Error running csim: Status %d\n", WEXITSTATUS(status));
        return false;
    }

    /* Get the results from the simulator */
    bool success = loadSummary(stats);
    if (!success) {
        fprintf(stderr, "Error: Results for csim not found. Use the "
                        "printSummary() function\n");
    }

    status = unlink(".csim_results");
    (void)status;

    return success;
}

/*
 * @brief Collects run results for a particular trace
 *
 * Runs the reference and trace simulators on a particular trace and set of
 * cache parameters, and collects the results for the caller.
 *
 * @param[in]  info        Information about the trace to run
 * @param[out] ref_stats   Statistics for the reference simulator
 * @param[out] test_stats  Statistics for the simulator being tested
 *
 * @return false if any problems, true if OK.
 */
static bool runtrace(const trace_info_t *info, csim_stats_t *ref_stats,
                     csim_stats_t *test_stats) {
    char cmd[MAX_STR];

    /* Run the reference simulator */
    sprintf(cmd, "./csim-ref -s %d -E %d -b %d -t %s > /dev/null", info->s,
            info->E, info->b, info->filename);
    if (!run_csim(cmd, ref_stats)) {
        fprintf(stderr, "Running reference simulator failed: '%s'\n", cmd);
        fprintf(stderr, "\n");
        return false;
    }

    /* Run the test simulator */
    /* addition 9/28/2017 F17: randomize input to csim to test
     * that students don't hardcode argument parsing */
    switch (num_runs % 4) {
    case 0:
        sprintf(cmd, "./csim -b %d -s %d -t %s -E %d > /dev/null", info->b,
                info->s, info->filename, info->E);
        break;
    case 1:
        sprintf(cmd, "./csim -t %s -E %d -s %d -b %d > /dev/null",
                info->filename, info->E, info->s, info->b);
        break;
    case 2:
        sprintf(cmd, "./csim -E %d -b %d -t %s -s %d > /dev/null", info->E,
                info->b, info->filename, info->s);
        break;
    case 3:
        sprintf(cmd, "./csim -s %d -E %d -b %d -t %s > /dev/null", info->s,
                info->E, info->b, info->filename);
        break;
    }

    num_runs = num_runs + 1;

    if (!run_csim(cmd, test_stats)) {
        fprintf(stderr, "Running test simulator failed: '%s'\n", cmd);
        fprintf(stderr, "\n");
        return false;
    }

    return true;
}

/**
 * @brief Counts the number of matching fields in two csim_stats_t structs
 */
static int count_matches(const csim_stats_t *a, const csim_stats_t *b) {
    int matches = 0;
    matches += (a->hits == b->hits);
    matches += (a->misses == b->misses);
    matches += (a->evictions == b->evictions);
    matches += (a->dirty_bytes == b->dirty_bytes);
    matches += (a->dirty_evictions == b->dirty_evictions);
    return matches;
}

/**
 * @brief Print statistics for one trace.
 */
static void print_trace_results(int points, const trace_info_t *info,
                                const csim_stats_t *test_stats,
                                const csim_stats_t *ref_stats) {
    char buf[MAX_STR];
    sprintf(buf, "(%2d,%4d,%1d)", info->s, info->E, info->b);
    printf("%6d %8s", points, buf);
    printf("%8ld%8ld%8ld%8ld%8ld", test_stats->hits, test_stats->misses,
           test_stats->evictions, test_stats->dirty_bytes,
           test_stats->dirty_evictions);
    printf("%8ld%8ld%8ld%8ld%8ld", ref_stats->hits, ref_stats->misses,
           ref_stats->evictions, ref_stats->dirty_bytes,
           ref_stats->dirty_evictions);
    printf("  %s\n", info->filename);
}

/**
 * @brief Checks the student's test simulator for correctness by
 *        comparing its results to the reference simulator.
 */
static void test_csim(void) {
    /* Output results */
    csim_stats_t ref_stats[N];
    csim_stats_t test_stats[N];
    int points[N];
    int total_points = 0;

    /* Initialize arrays */
    for (int i = 0; i < N; i++) {
        points[i] = 0;
        ref_stats[i].hits = ref_stats[i].misses = ref_stats[i].evictions =
            ref_stats[i].dirty_bytes = ref_stats[i].dirty_evictions = ULONG_MAX;
        test_stats[i].hits = test_stats[i].misses = test_stats[i].evictions =
            test_stats[i].dirty_bytes = test_stats[i].dirty_evictions =
                ULONG_MAX;
    }

    /* Run the individual tests */
    for (int i = 0; i < N; i++) {
        bool success = runtrace(&TRACE_INFO[i], &ref_stats[i], &test_stats[i]);
        if (success) {
            points[i] = count_matches(&ref_stats[i], &test_stats[i]) *
                        TRACE_INFO[i].weight;
        }
        total_points += points[i];
    }

    /* Display a summary of results */
    printf("%42s%45s\n", "Your simulator", "Reference simulator");
    printf("%6s%12s%8s%8s%8s%8s%8s%8s%8s%8s%8s%8s\n", "Points", "( s,   E,b)",
           "Hits", "Misses", "Evicts", "D_Cache", "D_Evict", "Hits", "Misses",
           "Evicts", "D_Cache", "D_Evict");

    for (int i = 0; i < N; i++) {
        print_trace_results(points[i], &TRACE_INFO[i], &test_stats[i],
                            &ref_stats[i]);
    }

    printf("%6d\n", total_points);

    /* Print a compact summary string for the driver */
    printf("\nTEST_CSIM_RESULTS=%d\n", total_points);
}

/**
 * @brief Main routine
 */
int main(int argc, char *argv[]) {
    int c;

    /* Parse command line args */
    while ((c = getopt(argc, argv, "h")) != -1) {
        switch (c) {
        case 'h':
            usage(argv);
            exit(0);
        default:
            usage(argv);
            exit(1);
        }
    }

    /* Install timeout handler */
    if (signal(SIGALRM, sigalrm_handler) == SIG_ERR) {
        fprintf(stderr, "Unable to install SIGALRM handler\n");
        exit(1);
    }

    /* Time out and give up after a while */
    alarm(20);

    /* Evaluate the student's cache simulator for correctness */
    test_csim();

    exit(0);
}
