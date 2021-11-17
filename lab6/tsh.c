/**
 * @file tsh.c
 * @brief A tiny shell program with job control
 *
 * <The line above is not a sufficient documentation.
 *  You will need to write your program documentation.
 *  Follow the 15-213/18-213/15-513 style guide at
 *  http://www.cs.cmu.edu/~213/codeStyle.html.>
 * @author Yuchen Cao <yuchenca@andrew.cmu.edu>
 *
 * This program creates an interactive shell with some basic functionalities.
 * It parses single command line that the user types in to the shell and
 * performs the tasks requested. Some of the commands that my shell handles
 * include the built-ins (list-jobs, quit, etc.) and others such as echo. This
 * shell has one job running in the foreground which is always waited for to be
 * terminated while there could be multiple jobs in the background.
 * This program provides a TSH, customized shell to serve some basic
 * interactions. User can input either build-in commands or signal like CTRL-Z
 * or CTRL-C, or run files from the shell. The TSH parses those commands
 * respectively and translate into inner instrcutions/flags.
 */

#include "csapp.h"
#include "tsh_helper.h"

#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

/*
 * If DEBUG is defined, enable contracts and printing on dbg_printf.
 */
#ifdef DEBUG
/* When debugging is enabled, these form aliases to useful functions */
#define dbg_printf(...) printf(__VA_ARGS__)
#define dbg_requires(...) assert(__VA_ARGS__)
#define dbg_assert(...) assert(__VA_ARGS__)
#define dbg_ensures(...) assert(__VA_ARGS__)
#else
/* When debugging is disabled, no code gets generated for these */
#define dbg_printf(...)
#define dbg_requires(...)
#define dbg_assert(...)
#define dbg_ensures(...)
#endif

/* Function prototypes */
void eval(const char *cmdline);

void sigchld_handler(int sig);
void sigtstp_handler(int sig);
void sigint_handler(int sig);
void sigquit_handler(int sig);
void cleanup(void);

pid_t Fork(void);
void Execve(const char *filename, char *const argv[], char *const envp[]);
void Sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
void Sigemptyset(sigset_t *set);
void Sigaddset(sigset_t *set, int signum);
void Sigfillset(sigset_t *set);
void Kill(pid_t pid, int sig);
void bg_fg(char **argv, int status);
//-----------------------Wrapper Functions--------------------------
// The wrappers are not mandatory according to the handout.
pid_t Fork(void) {
    pid_t pid;
    if ((pid = fork()) < 0) {
        perror("fork error");
    }
    return pid;
}

void Execve(const char *filename, char *const argv[], char *const envp[]) {
    if (execve(filename, argv, envp) < 0) {
        perror("execve error");
    }
    return;
}

void Sigprocmask(int how, const sigset_t *set, sigset_t *oldset) {
    if (sigprocmask(how, set, oldset) < 0) {
        perror("sigprocmask error");
    }
    return;
}

void Sigemptyset(sigset_t *set) {
    if (sigemptyset(set) < 0) {
        perror("sigemptyset error");
    }
    return;
}

void Sigaddset(sigset_t *set, int signum) {
    if (sigaddset(set, signum) < 0) {
        perror("sigaddset error");
    }
    return;
}

void Sigfillset(sigset_t *set) {
    if (sigfillset(set) < 0) {
        perror("sigfillset error");
    }
    return;
}

void Kill(pid_t pid, int sig) {
    if (kill(pid, sig) < 0) {
        perror("kill error");
    }
    return;
}
/**
 * @brief main function initialize a shell environment and install signals for
 * interaction.
 *
 * main function prepares error export so that stderr can transfer to stdout to
 * get log and debug; it uses getopt() to listen to input when main is called,
 * with "help"m "verbose" and "printing" arguments; it also sets up reading
 * method as line buffering, it clears out put buffer and moves buffered data to
 * console, it reads until encounter the EOF to return, otherwise it reads in
 * the whole line. Besides, it converts "\n" to "\0" for print purpose. The main
 * function also installs signal of sigchld_handler, sigtstp_handler,
 * sigint_handler, and call eval() to evaluate the input from prompt, and take
 * actions.
 *
 */
