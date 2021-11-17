/*
 * runtrace.c - Shell lab trace execution program
 *
 * Runs a tiny shell on a trace file.
 *
 * Copyright (c) 2004, R. Bryant and D. O'Hallaron, All rights reserved.
 * May not be used, modified, or copied without permission.
 */
#include "config.h"
#include "csapp.h"
#include <ctype.h>
#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#define RUNTRACE_TMP_FOLDER "runtrace.tmp"

/*
 * Global variables
 */
char buf[MAXBUF];
char line[MAXBUF];
char command[MAXBUF];
extern char **environ;
const char *state;
bool has_shellsync = false;

/* Modified by command line args */
int verbose = 0;
int sandboxing = 0;
char *tracefile = NULL;
const char *shellprog = "./tsh";
char *shellargs = NULL;

/* domain socket pairs */
int datafd[2];
int syncfd[2];
int shellsyncfd[2];

volatile sig_atomic_t cleanup_needed;
const char *cleanup_args[4] = {"/bin/sh", "-c", NULL, NULL};

/* Prototypes */
void usage(const char *msg);
int blankline(char *str);
void print_child_status(void);
int next_prompt(void);
void flush_output(void);
int readable(int fd, int secs);
void clean(sigset_t prev_all);
void atexit_clean(void);
/*
 * sigalrm_handler - Notify when we timeout waiting for the child
 */
static void sigalrm_handler(int sig) {
    // block signals
    sigset_t mask_all, prev_all;
    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("sigfillset error in sigalrm_handler\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("sigprocmask error in sigalrm_handler\n");
        _exit(1);
    }

    // print error message
    sio_printf("%s: Runtrace timed out while %s.\n", tracefile, state);

    // clean
    if (cleanup_needed) {
        clean(prev_all);
    }

    // exit
    _exit(1);
}

/* signal handler for SIGINT, SIGQUIT, SIGTERM and any signal causing exit */
static void graceful_cleanup_sig_handler(int sig) {
    // block signal
    sigset_t mask_all, prev_all;
    sio_printf("Cleaning up and exiting\n");

    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("sigfillset error in signal_handler\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("sigprocmask error in signal_handler\n");
        _exit(1);
    }

    // clean
    if (cleanup_needed) {
        clean(prev_all);
    }

    // disable handler
    Signal(sig, SIG_DFL);
    // reraise signal
    if (raise(sig) < 0) {
        sio_eprintf("signal re-raise error.");
        _exit(1);
    }
    // unblock signals
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
        sio_eprintf("sigprocmask error in signal_handler\n");
        _exit(1);
    }
    return;
}

