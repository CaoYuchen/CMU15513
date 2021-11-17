/*
 * wrapper.c - Wrappers for various system calls that introduce
 * non-determinism in order to trigger race conditions, and verify other
 * correctness behaviors of a tsh implementation.
 */
#include "csapp.h"
#include "tsh_helper.h"
#include <errno.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
/* Choose how want to delay */
#define UDELAY uspin

/* Sleep for a random period between 0 and MAX_SLEEP microseconds */
#define MAX_SLEEP 100000

#define CONVERT(val) (((double)val) / (double)RAND_MAX)

#define ERRNO_SENTINEL 15213
#define ERRNO_SIGPROCMASK 15513

static bool shellsync_kill = false;
static bool shellsync_waitpid_after = false;
static bool shellsync_waitpid_before = false;
static bool shellsync_job_get_pid = false;
static bool shellsync_job_set_state = false;
static int shellsyncfd;

/* signal wraping */
static bool signal_wrapping_init = false;

/* warning, use (signal-1) to index in the tables */
/* signal number start at 1 instead of zero */
static struct sigaction real_signalhandlers[_NSIG - 1];
static bool signal_handler_wrapped[_NSIG - 1];

/*
 * Sleep for USEC microseconds.  Not interrupted by signals.
 * Despite the name, does not busy-wait.
 */
static void uspin(useconds_t usec) {
    struct timespec deadline;
    clock_gettime(CLOCK_MONOTONIC, &deadline); // cannot fail

    deadline.tv_nsec += usec * 1000;
    while (deadline.tv_nsec >= 1000000000) {
        deadline.tv_nsec -= 1000000000;
        deadline.tv_sec++;
    }
    int err;
    do {
        err = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &deadline, NULL);
    } while (err == EINTR);
}

pid_t __real_fork(void);

int __real_sigsuspend(const sigset_t *mask);
int __real_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
void __real_init_job_list(void);

void __wrap_init_job_list(void);
pid_t __wrap_job_get_pid(jid_t jid);
pid_t __wrap_job_set_state(jid_t jid, job_state state);
pid_t __wrap_fork(void);
pid_t __wrap_waitpid(pid_t pid, int *status, int options);
int __wrap_sigsuspend(const sigset_t *mask);
int __wrap_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
int __wrap_kill(pid_t pid, int sig);
int __wrap_killpg(int pgrp, int sig);
int __wrap_execve(const char *path, char *const argv[], char *const envp[]);
int __wrap_execv(const char *path, char *const argv[]);
int __wrap_execvpe(const char *path, char *const argv[], char *const envp[]);
int __wrap_execvp(const char *path, char *const argv[]);
int __wrap_printf(const char *format, ...);
int __wrap_fprintf(FILE *stream, const char *format, ...);
int __wrap_sprintf(char *str, const char *format, ...);
int __wrap_snprintf(char *str, size_t size, const char *format, ...);
int __wrap_tcsetpgrp(int fd, pid_t pgrp);
int __wrap_sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oact);
sighandler_t __wrap_signal(int signum, sighandler_t handler);

static const char *shellsync = "";

/* Shell synchronisation helpers */
/* signal to runtrace */
static void shellsync_signal(void) {
    ssize_t rc;
    if ((rc = send(shellsyncfd, shellsync, strlen(shellsync), 0)) < 0) {
        perror("send");
        exit(1);
    }
}

/* wait for runtrace to signal us */
static void shellsync_wait(void) {
    ssize_t rc;
    char buf[MAXBUF];
    if ((rc = recv(shellsyncfd, buf, MAXBUF, 0)) < 0) {
        perror("recv");
        exit(1);
    }
    UDELAY(20000);
}

static int init_wrappers(void) {
    struct timeval time;
    char *str;
    struct stat stat;
    // initialize RNG
    gettimeofday(&time, NULL);
    srand((unsigned int)time.tv_usec);
    // initialize shell sync
    if ((str = getenv("SHELLSYNCFD")) != NULL) {
        shellsyncfd = atoi(str);
        if (fstat(shellsyncfd, &stat) != -1) {
            // the file is open, check the other environment variable
            // to select which synchronisation feature is enabled.
            if ((str = getenv("SHELLSYNC")) != NULL) {
                if (!strcmp("kill", str)) {
                    shellsync_kill = true;
                } else if (!strcmp("waitpid_after", str)) {
                    shellsync_waitpid_after = true;
                } else if (!strcmp("waitpid_before", str)) {
                    shellsync_waitpid_before = true;
                } else if (!strcmp("job_get_pid", str)) {
                    shellsync_job_get_pid = true;
                } else if (!strcmp("job_set_state", str)) {
                    shellsync_job_set_state = true;
                }
                // insert more synchronisation points here
            }
        }
    }
    return 1;
}

