/**
 * @file testprogs/helper.h
 * @brief Helper declarations for test programs
 */
#ifndef TESTPROGS_HELPER_H
#define TESTPROGS_HELPER_H

#include <signal.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>

/** @brief Maximum buffer size */
#define MAXBUF 8192

/** @brief Basic signal handler type */
typedef void (*handler_t)(int);

/** @brief Installs a signal handler (portable) */
static inline handler_t Signal(int signum, handler_t handler) {
    struct sigaction action, old_action;

    action.sa_handler = handler;
    sigemptyset(&action.sa_mask); /* Block sigs of type being handled */
    action.sa_flags = SA_RESTART; /* Restart syscalls if possible */

    if (sigaction(signum, &action, &old_action) < 0) {
        perror("Signal error");
        exit(1);
    }

    return old_action.sa_handler;
}

/**
 * @brief Retrieves the SYNCFD, if running under the driver.
 *
 * Determine if the shell is running standalone or under the
 * control of the driver program. If running under the driver, get
 * the number of the driver's synchronizing domain socket
 * descriptor.
 *
 * @param[out] syncfd The fd of the driver's synchronizing domain socket
 *
 * @return 1 if running standalone (no SYNCFD)
 * @return 0 if running under the driver (SYNCFD present)
 */
static inline int get_syncfd(int *syncfd) {
    int standalone = 1;
    char *str;
    struct stat stat;

    if ((str = getenv("SYNCFD")) != NULL) {
        *syncfd = atoi(str);               // Get descriptor number
        if (fstat(*syncfd, &stat) != -1) { // Is is open?
            standalone = 0;
        }
    }

    return standalone;
}

/**
 * @brief Signals the driver.
 *
 * Used to synchronize with the driver over a domain socket. This function
 * sends a signal to the driver, so it corresponds to WAIT in a trace file.
 *
 * @param[in] syncfd The fd of the driver's synchronizing domain socket
 */
static inline void sync_signal(int syncfd) {
    const char *cmdp = "";
    ssize_t rc;

    if ((rc = send(syncfd, cmdp, strlen(cmdp), 0)) < 0) {
        perror("send");
        exit(1);
    }
}

/**
 * @brief Waits for a signal from the driver.
 *
 * Used to synchronize with the driver over a domain socket. This function
 * waits for a signal from the driver, so it corresponds to SIGNAL in a trace
 * file.
 *
 * @param[in] syncfd The fd of the driver's synchronizing domain socket
 */
static inline void sync_wait(int syncfd) {
    char buf[MAXBUF];
    ssize_t rc;

    if ((rc = recv(syncfd, buf, MAXBUF, 0)) < 0) {
        perror("recv");
        exit(1);
    }
}

#endif /* TESTPROGS_HELPER_H */