/* Main routine */
int main(int argc, char **argv) {
    const char *shellargv[MAXARGS];
    int c;
    const char *bufp;
    FILE *tracefp;
    struct stat statbuf;
    char *fgets_result;
    pid_t child_pid;
    sigset_t mask_all, prev_all;

    /* Install the signal handler */
    Signal(SIGALRM, sigalrm_handler);
    Signal(SIGINT, graceful_cleanup_sig_handler);
    Signal(SIGQUIT, graceful_cleanup_sig_handler);
    Signal(SIGTERM, graceful_cleanup_sig_handler);
    Signal(SIGHUP, graceful_cleanup_sig_handler);

    if (atexit(atexit_clean)) {
        sio_eprintf("atexit");
        _exit(0);
    }

    /* Parse the command line */
    while ((c = getopt(argc, argv, "hVxs:f:")) != EOF) {
        switch (c) {
        case 'h': /* Print help message */
            usage("");
            break;
        case 'V': /* Be more verbose */
            verbose++;
            break;
        case 's': /* The shell program name (default ./tsh) */
            shellprog = strdup(optarg);
            break;
        case 'f': /* Trace file name */
            tracefile = strdup(optarg);
            break;
        case 'x':           /* Enable sandboxing */
            sandboxing = 1; /* Hidden argument */
            break;
        default:
            usage("Unrecognized argument");
        }
    }

    if (!tracefile) {
        usage("Missing required argument (-f)");
    }

    /* Make sure the requested shell is executable */
    if (stat(shellprog, &statbuf) < 0) {
        fprintf(stderr, "%s: File not found\n", shellprog);
        exit(1);
    }
    if (!(statbuf.st_mode & S_IXUSR)) {
        fprintf(stderr, "%s: File is not executable\n", shellprog);
        exit(1);
    }

    /* Open the trace file for reading */
    if ((tracefp = fopen(tracefile, "r")) == NULL) {
        fprintf(stderr, "Unable to open trace file %s\n", tracefile);
        exit(1);
    }

    /* Socket pair for data transfers between runtrace and shell */
    if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, datafd) < 0) {
        perror("socketpair datafd");
        exit(1);
    }

    /* Socket pair for synchronization between runtrace and shell jobs */
    if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, syncfd) < 0) {
        perror("socketpair syncfd");
        exit(1);
    }

    /*
     * Create an environment variable that tells shell jobs
     * such as myspin which descriptor to synchronize on.
     */
    snprintf(buf, sizeof(buf), "%d", syncfd[1]);
    if (setenv("SYNCFD", buf, 1) < 0) {
        perror("setenv");
        exit(1);
    }

    if (verbose) {
        printf("Created environment variable SYNFD=%s\n", buf);
    }

    // Before starting the shell read the comments and the sync directivies.
    // Stop when reaching the first non comment, non directive line.
    while ((fgets_result = fgets(line, MAXBUF, tracefp))) {

        /* Delete newline character */
        line[strlen(line) - 1] = '\0';

        /* Ignore blank lines */
        if (blankline(line)) {
            if (verbose) {
                printf("runtrace: Ignoring blank line\n");
            }
            continue;
        }

        /* Echo comment lines */
        if (line[0] == '#') {
            printf("%s\n", line);
            continue;
        }

        /* Parse the command line */
        sscanf(line, "%s", command);
        if (verbose) {
            printf("runtrace: command=%s line=%s\n", command, line);
        }

        /* SHELLSYNC directive */
        if (!strcmp(command, "SHELLSYNC")) {
            char option[MAXBUF];
            sscanf(line, "%s %s", command, option);
            snprintf(buf, sizeof(buf), "%s", option);
            has_shellsync = true;
            continue;
        }
        // this is neither a directive nor a comment, start the shell.
        break;

    } /* while loop */

    if (has_shellsync) {
        if (setenv("SHELLSYNC", buf, 1) < 0) {
            perror("setenv");
        }

        if (verbose) {
            printf("Created environment variable SHELLSYNC=%s\n", buf);
        }

        /* Socket pair for synchronization between runtrace and shell jobs */
        if (socketpair(AF_LOCAL, SOCK_DGRAM, 0, shellsyncfd) < 0) {
            perror("socketpair shellsyncfd");
            exit(1);
        }
        /*
         * Create an environment variable that tells shell jobs
         * such as myspin which descriptor to synchronize on.
         */
        snprintf(buf, sizeof(buf), "%d", shellsyncfd[1]);
        if (setenv("SHELLSYNCFD", buf, 1) < 0) {
            perror("setenv");
            exit(1);
        }

        if (verbose) {
            printf("Created environment variable SHELLSYNCFD=%s\n", buf);
        }
    }

    // block signals
    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("sigfillset error in main\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("sigprocmask error in main\n");
        _exit(1);
    }

    // create tmp directory

    if (mkdir(RUNTRACE_TMP_FOLDER, 0700) != 0) {
        if (errno == EEXIST) {
            fprintf(stderr,
                    "RUNTRACE ERROR: Temporary directory (%s) already exists.\n"
                    "  Make sure you aren't running the driver concurrently.\n"
                    "  Then run 'rm -rf %s/', and retry.\n",
                    RUNTRACE_TMP_FOLDER, RUNTRACE_TMP_FOLDER);
            _exit(1);
        } else {
            sio_eprintf("failed to create tmp directory");
            _exit(1);
        }
    }

    /*************************
     * Child code runs a shell
     *************************/
    if ((child_pid = fork()) == 0) {
        // restore signal handlers
        Signal(SIGALRM, SIG_DFL);
        Signal(SIGINT, SIG_DFL);
        Signal(SIGTERM, SIG_DFL);
        Signal(SIGQUIT, SIG_DFL);
        // unblock signals.
        if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
            sio_eprintf("sigprocmask error in fork\n");
            _exit(1);
        }
        pid_t session_id;
        /* Close the descriptor the child is not using */
        close(datafd[0]);

        if ((session_id = setsid()) < 0) {
            exit(-1);
        }

        /* Redirect stdin and stdout to the domain socket */
        dup2(datafd[1], 0);
        dup2(datafd[1], 1);

        /* Create the shell command line arguments */
        shellargv[0] = shellprog;
        if (verbose) {
            shellargv[1] = "-v";
            shellargv[2] = NULL;
        } else {
            shellargv[1] = NULL;
        }

        /* Modify the environment if sandboxing is enabled */
        if (sandboxing) {
            strcpy(line, "LD_PRELOAD=/usr/lib/libdl.so ./sandbox.so");
            putenv(line);
        }

        /* Now go ahead and run the shell */
        if (execve(shellprog, (char *const *)shellargv, environ) < 0) {
            perror("execve");
            exit(1);
        }
    }

    /********************************************************
     * Parent code sends trace-driven commands to child shell
     *******************************************************/

    // set up cleanup, then unblock signals.
    {
        char *cleanup_cmd;
        if (asprintf(&cleanup_cmd,
                     "/bin/kill -9 $(/bin/ps -s %d -o pid=) > /dev/null 2>&1;"
                     " rm -Rf %s",
                     child_pid, RUNTRACE_TMP_FOLDER) < 0) {
            sio_eprintf("asprintf error");
            _exit(1);
        }
        cleanup_args[2] = cleanup_cmd;
        cleanup_needed = 1;
    }

    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
        sio_eprintf("sigprocmask error in main\n");
        _exit(1);
    }

    /* Close the descriptor the parent is not using */
    close(datafd[1]);

    /* Read the initial prompt from the shell */
    if (readable(datafd[0], DRIVER_TIMEOUT) == 0) {
        fprintf(stderr,
                "%s: Runtrace timed out waiting for initial shell prompt\n",
                tracefile);
        if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
            sio_eprintf("sigprocmask error in main\n");
            _exit(1);
        }
        print_child_status();
        clean(prev_all);
        exit(1);
    } else {
        memset(buf, 0, MAXBUF);
        recv(datafd[0], buf, MAXBUF, 0);
        if (strcmp(buf, PROMPT)) {
            fprintf(stderr,
                    "%s: Runtrace expected initial shell prompt but got '%s' "
                    "instead.\n",
                    tracefile, buf);
            if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
                sio_eprintf("sigprocmask error in main\n");
                _exit(1);
            }
            print_child_status();
            clean(prev_all);
            exit(1);
        }
    }

    /*
     * Parent reads trace file and sends commands to the shell
     */
    while (fgets_result) {

        /* Ignore blank lines */
        if (blankline(line)) {
            if (verbose) {
                printf("runtrace: Ignoring blank line\n");
            }
            /* comments */
        } else if (line[0] == '#') {
            printf("%s\n", line);
            /* WAIT command */
        } else if (!strcmp(command, "WAIT")) {
            if (readable(syncfd[0], DRIVER_TIMEOUT) == 0) {
                printf("%s: Runtrace timed out waiting for sync from job\n",
                       tracefile);
                if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
                    sio_eprintf("sigprocmask error in main\n");
                    _exit(1);
                }
                print_child_status();
                clean(prev_all);
                exit(1);
            } else {
                memset(buf, 0, MAXBUF);
                if ((recv(syncfd[0], buf, MAXBUF, 0)) < 0) {
                    perror("recv syncfd");
                    exit(1);
                }
                if (verbose) {
                    printf("runtrace: received sync from job\n");
                }
            }
            /* SHELLWAIT command */
        } else if (!strcmp(command, "SHELLWAIT")) {
            if (readable(shellsyncfd[0], DRIVER_TIMEOUT) == 0) {
                printf(
                    "%s: Runtrace timed out waiting for sync from the shell\n",
                    tracefile);
                if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
                    sio_eprintf("sigprocmask error in main\n");
                    _exit(1);
                }
                print_child_status();
                clean(prev_all);
                exit(1);
            } else {
                memset(buf, 0, MAXBUF);
                if ((recv(shellsyncfd[0], buf, MAXBUF, 0)) < 0) {
                    perror("recv shellsyncfd");
                    exit(1);
                }
                if (verbose) {
                    printf("runtrace: received sync from shell\n");
                }
            }
            /* NEXT command */
        } else if (!strcmp(command, "NEXT")) {
            if (next_prompt() == 0) {
                if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
                    sio_eprintf("sigprocmask error in main\n");
                    _exit(1);
                }
                print_child_status();
                clean(prev_all);
                exit(0);
            }
            /* SIGNAL command */
        } else if (!strcmp(command, "SIGNAL")) {
            bufp = "signal";
            if ((send(syncfd[0], bufp, strlen(bufp), 0)) < 0) {
                perror("send syncfd");
                exit(1);
            }
            if (verbose) {
                printf("runtrace: sent sync to job\n");
            }
            /* SHELLSIGNAL command */
        } else if (!strcmp(command, "SHELLSIGNAL")) {
            bufp = "signal";
            if ((send(shellsyncfd[0], bufp, strlen(bufp), 0)) < 0) {
                perror("send shellsyncfd");
                exit(1);
            }
            if (verbose) {
                printf("runtrace: sent sync to shell\n");
            }
            /* SIGINT command */
        } else if (!strcmp(command, "SIGINT")) {
            if (kill(child_pid, SIGINT) < 0) {
                perror("kill SIGINT");
                exit(1);
            }
            if (verbose) {
                printf("Runtrace sent SIGINT to process %d\n", child_pid);
            }
            /* SIGTSTP command */
        } else if (!strcmp(command, "SIGTSTP")) {
            if (kill(child_pid, SIGTSTP) < 0) {
                perror("kill SIGTSTP");
                exit(1);
            }
            if (verbose) {
                printf("Runtrace sent SIGTSTP to process %d\n", child_pid);
            }
            /* PID command : PID name fg/bg
             * sends fg/bg $(pgrep -s session_id name) to the shell */
        } else if (!strcmp(command, "PID")) {
            char name[MAXBUF];
            char builtin[MAXBUF];
            FILE *pgrep_output;
            if (sscanf(line, "%s %s %s", command, name, builtin) != 3) {
                perror("Invalid command in trace");
                exit(1);
            }
            if (snprintf(command, sizeof(command), "/usr/bin/pgrep -s %d %s",
                         child_pid, name) >= (int)sizeof(command)) {
                perror("snprintf");
                exit(1);
            }
            pgrep_output = popen(command, "r");
            if (!pgrep_output) {
                perror("popen error");
                exit(1);
            }
            if (fgets(name, sizeof(name) - 1, pgrep_output) == NULL) {
                perror("fgets error");
                exit(1);
            }
            if (pclose(pgrep_output) < 0) {
                perror("pclose error");
                exit(1);
            }
            if (snprintf(command, sizeof(command), "%s %s", builtin, name) >=
                (int)sizeof(command)) {
                perror("snprintf");
                exit(1);
            }
            if ((send(datafd[0], command, strlen(command), 0)) < 0) {
                perror("send datafd[0]");
                exit(1);
            }

            if (verbose) {
                printf("sending '%s' to shell\n", command);
            }

            /* Pass the command line on to the shell */
        } else {
            if (verbose) {
                printf("runtrace: Sending '%s' to shell\n", line);
            }
            strcat(line, "\n");
            if ((send(datafd[0], line, strlen(line), 0)) < 0) {
                perror("send datafd[0]");
                exit(1);
            }
        }

        fgets_result = fgets(line, MAXBUF, tracefp);
        if (fgets_result) {
            /* Delete newline character */
            line[strlen(line) - 1] = '\0';
            if (blankline(line)) {
                continue;
            }
            /* Echo comment lines */
            if (line[0] == '#') {
                continue;
            }

            /* Parse the command line */
            sscanf(line, "%s", command);
            if (verbose) {
                printf("runtrace: command=%s line=%s\n", command, line);
            }
        }
    } /* while loop */

    /* Signal EOF to the shell */
    bufp = "";
    send(datafd[0], bufp, 0, 0);

    /* Wait for the shell to terminate */
    alarm(DRIVER_TIMEOUT);
    state = "waiting for shell to terminate";
    waitpid(child_pid, NULL, 0);
    flush_output();

    /* Kill any of our stray shells and jobs */
    // block signals
    if (sigfillset(&mask_all) < 0) {
        sio_eprintf("sigfillset error in main cleanup\n");
        _exit(1);
    }
    if (sigprocmask(SIG_BLOCK, &mask_all, &prev_all) < 0) {
        sio_eprintf("sigprocmask error in main cleanup\n");
        _exit(1);
    }
    clean(prev_all);
    // unblock signals
    if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
        sio_eprintf("sigprocmask error in fork\n");
        _exit(1);
    }

    exit(0);
}