int main(int argc, char **argv) {
    int c;
    char cmdline[MAXLINE_TSH]; // Cmdline for fgets
    bool emit_prompt = true;   // Emit prompt (default)

    // Redirect stderr to stdout (so that driver will get all output
    // on the pipe connected to stdout)
    if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
        perror("dup2 error");
        exit(1);
    }

    // Parse the command line
    while ((c = getopt(argc, argv, "hvp")) != EOF) {
        switch (c) {
        case 'h': // Prints help message
            usage();
            break;
        case 'v': // Emits additional diagnostic info
            verbose = true;
            break;
        case 'p': // Disables prompt printing
            emit_prompt = false;
            break;
        default:
            usage();
        }
    }

    // Create environment variable
    if (putenv(strdup("MY_ENV=42")) < 0) {
        perror("putenv error");
        exit(1);
    }

    // Set buffering mode of stdout to line buffering.
    // This prevents lines from being printed in the wrong order.
    if (setvbuf(stdout, NULL, _IOLBF, 0) < 0) {
        perror("setvbuf error");
        exit(1);
    }

    // Initialize the job list
    init_job_list();

    // Register a function to clean up the job list on program termination.
    // The function may not run in the case of abnormal termination (e.g. when
    // using exit or terminating due to a signal handler), so in those cases,
    // we trust that the OS will clean up any remaining resources.
    if (atexit(cleanup) < 0) {
        perror("atexit error");
        exit(1);
    }

    // Install the signal handlers
    Signal(SIGINT, sigint_handler);   // Handles Ctrl-C
    Signal(SIGTSTP, sigtstp_handler); // Handles Ctrl-Z
    Signal(SIGCHLD, sigchld_handler); // Handles terminated or stopped child

    Signal(SIGTTIN, SIG_IGN);
    Signal(SIGTTOU, SIG_IGN);

    Signal(SIGQUIT, sigquit_handler);

    // Execute the shell's read/eval loop
    while (true) {
        if (emit_prompt) {
            printf("%s", prompt);

            // We must flush stdout since we are not printing a full line.
            fflush(stdout);
        }

        if ((fgets(cmdline, MAXLINE_TSH, stdin) == NULL) && ferror(stdin)) {
            perror("fgets error");
            exit(1);
        }

        if (feof(stdin)) {
            // End of file (Ctrl-D)
            printf("\n");
            return 0;
        }

        // Remove any trailing newline
        char *newline = strchr(cmdline, '\n');
        if (newline != NULL) {
            *newline = '\0';
        }

        // Evaluate the command line
        eval(cmdline);
    }

    return -1; // control never reaches here
}

/**
 * @brief eval parses a command line to the token struct containing relatble
 * info, such as the arguments array (argv). If the command does not contain a
 * builtin command (call builtin_command() to verify), then it forks a child
 * process and call execve() to perform what is being requested. Before calling
 * execve and after forking, implement redirect I/O. After calling execve(), we
 * update the job list with the appropriate job state.
 * @param[in] cmdline takes in a command line put in by the user
 **/
