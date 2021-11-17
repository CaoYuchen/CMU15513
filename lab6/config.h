/*
 * config.h - Configuration file for the Autolab Shell Lab.
 */

#ifndef CONFIG_H
#define CONFIG_H

/**************************************************************
 * Other configuration variables (LAB DEVELOPER only)
 * Note: Instructors should not modify anything in this section
 ***************************************************************/

/* How many seconds does the driver wait for something before timing out */
#define DRIVER_TIMEOUT 4

/* How many seconds does a shell job run before timing out */
#define JOB_TIMEOUT 10

#define NUM_GRADED_TRACEFILE 33

/* The list of tracefiles that the driver may use for testing. */
#define TRACEFILES                                                             \
    "traces/trace00.txt", "traces/trace01.txt", "traces/trace02.txt",          \
        "traces/trace03.txt", "traces/trace04.txt", "traces/trace05.txt",      \
        "traces/trace06.txt", "traces/trace07.txt", "traces/trace08.txt",      \
        "traces/trace09.txt", "traces/trace10.txt", "traces/trace11.txt",      \
        "traces/trace12.txt", "traces/trace13.txt", "traces/trace14.txt",      \
        "traces/trace15.txt", "traces/trace16.txt", "traces/trace17.txt",      \
        "traces/trace18.txt", "traces/trace19.txt", "traces/trace20.txt",      \
        "traces/trace21.txt", "traces/trace22.txt", "traces/trace23.txt",      \
        "traces/trace24.txt", "traces/trace25.txt", "traces/trace26.txt",      \
        "traces/trace27.txt", "traces/trace28.txt", "traces/trace29.txt",      \
        "traces/trace30.txt", "traces/trace31.txt", "traces/trace32.txt"

/* Various constants */
#define ITERS 3
#define MAXARGS MAXBUF
#define MAXTRACES 128
#define PROMPT "tsh> "

#endif /* CONFIG_H */