/*
 * clean - clean up any stray jobs or shells
 */
void clean(sigset_t prev_all) {
    // fork
    // in child :
    //  reset signals
    //  exec sh with appropriate arguments
    // in parent
    // waitpid
    // return
    pid_t pid;
    if ((pid = fork()) == 0) {
        // child process
        // restore signal handlers
        Signal(SIGALRM, SIG_DFL);
        Signal(SIGINT, SIG_DFL);
        Signal(SIGTERM, SIG_DFL);
        Signal(SIGQUIT, SIG_DFL);
        // unblock signals.
        if (sigprocmask(SIG_SETMASK, &prev_all, NULL) < 0) {
            sio_eprintf("sigprocmask error in fork\n");
            _exit(1);
        }
        execv("/bin/sh", (char *const *)cleanup_args);
    }
    waitpid(pid, NULL, 0);
    cleanup_needed = 0;
    return;
}

void atexit_clean(void) {
    if (cleanup_needed) {
        sigset_t prev_all;
        if (sigprocmask(SIG_SETMASK, NULL, &prev_all) < 0) {
            sio_eprintf("sigprocmask error in atexit_clean\n");
            _exit(1);
        }
        clean(prev_all);
    }
}

/*
 * usage - Print help message and terminate
 */
void usage(const char *msg) {
    printf("%s\n", msg);
    printf("Usage: runtrace -f <file> -s <shellprog> [-hV]\n");
    printf("Options:\n");
    printf("  -h            Print this message\n");
    printf("  -s <shell>    Shell program to test (default ./tsh)\n");
    printf("  -f <file>     Trace file\n");
    printf("  -V            Be more verbose\n");

    exit(0);
}