/* Ensure that the structures for signal wrapping are correctly initialized */
static void init_signal_wrapping(void) {
    if (signal_wrapping_init) {
        return;
    }
    for (int i = 0; i < _NSIG - 1; i++) {
        signal_handler_wrapped[i] = false;
    }
    signal_wrapping_init = true;
}

/* Check blocked-signals set for execve() related calls */
static void check_exec_sigset(void) {
    sigset_t currmask;
    if (sigprocmask(SIG_SETMASK, NULL, &currmask) < 0) {
        sio_eprintf("Sigprocmask error\n");
        _exit(1);
    }
    if (sigismember(&currmask, SIGCHLD)) {
        sio_printf("WARNING: SIGCHLD is blocked in execve\n");
    }
    if (sigismember(&currmask, SIGINT)) {
        sio_printf("WARNING: SIGINT is blocked in execve\n");
    }
    if (sigismember(&currmask, SIGTSTP)) {
        sio_printf("WARNING: SIGTSTP is blocked in execve\n");
    }
    if (sigismember(&currmask, SIGALRM)) {
        sio_printf("WARNING: SIGALRM is blocked in execve\n");
    }
}

/* __wrap_init_job_list - wrapper around the init_job_list function
 * It is used to properly initialise the wrappers and detect which
 * shell synchronisation facilities is enabled.
 */
void __wrap_init_job_list(void) {
    init_wrappers();
    __real_init_job_list();
}

/*
 * __wrap_job_get_pid - wrapper around the pid acessor
 * It is used to test for race conditions in builtins fg and bg.
 */
pid_t __real_job_get_pid(jid_t jid);

pid_t __wrap_job_get_pid(jid_t jid) {
    if (shellsync_job_get_pid) {
        shellsync_signal();
        shellsync_wait();
    }
    return __real_job_get_pid(jid);
}

/*
 * __wrap_job_set_state - wrapper around the pid acessor
 * It is used to test for race conditions in builtins fg and bg.
 */
pid_t __real_job_set_state(jid_t jid, job_state state);

pid_t __wrap_job_set_state(jid_t jid, job_state state) {
    if (shellsync_job_set_state) {
        shellsync_signal();
        shellsync_wait();
    }
    return __real_job_set_state(jid, state);
}

/*
 * __wrap_fork - Link-time wrapper for fork() that introduces non-
 * determinism in the order that parent and child are executed
 *
 * After calling fork, this wrapper randomly decides whether to sleep for
 * a random period in either the parent or child process, which results in
 * yielding control to the other process.
 *
 * Based on a link-time positioning technique: Given the -Wl,--wrap,fork
 * argument, the linker replaces all references to fork with __wrap_fork(),
 * and all references to __real_fork with fork().
 */
pid_t __wrap_fork(void) {

    bool b = (unsigned)(CONVERT(rand()) + 0.5);
    unsigned secs = (unsigned)(CONVERT(rand()) * MAX_SLEEP);

    /* Call the real fork function */
    pid_t pid = __real_fork();

    /* Randomly decide to sleep in the parent or the child */
    if (pid == 0) {
        if (b) {
            UDELAY(secs);
        }
    } else {
        if (!b) {
            UDELAY(secs);
        }
    }

#if 0
    sio_printf("Parent: pid=%d, delay=%dus.  Child: pid=%d, delay=%dus\n",
           getpid(), (int) parent_delay, pid, (int) child_delay);
#endif
    /* Return the PID like a normal fork call */
    return pid;
}

/*
 * __wrap_waitpid - Link time wrapper around waitpid
 * Permits precise triggering of race conditions right after a process is
 * reaped by waitpid.
 */
pid_t __real_waitpid(pid_t pid, int *status, int options);

