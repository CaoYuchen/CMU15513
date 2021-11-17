/*
 * mysplit.c - Shell lab test program
 *
 * Forking version of the myspin programs. Useful for testing
 * shell code that sends signals to process groups.
 *
 * Usage: ./mysplit [secs]
 */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static void sigalrm_handler(int signum) {
    _exit(0);
}

int main(int argc, char **argv) {
    int standalone;
    int syncfd;

    Signal(SIGALRM, sigalrm_handler);

    if (fork() == 0) { /* child */
        /*
         * If running under the driver, get the number of the driver's
         * synchronizing domain socket descriptor.
         */
        standalone = get_syncfd(&syncfd);

        /*
         * If the job is being run by the driver, then synchronize with
         * the driver over its synchronizing domain socket.  Ignore any
         * command line argument.
         */

        if (!standalone) {
            alarm(JOB_TIMEOUT);

            sync_signal(syncfd);
            sync_wait(syncfd);

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
    }

    /* Parent waits for child to terminate */
    alarm(JOB_TIMEOUT);
    wait(NULL);
    exit(0);
}
