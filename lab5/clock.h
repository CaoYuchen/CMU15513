/* Routines for timing functions */
#ifndef CLOCK_H
#define CLOCK_H 1

/*  minimum resolution of timer (secs) */
extern const double timer_resolution;

/* Timer: measures in seconds */

/* Start the timer */
void start_timer(void);

/* Get # seconds since timer started.  Returns 1e20 if detect timing anomaly */
double get_timer(void);

/* Determine clock rate of processor (using a default sleeptime) */
double mhz(int verbose);

/* Counter: measures in clock cycles */
/* Start the counter */
void start_counter(void);

/* Get # cycles since counter started.  Returns 1e20 if detect timing anomaly */
double get_counter(void);

#endif
