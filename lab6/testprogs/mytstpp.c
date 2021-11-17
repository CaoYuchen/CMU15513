/*
 * mytstpp.c - Sends a SIGTSTP to its parent (the shell)
 *
 * A correctly written shell will echo the SIGTSTP back to the child.
 */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static void sigalrm_handler(int signum) {
    _exit(0);
}

int main(void) {
    Signal(SIGALRM, sigalrm_handler);
    alarm(JOB_TIMEOUT);

    if (kill(getppid(), SIGTSTP) < 0) {
        perror("kill");
        exit(1);
    }

    while (1)
        ;
    exit(0);
}