void eval(const char *cmdline) {
    parseline_return parse_result;
    struct cmdline_tokens token;

    // Parse command line
    parse_result = parseline(cmdline, &token);

    if (parse_result == PARSELINE_ERROR || parse_result == PARSELINE_EMPTY) {
        return;
    }

    pid_t pid;
    sigset_t mask, prev;

    if (token.builtin == BUILTIN_NONE) {
        // builtin commands would be handled separately
        Sigemptyset(&mask);
        Sigaddset(&mask, SIGINT);
        Sigaddset(&mask, SIGTSTP);
        Sigaddset(&mask, SIGCHLD);
        Sigprocmask(SIG_BLOCK, &mask, &prev);
        if ((pid = Fork()) == 0) {
            // child runs the newly created user job
            // assign each new child process a group ID
            setpgid(0, 0);
            Sigprocmask(SIG_SETMASK, &prev, NULL);
            char *infile = token.infile;
            char *outfile = token.outfile;
            if (infile != NULL) {
                int fd1 = open(infile, O_RDONLY);
                if (fd1 == -1) {
                    // perror("no permission to this file");
                    // sio_printf("%s:", infile);
                    perror(infile);
                    exit(-1);
                }
                dup2(fd1, STDIN_FILENO);
                close(fd1);
            }
            if ((outfile != NULL)) {
                int fd2 = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, DEF_MODE);
                if (fd2 == -1) {
                    // perror("no permission to this file");
                    // sio_printf("%s:", outfile);
                    perror(outfile);
                    exit(-1);
                }
                dup2(fd2, STDOUT_FILENO);
                close(fd2);
            }
            int exec_result = execve(token.argv[0], token.argv, environ);
            if (exec_result < 0) {
                sio_printf("%s: Command not found\n", token.argv[0]);
                exit(-1);
            }
        }
        // the following code is for the parent
        // block all signals when we are accessing the global variables using
        // add_job(), delete_job(), and waitpid().
        if (parse_result == PARSELINE_BG) {
            // if the job is a job in the background
            job_state cur_state = BG;
            add_job(pid, cur_state, cmdline);
            jid_t job = job_from_pid(pid);
            sio_printf("[%d] (%d) %s \n", job, pid, cmdline);
        } else {
            // if the job runs in the foreground
            job_state cur_state = FG;
            add_job(pid, cur_state, cmdline);
        }
        if (parse_result != PARSELINE_BG) {
            while (fg_job() != 0) {
                // while there is a foreground job, wait for it to terminate
                sigsuspend(&prev);
            }
        }
        Sigprocmask(SIG_SETMASK, &prev, NULL);
    } else if (token.builtin == BUILTIN_QUIT) {
        exit(0);
    } else if (token.builtin == BUILTIN_JOBS) {
        Sigemptyset(&mask);
        Sigaddset(&mask, SIGINT);
        Sigaddset(&mask, SIGTSTP);
        Sigaddset(&mask, SIGCHLD);
        Sigprocmask(SIG_BLOCK, &mask, &prev);
        char *outfile = token.outfile;
        if ((outfile != NULL)) {
            int fd2 = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, DEF_MODE);
            if (fd2 == -1) {
                // perror("no permission to this file")
                perror(outfile);
                exit(-1);
            }
            list_jobs(fd2);
            close(fd2);
        } else {
            list_jobs(STDOUT_FILENO);
        }
        Sigprocmask(SIG_SETMASK, &prev, NULL);
    } else if (token.builtin == BUILTIN_BG) {
        bg_fg(token.argv, BG);
    } else if (token.builtin == BUILTIN_FG) {
        bg_fg(token.argv, FG);
    }
}
/**
 * @brief bg_fg function transfer process between background and foreground
 * The function detects whether there is "%" as background sign to decide the
 *action. If there is "%", then put the process to the background, otherwise to
 *foreground.
 *
 * @param[in] argv refers to arguments from input
 * @param[in] status refers to BG or FG
 **/
void bg_fg(char **argv, int status) {
    /* check argv to see if proper format */
    if (argv[1] == NULL) { // Checks if it has second argument
        printf("%s command requires PID or %%jobid argument\n", argv[0]);
        return;
    }

    if (!isdigit(argv[1][0]) &&
        argv[1][0] != '%') { // Checks if the second argument is valid
        printf("%s: argument must be a PID or %%jobid\n", argv[0]);
        return;
    }

    sigset_t mask, prev;
    Sigemptyset(&mask);
    Sigaddset(&mask, SIGINT);
    Sigaddset(&mask, SIGTSTP);
    Sigaddset(&mask, SIGCHLD);
    // block all signals as we are accessing global variables.
    Sigprocmask(SIG_BLOCK, &mask, &prev);
    jid_t new_job = 0;
    pid_t new_pid = 0;
    const char *cmd_line;
    if (argv[1][0] == '%') {
        new_job = atoi(&argv[1][1]);
        if (!job_exists(new_job)) { // Checks if the given JID is alive
            printf("%s: No such job\n", argv[1]);
            return;
        }
        // if the job argument is a JID
        new_pid = job_get_pid(new_job);
    } else {
        // the job argument is a PID
        new_pid = atoi(&argv[1][0]);
        new_job = job_from_pid(new_pid);
        if (!job_exists(new_job)) { // Checks if the given JID is alive
            printf("%s: No such process\n", argv[1]);
            return;
        }
    }
    Kill(-new_pid, SIGCONT);
    cmd_line = job_get_cmdline(new_job);

    if (status == BG) {
        // add_job(new_pid, BG, cmd_line);
        job_set_state(new_job, BG);
        sio_printf("[%d] (%d) %s \n", new_job, new_pid, cmd_line);
    }
    if (status == FG) {
        job_set_state(new_job, FG);
        while (fg_job() != 0) {
            sigset_t mask_one;
            Sigemptyset(&mask_one);
            // while there is a foreground job
            sigsuspend(&mask_one);
        }
    }
    Sigprocmask(SIG_SETMASK, &prev, NULL);
    return;
}

/*****************
 * Signal handlers
 *****************/

