/*
 * myints.c - Sends a SIGINT to itself
 */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static void sigalrm_handler(int signum) {
    exit(0);
}

int main(void) {
    Signal(SIGALRM, sigalrm_handler);
    alarm(JOB_TIMEOUT);

    if (kill(getpid(), SIGINT) < 0) {
        perror("kill");
        exit(1);
    }

    while (1)
        ;
    exit(0);
}