pid_t __wrap_waitpid(pid_t pid, int *status, int options) {
    if (shellsync_waitpid_before) {
        shellsync_signal();
        shellsync_wait();
    }
    pid_t ret = __real_waitpid(pid, status, options);
    if (shellsync_waitpid_after && ret > 0) {
        shellsync_signal();
        shellsync_wait();
    }
    return ret;
}

/*
 * __wrap_sigsuspend - Link time wrapper for sigsuspend
 * Sleeps before executing the call, increasing the likelihood that a signal
 * is handled before sigsuspend runs if signals are unblocked.
 */
int __wrap_sigsuspend(const sigset_t *mask) {
    UDELAY((useconds_t)((CONVERT(rand()) * MAX_SLEEP) / 10));
    return __real_sigsuspend(mask);
}

/*
 * __wrap_sigprocmask - Link time wrapper for sigprocmask
 * Sets errno to 0 to help checking that errno is correctly saved.
 */
int __wrap_sigprocmask(int how, const sigset_t *set, sigset_t *oldset) {
    errno = ERRNO_SIGPROCMASK;
    int ret = __real_sigprocmask(how, set, oldset);
    return ret;
}

/*
 * __wrap_kill - Link time wrapper for kill, used for optional shell
 * synchronisation
 */
int __real_kill(pid_t pid, int sig);

int __wrap_kill(pid_t pid, int sig) {
    if (shellsync_kill) {
        shellsync_signal();
        shellsync_wait();
    }
    return __real_kill(pid, sig);
}

int __real_killpg(int pgrp, int sig);

int __wrap_killpg(int pgrp, int sig) {
    if (shellsync_kill) {
        shellsync_signal();
        shellsync_wait();
    }
    return __real_killpg(pgrp, sig);
}

/*
 * __wrap_execve - Link time wrapper around execve that checks that signals
 * are not blocked
 */
int __real_execve(const char *path, char *const argv[], char *const envp[]);

int __wrap_execve(const char *path, char *const argv[], char *const envp[]) {
    check_exec_sigset();
    return __real_execve(path, argv, envp);
}

int __real_execv(const char *path, char *const argv[]);

int __wrap_execv(const char *path, char *const argv[]) {
    check_exec_sigset();
    return __real_execv(path, argv);
}

int __real_execvpe(const char *path, char *const argv[], char *const envp[]);

int __wrap_execvpe(const char *path, char *const argv[], char *const envp[]) {
    check_exec_sigset();
    return __real_execvpe(path, argv, envp);
}

int __real_execvp(const char *path, char *const argv[]);

int __wrap_execvp(const char *path, char *const argv[]) {
    check_exec_sigset();
    return __real_execvp(path, argv);
}

/*
 * __wrap_*printf - Link time wrapper for the printf family of functions
 */
int __wrap_printf(const char *format, ...) {
    va_list args;
    UDELAY((useconds_t)((CONVERT(rand()) * MAX_SLEEP) / 20));
    va_start(args, format);
    int ret = vprintf(format, args);
    va_end(args);
    return ret;
}

int __wrap_fprintf(FILE *stream, const char *format, ...) {
    va_list args;
    UDELAY((useconds_t)((CONVERT(rand()) * MAX_SLEEP) / 20));
    va_start(args, format);
    int ret = vfprintf(stream, format, args);
    va_end(args);
    return ret;
}

int __wrap_sprintf(char *str, const char *format, ...) {
    va_list args;
    UDELAY((useconds_t)((CONVERT(rand()) * MAX_SLEEP) / 20));
    va_start(args, format);
    int ret = vsprintf(str, format, args);
    va_end(args);
    return ret;
}

int __wrap_snprintf(char *str, size_t size, const char *format, ...) {
    va_list args;
    UDELAY((useconds_t)((CONVERT(rand()) * MAX_SLEEP) / 20));
    va_start(args, format);
    int ret = vsnprintf(str, size, format, args);
    va_end(args);
    return ret;
}

/*
 * __wrap_tcsetpgrp - Link time wrapper to disable tcsetpgrp
 */
int __wrap_tcsetpgrp(int fd, pid_t pgrp) {
    sio_eprintf("Do not use tcsetprgp, it breaks grading");
    _exit(1);
}

/*
 * __wrap_sigaction - Link time wrapper for sigaction used to wrap signal
 * handlers, and thereby detect if errno is properly restored
 */
