/**
 * @file csapp.h
 * @brief Prototypes and definitions for the CS:APP3e book
 *
 * This file consists of four major components:
 *
 * - The RIO (robust I/O) package, which allows performing reads and writes
 *   robustly by handling short reads and writes. It also provides the rio_t
 *   which allows for buffered reads.
 *
 * - The SIO (safe I/O) package, which implements an async-signal-safe variant
 *   of printf and related calls. (The Sio_puts and Sio_putl functions in the
 *   textbook have been removed.)
 *
 * - Error-checking wrapper functions (similar to those used by Stevens),
 *   which are used heavily in the textbook. However, most have been removed
 *   from the file since they tend to discourage students from actually
 *   thinking about error checking. (P and V remain since their names are
 *   substantially different from the unwrapped versions.)
 *
 * - The open_clientfd and open_listenfd functions, which are protocol-
 *   independent helpers for client/server programs.
 */

/*
 * The wrapper functions in this file, which use unix_error, are technically
 * not async-signal-safe due to the use of strerror. If this is not suitable,
 * you should write your own wrapper functions.
 *
 * For most cases, however, we consider this to be only a minor caveat. The
 * only situation that results in a lack of safety is quite unlikely: the
 * failure of a wrapper function (which will terminate the program anyway)
 * must interrupt a function that is holding the same locks as strerror.
 * Since this is a rare and exceptional condition, we consider it acceptable
 * to use these wrapper functions inside of signal handlers.
 */

#ifndef CSAPP_H
#define CSAPP_H

#include <stdarg.h>    /* va_list */
#include <stddef.h>    /* size_t */
#include <sys/types.h> /* ssize_t */

/* Default file permissions are DEF_MODE & ~DEF_UMASK */
#define DEF_MODE S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH
#define DEF_UMASK S_IWGRP | S_IWOTH

/* Persistent state for the robust I/O (Rio) package */
#define RIO_BUFSIZE 8192
typedef struct {
    int rio_fd;                /* Descriptor for this internal buf */
    ssize_t rio_cnt;           /* Unread bytes in internal buf */
    char *rio_bufptr;          /* Next unread byte in internal buf */
    char rio_buf[RIO_BUFSIZE]; /* Internal buffer */
} rio_t;

/* Misc constants */
#define MAXLINE 8192 /* Max text line length */
#define MAXBUF 8192  /* Max I/O buffer size */
#define LISTENQ 1024 /* Second argument to listen() */

/* Signal wrappers */
typedef void handler_t(int);
handler_t *Signal(int signum, handler_t *handler);

/* Sio (Signal-safe I/O) routines */
ssize_t sio_printf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
ssize_t sio_dprintf(int fileno, const char *fmt, ...)
    __attribute__((format(printf, 2, 3)));
ssize_t sio_eprintf(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
ssize_t sio_vdprintf(int fileno, const char *fmt, va_list argp)
    __attribute__((format(printf, 2, 0)));

#define sio_assert(expr)                                                       \
    ((expr) ? (void)0 : __sio_assert_fail(#expr, __FILE__, __LINE__, __func__))

void __sio_assert_fail(const char *assertion, const char *file,
                       unsigned int line, const char *function)
    __attribute__((noreturn));

/* Rio (Robust I/O) package */
ssize_t rio_readn(int fd, void *usrbuf, size_t n);
ssize_t rio_writen(int fd, const void *usrbuf, size_t n);
void rio_readinitb(rio_t *rp, int fd);
ssize_t rio_readnb(rio_t *rp, void *usrbuf, size_t n);
ssize_t rio_readlineb(rio_t *rp, void *usrbuf, size_t maxlen);

/* Reentrant protocol-independent client/server helpers */
int open_clientfd(const char *hostname, const char *port);
int open_listenfd(const char *port);

#endif /* CSAPP_H */
