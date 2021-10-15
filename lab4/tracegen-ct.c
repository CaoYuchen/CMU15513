/*
 * tracegen.c - Running the binary tracegen produces
 * a memory trace of all of the registered transpose functions.
 *
 * The tracing functionality will only record memory accesses from
 * the registered transpose functions; however, if multiple functions
 * are invoked during a single execution, the trace will contain
 * all of the accesses together.
 */

#include "cachelab.h"
#include <assert.h>
#include <getopt.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "cachelab.h"

/* Enable / disable tracing */
extern void __roi_begin(void);
extern void __roi_end(void);

/* Need to make sure A and B start on cache block boundaries */
static double bigA[MAXN][MAXN] __attribute__((aligned(64)));
static double bigT[TMPCOUNT] __attribute__((aligned(64)));
static double bigB[MAXN][MAXN] __attribute__((aligned(64)));
static double bigAcopy[MAXN][MAXN];
static double bigBtarg[MAXN][MAXN];
static size_t M;
static size_t N;

bool validate(int fn, double A[N][M], double Acopy[N][M], double B[M][N],
              double Btarg[M][N]) {
    size_t i, j;
    size_t xM = M + 10;
    if (xM > MAXN)
        xM = MAXN;
    for (i = 0; i < M; i++) {
        for (j = 0; j < N; j++) {
            if (B[i][j] != Btarg[i][j]) {
                fprintf(stderr,
                        "Validation failed on function %d! Expected %.3f but "
                        "got %.3f at B[%zd][%zd]\n",
                        fn, Btarg[i][j], B[i][j], i, j);
                return false;
            }
        }
    }

    /* Look for changes to A */
    for (j = 0; j < N; j++) {
        for (i = 0; i < M; i++) {
            if (A[j][i] != Acopy[j][i]) {
                fprintf(
                    stderr,
                    "Validation failed on function %d! A[%zd][%zd] corrupted\n",
                    fn, j, i);
                return false;
            }
        }
    }

    /* Look for out of bounds writes to B, scanning a few more rows */
    for (i = M; i < xM; i++)
        for (j = 0; j < N; j++) {
            if (B[i][j] != 0) {
                fprintf(stderr,
                        "Validation failed on function %d! Out-of-bounds write "
                        "to B[%zd][%zd]\n",
                        fn, i, j);
                return false;
            }
        }
    return true;
}

static void usage(char *cmd) {
    fprintf(stderr, "Usage: %s [-h] [-M M] [-N N] [-F ID]\n", cmd);
    fprintf(stderr, "  -N N    Set number of rows of A / cols of B\n");
    fprintf(stderr, "  -M M    Set number of cols of A / rows of B\n");
    fprintf(stderr, "  -F ID   Run function number ID\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "The generated trace file is written to default.trace "
                    "by default, but a\n");
    fprintf(stderr, "different filename can be selected by setting the "
                    "CONTECH_TRACE environment\n");
    fprintf(stderr, "variable. For example:\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "    CONTECH_TRACE=trace.f0 %s -N 32 -M 32 -F 0\n", cmd);
    fprintf(stderr, "\n");
    exit(0);
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

int entry(int argc, char *argv[]) {
    int i;

    int c;
    int selectedFunc = -1;
    while ((c = getopt(argc, argv, "hvM:N:F:")) != -1) {
        switch (c) {
        case 'M':
            M = (size_t)atoi(optarg);
            break;
        case 'N':
            N = (size_t)atoi(optarg);
            break;
        case 'F':
            selectedFunc = atoi(optarg);
            break;
        case 'v':
            break;
        case 'h':
        default:
            usage(argv[0]);
        }
    }

    if (M == 0 || M > (size_t)MAXN || N == 0 || N > (size_t)MAXN) {
        fprintf(stderr,
                "Error: M and N must both be nonzero "
                "and at most %zu\n",
                (size_t)MAXN);
        exit(1);
    }

    if (signal(SIGALRM, sigalrm_handler) == SIG_ERR) {
        fprintf(stderr, "Unable to install SIGALRM handler\n");
        exit(1);
    }

    /* Time out and give up after a while */
    alarm(360);

    /*  Register transpose functions */
    registerFunctions();

    /* Clear out matrices */
    memset(bigA, 0, sizeof(bigA));
    memset(bigB, 0, sizeof(bigB));

    /* Fill A with data */
    initMatrix(M, N, bigA, bigB);
    /* Make copy of A */
    memset(bigAcopy, 0, sizeof(bigAcopy));
    copyMatrix(M, N, bigAcopy, bigA);
    /* Generate target version */
    memset(bigBtarg, 0, sizeof(bigBtarg));
    correctTrans(M, N, bigA, bigBtarg);

    if (-1 == selectedFunc) {
        /* Invoke registered transpose functions */
        for (i = 0; i < func_counter; i++) {
            memset(bigT, 0, sizeof(bigT));
            __roi_begin();
            (*func_list[i].func_ptr)(M, N, bigA, bigB, bigT);
            __roi_end();
            if (!validate(i, bigA, bigAcopy, bigB, bigBtarg)) {
                return i + 1;
            }
        }
    } else {
        memset(bigT, 0, sizeof(bigT));
        __roi_begin();
        (*func_list[selectedFunc].func_ptr)(M, N, bigA, bigB, bigT);
        __roi_end();
        if (!validate(selectedFunc, bigA, bigAcopy, bigB, bigBtarg)) {
            return 1;
        }
    }
    return 0;
}