/*
 * blankline - Return true if str is a blank line
 */
int blankline(char *str) {
    while (*str) {
        if (!isspace(*str++)) {
            return 0;
        }
    }
    return 1;
}

/*
 * print_child_status - Print the exit/termination status of the shell after a
 * timeout
 */
void print_child_status(void) {
    pid_t pid;
    int status;

    pid = waitpid(-1, &status, WNOHANG);

    // flush child output here
    flush_output();

    if (pid > 0) {
        if (WIFEXITED(status)) {
            printf("Child shell terminated normally with status %d\n",
                   WEXITSTATUS(status));
            fflush(stdout);
            return;
        }

        if (WIFSIGNALED(status)) {
            printf("Child shell terminated by signal %d\n", WTERMSIG(status));
            fflush(stdout);
            return;
        }

        if (WIFSTOPPED(status)) {
            printf("Child shell stopped by signal %d\n", WSTOPSIG(status));
            fflush(stdout);
            return;
        }
    } else if (pid == 0) {
        printf("Child shell still running.\n");
        fflush(stdout);
        return;
    } else if (pid < 0 && errno == ECHILD) {
        printf("Child shell appears to have never run\n");
        fflush(stdout);
        return;
    } else {
        printf("Unknown child status\n");
        fflush(stdout);
        return;
    }
}