static void sa_sigaction_wrapper(int signum, siginfo_t *siginfo,
                                 void *context) {
    // save errno
    int olderrno = errno;
    bool has_sa_sigaction = false;
    void (*signal_handler)(int) = NULL;
    void (*signal_sigaction)(int, siginfo_t *, void *) = NULL;
    sigset_t mask_all, prev_all;

    // Block all signals
    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("Sigfillset error\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("Sigprocmask error\n");
        _exit(1);
    }

    // Lookup signum in table
    if (signal_handler_wrapped[signum - 1]) {
        if (SA_SIGINFO & real_signalhandlers[signum - 1].sa_flags) {
            has_sa_sigaction = true;
            signal_sigaction = real_signalhandlers[signum - 1].sa_sigaction;
        } else {
            has_sa_sigaction = false;
            signal_handler = real_signalhandlers[signum - 1].sa_handler;
        }
    } else {
        sio_eprintf("Signal wrapper called with an unregistered signal");
        _exit(1);
    }

    // Unblock all signals
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
        sio_eprintf("Sigprocmask error\n");
        _exit(1);
    }

    // Put sentinel errno
    errno = ERRNO_SENTINEL;

    // Call actual signal handler
    if (has_sa_sigaction) {
        signal_sigaction(signum, siginfo, context);
    } else {
        signal_handler(signum);
    }

    // Ensure sentinel value is unchanged
    if (errno != ERRNO_SENTINEL) {
        sio_printf("WARNING: errno has been corrupted by the signal handler "
                   "for signal %d (changed from %d to %d)\n",
                   signum, ERRNO_SENTINEL, errno);
        sio_printf(
            "         You must save and restore errno in signal handlers!\n");
    }

    // Restore errno
    errno = olderrno;
}

int __real_sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact);

int __wrap_sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact) {
    int ret;
    sigset_t mask_all, prev_all;
    struct sigaction old_sigaction;
    struct sigaction new_sigaction;
    bool has_old_sigaction = false;

    // Block all signals
    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("Sigfillset error\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("Sigprocmask error\n");
        _exit(1);
    }
    init_signal_wrapping();

    // Check if we have an old sigaction in our datastructure
    has_old_sigaction = signal_handler_wrapped[signum - 1];
    if (has_old_sigaction) {
        old_sigaction = real_signalhandlers[signum - 1];
    }

    if (act == NULL) {
        // Not setting a new action
        ret = __real_sigaction(signum, act, oldact);
    } else if ((!(act->sa_flags & SA_SIGINFO) &&
                (act->sa_handler == SIG_DFL || act->sa_handler == SIG_IGN))) {
        // Setting a special action
        ret = __real_sigaction(signum, act, oldact);
        if (ret >= 0) {
            // If succeeded, mark as unwrapped
            signal_handler_wrapped[signum - 1] = false;
        }
    } else {
        // If setting a new action, compute the wrapper sigaction
        new_sigaction = *act;
        new_sigaction.sa_flags |= SA_SIGINFO;
        new_sigaction.sa_sigaction = sa_sigaction_wrapper;

        ret = __real_sigaction(signum, &new_sigaction, oldact);
        if (ret >= 0) {
            // If succeeded, save the original action
            real_signalhandlers[signum - 1] = *act;
            signal_handler_wrapped[signum - 1] = true;
        }
    }

    // Check if there is a pointer to retrieve the old action,
    // and we have overidden it
    if (ret >= 0 && oldact != NULL && has_old_sigaction) {
        // Return the wrapped action
        *oldact = old_sigaction;
    }

    // Unblock all signals
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
        sio_eprintf("Sigprocmask error\n");
        _exit(1);
    }
    return ret;
}

/*
 * __wrap_signal - Link time wrapper for signal
 * Simply calls the wrapper for sigaction
 */
typedef void (*sighandler_t)(int);

sighandler_t __real_signal(int signum, sighandler_t handler);

sighandler_t __wrap_signal(int signum, sighandler_t handler) {
    struct sigaction act, oldact;
    memset(&act, 0, sizeof(act));
    if (sigemptyset(&act.sa_mask) < 0) {
        sio_eprintf("Sigemptyset error\n");
        _exit(1);
    }
    act.sa_handler = handler;
    act.sa_flags = SA_RESTART;

    if (__wrap_sigaction(signum, &act, &oldact) < 0) {
        return SIG_ERR;
    }

    return oldact.sa_handler;
}
