/* clock.c
 * Retrofitted to use thread-specific timers
 * and to get clock information from /proc/cpuinfo
 * (C) R. E. Bryant, 2010
 *
 * Retrofitted to measure absolute time in seconds and then convert to cycles
 * Old time stamp could removed, since time stamp counter no longer tracks clock
 * cycles (C) R. E. Bryant, 2016
 *
 */

#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "clock.h"

int gverbose = 1;

/* Timer granularity */
const double timer_resolution = 1e-9;

/* Keep track of clock speed */
double cpu_mhz = 0.0;

/* Get megahertz from /etc/proc */
#define MAXBUF 512

static double core_mhz(int verbose) {
    static char buf[MAXBUF];
    FILE *fp = fopen("/proc/cpuinfo", "r");
    cpu_mhz = 0.0;

    if (!fp) {
        fprintf(stderr, "Can't open /proc/cpuinfo to get clock information\n");
        cpu_mhz = 1000.0;
        return cpu_mhz;
    }
    while (fgets(buf, MAXBUF, fp)) {
        if (strstr(buf, "cpu MHz")) {
            double cpu_mhz = 0.0;
            sscanf(buf, "cpu MHz\t: %lf", &cpu_mhz);
            break;
        }
    }
    fclose(fp);
    if (cpu_mhz == 0.0) {
        fprintf(stderr, "Can't open /proc/cpuinfo to get clock information\n");
        cpu_mhz = 1000.0;
        return cpu_mhz;
    }
    if (verbose) {
        printf("Processor Clock Rate ~= %.4f GHz (extracted from file)\n",
               cpu_mhz * 0.001);
    }
    return cpu_mhz;
}

double mhz(int verbose) {
    double val = core_mhz(verbose);
    return val;
}

/* Use nanosecond timer */
struct timespec last_time;
struct timespec new_time;

/* Use thread clock */
#define CLKT CLOCK_THREAD_CPUTIME_ID

void start_timer(void) {
    if (clock_gettime(CLKT, &last_time) != 0) {
        fprintf(stderr, "Couldn't get time\n");
        exit(1);
    }
}

double get_timer(void) {
    double delta_secs = 0.0;
    if (clock_gettime(CLKT, &new_time) != 0) {
        fprintf(stderr, "Couldn't get time\n");
        exit(1);
    }
    delta_secs = 1.0 * (double)(new_time.tv_sec - last_time.tv_sec) +
                 1e-9 * (double)(new_time.tv_nsec - last_time.tv_nsec);
#if 0
    printf("Delta %ld.%ld --> %ld.%ld (%ld + 1e-9*%ld = %.f)\n",
           (long) last_time.tv_sec, (long) last_time.tv_nsec,
           (long) new_time.tv_sec, (long) new_time.tv_nsec,
           (long) (new_time.tv_sec - last_time.tv_sec),
           (long) (new_time.tv_nsec - last_time.tv_nsec),
           delta_secs);
#endif
    return delta_secs;
}

void start_counter(void) {
    if (cpu_mhz == 0.0)
        mhz(gverbose);
    start_timer();
}

double get_counter(void) {
    double delta_secs = get_timer();
    return delta_secs * cpu_mhz * 1e6;
}