/** Handler for SIGCHLD signals
 * @brief When a child terminates or stops because it received a SIGSTOP, SIGSTP
 * SIGTTIN, or SIGTTOU signal, the kernel sends a SIGCHLD to the shell.
 * @param[in] sig, signal of child process to be handled.
 * The signal handler sigchld_handler would reap all children that have just
 * become zombies.
 * Case 1: If the child was stopped by a signal, set the state to ST, print out
 * the signal; Case 2: if the child was terminated by a signal, also print that
 * out and delete the job Case 3: iF the child was run to termination, just
 * delete it
 */
void sigchld_handler(int sig) {
    int status;
    pid_t pid;
    int olderrno = errno;
    // alwways save and restore the errno flag
    sigset_t mask, prev_mask;
    Sigemptyset(&mask);
    Sigaddset(&mask, SIGCHLD);
    Sigaddset(&mask, SIGTSTP);
    Sigaddset(&mask, SIGINT);
    Sigprocmask(SIG_BLOCK, &mask, &prev_mask);
    // block all signals when accessing the job list (global)
    while ((pid = waitpid(-1, &status, WNOHANG | WUNTRACED | WCONTINUED)) > 0) {
        jid_t job = job_from_pid(pid);
        if (WIFSTOPPED(status)) {
            // if the child was stopped by a signal
            // delete the old job and add a new one with the state set to ST
            // job_set_state(job, ST);
            job_set_state(job, ST);
            sio_printf("Job [%d] (%d) stopped by signal %d \n", job, pid,
                       WSTOPSIG(status));
        } else if (WIFSIGNALED(status)) {
            // if the child was terminated by a signal that was not caught
            sio_printf("Job [%d] (%d) terminated by signal %d \n", job, pid,
                       WTERMSIG(status));
            delete_job(job);
        } else if (WIFCONTINUED(status)) {

        } else {
            // sio_printf("deleted job: %d \n", job);
            delete_job(job);
        }
    }
    Sigprocmask(SIG_SETMASK, &prev_mask, NULL); // restore the blocked signal
    errno = olderrno;
    return;
}

/**
 * @brief handler for SIGINT signals
 * @param[in] sig: input signal to be sent to the foreground job
 * handler handles Ctrl-C from the keyboard. When the shell receives this
 * signal from the kernel, the handler sends it to the foreground if there
 * exists such one.
 */
void sigint_handler(int sig) {
    int olderrno = errno;
    sigset_t mask, pre_mask;
    Sigemptyset(&mask);
    Sigaddset(&mask, SIGCHLD);
    Sigaddset(&mask, SIGTSTP);
    Sigaddset(&mask, SIGINT);
    Sigprocmask(SIG_BLOCK, &mask, &pre_mask);
    // block signals
    jid_t fg_jobs = fg_job();
    if (fg_jobs != 0) {
        pid_t fg_pids = job_get_pid(fg_jobs);
        Kill(-fg_pids, sig);
    }
    Sigprocmask(SIG_SETMASK, &pre_mask, NULL); // restore the blocked signal
    errno = olderrno;
    return;
}

/**
 * @brief handler for SIGSTP signals
 * @param[in] sig, input signal to be sent to the foreground job
 * handler handles Ctrl-Z from the keyboard. When the shell receives this
 * signal from the kernel, the handler sends it to the foreground if there
 * exists such one.
 */
void sigtstp_handler(int sig) {
    int olderrno = errno;
    sigset_t mask, pre_mask;
    Sigemptyset(&mask);
    Sigaddset(&mask, SIGCHLD);
    Sigaddset(&mask, SIGTSTP);
    Sigaddset(&mask, SIGINT);
    Sigprocmask(SIG_BLOCK, &mask, &pre_mask); // block signal
    jid_t fg_jobs = fg_job();
    if (fg_jobs != 0) {
        // if fg_job() returns 0, then there is no foreground job
        pid_t fg_pids = job_get_pid(fg_jobs);
        Kill(-fg_pids, sig);
    }
    Sigprocmask(SIG_SETMASK, &pre_mask, NULL);
    errno = olderrno;
    return;
}

/**
 * @brief Attempt to clean up global resources when the program exits.
 *
 * In particular, the job list must be freed at this time, since it may
 * contain leftover buffers from existing or even deleted jobs.
 */
void cleanup(void) {
    // Signals handlers need to be removed before destroying the joblist
    Signal(SIGINT, SIG_DFL);  // Handles Ctrl-C
    Signal(SIGTSTP, SIG_DFL); // Handles Ctrl-Z
    Signal(SIGCHLD, SIG_DFL); // Handles terminated or stopped child

    destroy_job_list();
}
