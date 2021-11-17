/*
 * myenv.c - Shell test program
 *
 * Determines if the student shell sets the environment properly when
 * it runs jobs.
 */

#include <stdio.h>
#include <stdlib.h>

int main(void) {
    printf("MY_ENV=%s\n", getenv("MY_ENV"));
    fflush(stdout);
    exit(0);
}