/*
 * next_prompt - Print the shell response until the next prompt or EOF
 *               Returns 1 if OK, 0 on EOF or timeout
 */
int next_prompt(void) {
    int n;
    struct timeval tv;
    fd_set rset, readable_set;
    const char *bufp;

    memset(buf, 0, MAXBUF);
    FD_ZERO(&rset);

    int maxfd = datafd[0];
    FD_SET(datafd[0], &rset);
    if (has_shellsync) {
        FD_SET(shellsyncfd[0], &rset);
        maxfd = (maxfd < shellsyncfd[0]) ? shellsyncfd[0] : maxfd;
    }

    tv.tv_sec = DRIVER_TIMEOUT;
    tv.tv_usec = 0;
    readable_set = rset;
    while ((n = select(maxfd + 1, &readable_set, NULL, NULL, &tv)) > 0) {
        if (FD_ISSET(shellsyncfd[0], &readable_set)) {
            if ((recv(shellsyncfd[0], buf, MAXBUF, 0)) < 0) {
                perror("recv shellsyncfd");
                exit(1);
            }
            if (verbose) {
                printf(
                    "runtrace: received sync from shell waiting for prompt\n");
            }
            // shell wait and shell signal
            bufp = "shell signal";
            if ((send(shellsyncfd[0], bufp, strlen(bufp), 0)) < 0) {
                perror("send syncfd");
                exit(1);
            }
            if (verbose) {
                printf("runtrace: sent sync to job waiting for prompt\n");
            }
            memset(buf, 0, MAXBUF);
        }
        if (FD_ISSET(datafd[0], &readable_set)) {
            ssize_t nread;
            if ((nread = recv(datafd[0], buf, MAXBUF, 0)) < 0) {
                perror("next_prompt:recv1");
                exit(1);
            } else if (nread == 0) {
                return 0;
            } else if (!strcmp(buf, PROMPT)) {
                return 1;
            } else {
                printf("%s", buf);
            }
            memset(buf, 0, MAXBUF);
        }
        readable_set = rset;
    }
    if (n < 0) {
        perror("select");
        exit(1);
    } else {
        printf("%s: Runtrace timed out waiting for next shell prompt\n",
               tracefile);
        return 0;
    }
}

/*
 * flush_output - print all the available shell output to stdout
 */
void flush_output(void) {
    ssize_t n;
    if (verbose) {
        printf("--FLUSHING OUTPUT--\n");
    }

    memset(buf, 0, MAXBUF);

    while (readable(datafd[0], 0)) {
        n = recv(datafd[0], buf, MAXBUF, 0);
        if (n < 0) {
            perror("flush:recv");
            exit(1);
        }
        if (n == 0) {
            break; // EOF
        }
        printf("%s", buf);
        memset(buf, 0, MAXBUF);
    }
    fflush(stdout);
}

/*
 * readable - Wait secs seconds for descriptor fd to become readable
 *            Return > 0 if fd is readable, 0 if timeout.
 */
int readable(int fd, int secs) {
    int n;

    fd_set rset;
    struct timeval tv;

    FD_ZERO(&rset);
    FD_SET(fd, &rset);

    tv.tv_sec = secs;
    tv.tv_usec = 0;

    if ((n = select(fd + 1, &rset, NULL, NULL, &tv)) < 0) {
        perror("select");
        exit(1);
    }

    return n;
}
