/*
 * myspin1 - Shell lab test program.
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
 * Usage: ./myspin1 [secs]
 */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#include "config.h"
#include "testprogs/helper.h"

static int syncfd;
static int standalone = 1;

static void sigalrm_handler(int signum) {
    _exit(0);
}

static void sigterm_handler(int signum) {
    if (!standalone) {
        sync_wait(syncfd);
        sync_signal(syncfd);
    }

    Signal(SIGTERM, SIG_DFL);
    raise(SIGTERM);
}

int main(int argc, char **argv) {
    sigset_t sigalrm_set;

    /*
     * If running under the driver, get the number of the driver's
     * synchronizing domain socket descriptor.
     */
    standalone = get_syncfd(&syncfd);

    Signal(SIGALRM, sigalrm_handler);
    Signal(SIGTERM, sigterm_handler);

    /*
     * Forcibly unblock SIGALRM to ensure that the program always terminates,
     * instead of wasting resources on shared machines.
     */
    sigemptyset(&sigalrm_set);
    sigaddset(&sigalrm_set, SIGALRM);
    sigprocmask(SIG_UNBLOCK, &sigalrm_set, NULL);

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
