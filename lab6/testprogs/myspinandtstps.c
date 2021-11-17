/*
 * mytstpandspin.c - Sends a SIGTSTP to its parent (the shell) then spin
 * for argv[1] s in standalone mode or until driver synchronises.
 */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static void sigalrm_handler(int signum) {
    if (kill(getpid(), SIGTSTP) < 0) {
        perror("kill");
        _exit(1);
    }
    while (1)
        ;
    _exit(0);
}

int main(int argc, const char *argv[]) {
    int syncfd;
    int standalone;

    Signal(SIGALRM, sigalrm_handler);

    /*
     * If running under the driver, get the number of the driver's
     * synchronizing domain socket descriptor.
     */
    standalone = get_syncfd(&syncfd);

    /*
     * If the job is being run by the driver, then synchronize with
     * the driver over its synchronizing domain socket, after being
     * restarted.  Ignore any command line argument.
     */

    if (!standalone) {
        alarm(JOB_TIMEOUT);

        sync_signal(syncfd);
        sync_wait(syncfd);

        if (kill(getpid(), SIGTSTP) < 0) {
            perror("kill");
            exit(1);
        }
        while (1)
            ;
        exit(0);

        /*
         * Otherwise spin until timing out
         */
    } else {
        if (argc > 1) {
            alarm((unsigned)atoi(argv[1]));
        } else {
            alarm(JOB_TIMEOUT);
        }
        while (1)
            ;
    }

    /* Control should never reach here */
    exit(1);
}
