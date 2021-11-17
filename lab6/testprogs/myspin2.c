/*
 * myspin2 - Shell lab test program.
 *
 * When called by the shell driver, it synchronizes using a two-way
 * handshake. This allows the driver to know that the job is available
 * to receive signals. If it doesn't hear from the driver after some
 * period of time, then it times out and terminates.
 *
 * When called standalone, it sleeps for [secs] seconds and then
 * exits. If no argument is given, it sleeps for a default number
 * of seconds.
 *
 * Usage: ./myspin2 [secs]
 */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static void sigalrm_handler(int signum) {
    _exit(0);
}

int main(int argc, char **argv) {
    int syncfd;
    int standalone;
    sigset_t sigalrm_set, sigblk_set;

    Signal(SIGALRM, sigalrm_handler);

    /*
     * Forcibly unblock SIGALRM to ensure that the program always terminates,
     * instead of wasting resources on shared machines.
     */
    sigemptyset(&sigalrm_set);
    sigemptyset(&sigblk_set);
    sigaddset(&sigalrm_set, SIGALRM);
    sigaddset(&sigblk_set, SIGINT);
    sigaddset(&sigblk_set, SIGTSTP);
    sigprocmask(SIG_UNBLOCK, &sigalrm_set, NULL);
    sigprocmask(SIG_BLOCK, &sigblk_set, NULL);

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

    /* Control should never reach here */
    exit(1);
}
