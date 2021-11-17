/**
 * @file tsh_helper.c
 * @brief Helper routines for tshlab.
 *
 * This file does not contain extensive documentation. For documentation
 * related to usage, see the corresponding header file at tsh_helper.h.
 */

#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "csapp.h"
#include "tsh_helper.h"

// Struct used to store jobs
struct job_t {
    pid_t pid;       // Job PID
    jid_t jid;       // Job ID [1, 2, ...] defined in tsh_helper.c
    job_state state; // UNDEF, BG, FG, or ST
    char *cmdline;   // Command line
};

// Parsing states, used internally in parseline
typedef enum parse_state { ST_NORMAL, ST_INFILE, ST_OUTFILE } parse_state;

/* Global variables */
const char prompt[] = "tsh> "; // Command line prompt (do not change)
bool verbose = false;          // If true, prints additional output

/* Static variables */
static bool check_block = true; // If true, check that signals are blocked
static struct job_t job_list[MAXJOBS]; // The job list
static jid_t nextjid = 1;              // Next job ID to allocate

static bool init = false;

/*
 * parseline - Parse the command line and build the argv array.
 * Not async-signal-safe.
 */
parseline_return parseline(const char *cmdline, struct cmdline_tokens *token) {
    const char delims[] = " \t\r\n"; // argument delimiters (white-space)
    char *buf;                       // ptr that traverses command line
    char *next;                      // ptr to the end of the current arg
    char *endbuf;                    // ptr to end of cmdline string

    parse_state parsing_state; // indicates if the next token is the
                               // input or output file

    if (cmdline == NULL) {
        if (verbose) {
            fprintf(stderr, "Error: command line is NULL\n");
        }
        return PARSELINE_EMPTY;
    }

    strncpy(token->_buf, cmdline, MAXLINE_TSH);
    token->_buf[MAXLINE_TSH - 1] = '\0';

    buf = token->_buf;
    endbuf = buf + strlen(buf);

    // initialize default values
    token->argc = 0;
    token->infile = NULL;
    token->outfile = NULL;

    /* Build the argv list */
    parsing_state = ST_NORMAL;

    while (buf < endbuf) {
        /* Skip the white-spaces */
        buf += strspn(buf, delims);
        if (buf >= endbuf)
            break;

        /* Check for I/O redirection specifiers */
        if (*buf == '<') {
            if (token->infile) { // infile already exists
                if (verbose) {
                    fprintf(stderr, "Error: Ambiguous I/O redirection\n");
                }
                return PARSELINE_ERROR;
            }
            parsing_state = ST_INFILE;
            buf++;
            continue;
        } else if (*buf == '>') {
            if (token->outfile) { // outfile already exists
                if (verbose) {
                    fprintf(stderr, "Error: Ambiguous I/O redirection\n");
                }
                return PARSELINE_ERROR;
            }
            parsing_state = ST_OUTFILE;
            buf++;
            continue;
        } else if (*buf == '\'' || *buf == '\"') {
            /* Detect quoted tokens */
            buf++;
            next = strchr(buf, *(buf - 1));
        } else {
            /* Find next delimiter */
            next = buf + strcspn(buf, delims);
        }

        if (next == NULL) {
            /* Returned by strchr(); this means that the closing
               quote was not found. */
            if (verbose) {
                fprintf(stderr, "Error: unmatched %c.\n", *(buf - 1));
            }
            return PARSELINE_ERROR;
        }

        /* Terminate the token */
        *next = '\0';

        /* Record the token as either the next argument or the i/o file */
        switch (parsing_state) {
        case ST_NORMAL:
            token->argv[token->argc] = buf;
            token->argc = token->argc + 1;
            break;
        case ST_INFILE:
            token->infile = buf;
            break;
        case ST_OUTFILE:
            token->outfile = buf;
            break;
        default:
            fprintf(stderr, "Error: Ambiguous I/O redirection\n");
            return PARSELINE_ERROR;
        }
        parsing_state = ST_NORMAL;

        /* Check if argv is full */
        if (token->argc >= MAXARGS - 1)
            break;

        buf = next + 1;
    }

    if (parsing_state != ST_NORMAL) { // buf ends with < or >
        fprintf(stderr, "Error: must provide file name for redirection\n");
        return PARSELINE_ERROR;
    }

    /* The argument list must end with a NULL pointer */
    token->argv[token->argc] = NULL;

    if (token->argc == 0) { /* ignore blank line */
        return PARSELINE_EMPTY;
    }

    if ((strcmp(token->argv[0], "quit")) == 0) { /* quit command */
        token->builtin = BUILTIN_QUIT;
    } else if ((strcmp(token->argv[0], "jobs")) == 0) { /* jobs command */
        token->builtin = BUILTIN_JOBS;
    } else if ((strcmp(token->argv[0], "bg")) == 0) { /* bg command */
        token->builtin = BUILTIN_BG;
    } else if ((strcmp(token->argv[0], "fg")) == 0) { /* fg command */
        token->builtin = BUILTIN_FG;
    } else {
        token->builtin = BUILTIN_NONE;
    }

    // Returns 5 if job runs on background; 4 if job runs on foreground

    if (*token->argv[(token->argc) - 1] == '&') {
        token->argv[--(token->argc)] = NULL;
        if (token->argc == 0) {
            return PARSELINE_EMPTY;
        }
        return PARSELINE_BG;
    } else {
        return PARSELINE_FG;
    }
}

/*****************
 * Signal handlers
 *****************/

void sigquit_handler(int sig) {
    sio_printf("Terminating after receipt of SIGQUIT signal\n");
    _exit(1);
}

/*********************
 * End signal handlers
 *********************/

/***********************************************
 * Helper routines that manipulate the job list
 **********************************************/

/*
 * check_blocked - Make sure that signals are blocked
 * Async-signal safe except in case of unix_error; see csapp.h
 */
static void check_blocked(void) {
    if (!init) {
        sio_eprintf("WARNING: failed to call init_job_list\n");
    }
    if (!check_block) {
        return;
    }

    // Ensure the current signal set contains SIGCHLD, SIGINT, SIGTSTP
    // Printing output should cause the trace to fail
    sigset_t currmask;
    sigprocmask(SIG_SETMASK, NULL, &currmask);

    bool sigchld_unblocked = sigismember(&currmask, SIGCHLD) <= 0;
    bool sigint_unblocked = sigismember(&currmask, SIGINT) <= 0;
    bool sigtstp_unblocked = sigismember(&currmask, SIGTSTP) <= 0;

    if (sigchld_unblocked || sigint_unblocked || sigtstp_unblocked) {
        sio_eprintf("WARNING: signals not blocked before accessing job list:"
                    "%s%s%s\n",
                    sigchld_unblocked ? " SIGCHLD" : "",
                    sigint_unblocked ? " SIGINT" : "",
                    sigtstp_unblocked ? " SIGTSTP" : "");
    }
}

/*
 * get_job - Gets a reference to the job struct corresponding to a job ID. The
 * job struct may not necessarily be valid. Async-signal-safe
 */
static struct job_t *get_job(jid_t jid) {
    if (jid < 1 || jid > MAXJOBS) {
        sio_eprintf("get_job: invalid jid\n");
        abort();
    }
    return &job_list[jid - 1];
}

/*
 * clearjob - Clear the entries in a job struct
 * Async-signal-safe
 */
static void clearjob(struct job_t *job) {
    sio_assert(job != NULL);
    job->pid = 0;
    job->jid = 0;
    job->state = UNDEF;
}

/*
 * init_job_list - Initialize the job list
 * Not async-signal-safe
 */
void init_job_list(void) {
    init = true;
    for (jid_t jid = 1; jid <= MAXJOBS; jid++) {
        struct job_t *job = get_job(jid);
        clearjob(job);
        job->cmdline = NULL;
    }
    nextjid = 1;
}

/*
 * destroy_job_list - Destroy the job list, freeing any allocated memory
 * Not async-signal-safe (free)
 */
void destroy_job_list(void) {
    for (jid_t jid = 1; jid <= MAXJOBS; jid++) {
        struct job_t *job = get_job(jid);
        clearjob(job);
        free(job->cmdline);
        job->cmdline = NULL;
    }
    nextjid = 1;
}

/*
 * maxjid - Returns largest allocated job ID
 * Async-signal-safe
 */
static jid_t maxjid(void) {
    for (jid_t jid = MAXJOBS; jid >= 1; jid--) {
        if (job_exists(jid)) {
            return jid;
        }
    }
    return 0;
}

/*
 * job_exists - Returns whether a job with a given jid exists
 * Async-signal-safe
 */
bool job_exists(jid_t jid) {
    check_blocked();

    if (jid < 1 || jid > MAXJOBS) {
        return false;
    }
    struct job_t *job = get_job(jid);
    return job->state != UNDEF;
}

static void require_job_exists(const char *func, jid_t jid) {
    if (!job_exists(jid)) {
        sio_eprintf("FATAL: %s: invalid JID argument %d\n", func, jid);
        sio_eprintf("This means you have a bug in your code, and you need to "
                    "fix it.\n");
        abort();
    }
}

static void require_valid_state(const char *func, jid_t jid, job_state state) {
    if (state != FG && state != BG && state != ST) {
        sio_eprintf("FATAL: job_set_state: invalid job state: %d\n", state);
        sio_eprintf("This means you have a bug in your code, and you need to "
                    "fix it.\n");
        abort();
    }
    if (state == FG && fg_job() != 0) {
        sio_eprintf("FATAL: job_set_state: cannot make %d the foreground job "
                    "when another job %d is also the foreground job",
                    jid, fg_job());
        sio_eprintf("This means you have a bug in your code, and you need to "
                    "fix it.\n");
        abort();
    }
}

/*
 * add_job - Add a job to the job list
 * Not async-signal-safe (realloc)
 */
jid_t add_job(pid_t pid, job_state state, const char *cmdline) {
    check_blocked();
    if (!((state == FG && fg_job() == 0) || state == BG || state == ST)) {
        if (state == FG) {
            sio_eprintf("add_job: foreground job already exists\n");
            abort();
        }
        sio_eprintf("add_job: invalid job state\n");
        abort();
    }
    if (pid <= 0) {
        sio_eprintf("add_job: invalid pid\n");
        abort();
    }
    if (cmdline == NULL) {
        sio_eprintf("add_job: missing command line\n");
        abort();
    }

    /* Ensure nextjid is available in job list */
    sio_assert(nextjid > 0);
    if (nextjid > MAXJOBS) {
        if (verbose) {
            fprintf(stderr, "add_job: Tried to create too many jobs\n");
        }
        return 0;
    }

    struct job_t *job = get_job(nextjid);
    sio_assert(job->state == UNDEF);

    job->jid = nextjid;
    job->pid = pid;
    job->state = state;

    /* Realloc new buffer for cmdline */
    job->cmdline = realloc(job->cmdline, strlen(cmdline) + 1);
    if (job->cmdline == NULL) {
        sio_eprintf("Realloc error\n");
        _exit(1);
    }
    strcpy(job->cmdline, cmdline);

    if (verbose) {
        fprintf(stderr, "add_job: Added job [%d] %d %s\n", (int)job->jid,
                (int)job->pid, job->cmdline);
    }

    nextjid++;
    sio_assert(nextjid > 0);
    return job->jid;
}

/*
 * delete_job - Delete a job by jid from the job list. Does not free memory
 * used by the cmdline buffer in the job struct, in order to ensure that
 * this function is async-signal-safe.
 * Async-signal-safe
 */
bool delete_job(jid_t jid) {
    check_blocked();

    if (!job_exists(jid)) {
        if (verbose) {
            sio_eprintf("delete_job: Invalid jid: %d\n", (int)jid);
        }
        return false;
    }

    struct job_t *job = get_job(jid);
    clearjob(job);

    nextjid = maxjid() + 1;
    sio_assert(nextjid > 0);
    return true;
}

/*
 * fg_job - Return JID of current foreground job, or 0 if no such job
 * Async-signal-safe
 */
jid_t fg_job(void) {
    check_blocked();

    for (jid_t jid = 1; jid <= MAXJOBS; jid++) {
        struct job_t *jobp = get_job(jid);
        if (jobp->state == FG) {
            return jid;
        }
    }

    if (verbose) {
        sio_eprintf("fg_job: No foreground job found\n");
    }
    return 0;
}

/*
 * job_from_pid - Find a job (by PID) on the job list
 * Async-signal-safe
 */
jid_t job_from_pid(pid_t pid) {
    check_blocked();

    if (pid < 1) {
        if (verbose) {
            sio_eprintf("job_from_pid: Invalid pid: %d\n", (int)pid);
        }
        return 0;
    }

    for (jid_t jid = 1; jid <= MAXJOBS; jid++) {
        struct job_t *jobp = get_job(jid);
        if (jobp->state != UNDEF && jobp->pid == pid) {
            return jid;
        }
    }

    if (verbose) {
        sio_eprintf("job_from_pid: Invalid pid: %d\n", (int)pid);
    }
    return 0;
}

/*
 * job_get_state - Gets the state of a job, given a job ID
 * Async-signal-safe
 */
job_state job_get_state(jid_t jid) {
    check_blocked();
    require_job_exists("job_get_state", jid);

    struct job_t *jobp = get_job(jid);
    return jobp->state;
}

/*
 * job_set_state - Sets the state of a job
 * Async-signal-safe
 */
void job_set_state(jid_t jid, job_state state) {
    check_blocked();
    require_job_exists("job_set_state", jid);
    require_valid_state("job_set_state", jid, state);

    struct job_t *jobp = get_job(jid);
    jobp->state = state;
}

/*
 * job_get_pid - Gets the process ID of a job
 * Async-signal-safe
 */
pid_t job_get_pid(jid_t jid) {
    check_blocked();
    require_job_exists("job_get_pid", jid);

    struct job_t *jobp = get_job(jid);
    return jobp->pid;
}

/*
 * job_get_cmdline - Gets the cmdline of a job
 * Async-signal-safe
 */
const char *job_get_cmdline(jid_t jid) {
    check_blocked();
    require_job_exists("job_get_cmdline", jid);

    struct job_t *jobp = get_job(jid);
    return jobp->cmdline;
}

/*
 * list_jobs - Print the job list to a file descriptor
 * Async-signal-safe
 */
bool list_jobs(int output_fd) {
    check_blocked();
    if (output_fd < 0) {
        sio_eprintf("list_jobs: invalid file descriptor\n");
        abort();
    }

    for (jid_t jid = 1; jid <= MAXJOBS; jid++) {
        struct job_t *jobp = get_job(jid);
        if (jobp->state == UNDEF) {
            continue;
        }

        const char *status = NULL;
        switch (jobp->state) {
        case BG:
            status = "Running    ";
            break;
        case FG:
            status = "Foreground ";
            break;
        case ST:
            status = "Stopped    ";
            break;
        default:
            sio_eprintf("Invalid job state\n");
            abort();
        }

        ssize_t res = sio_dprintf(output_fd, "[%d] (%d) %s%s\n", jobp->jid,
                                  jobp->pid, status, jobp->cmdline);
        if (res < 0) {
            sio_eprintf("list_jobs: Error writing to output_fd: %d\n",
                        output_fd);
            return false;
        }
    }

    return true;
}
/******************************
 * end job list helper routines
 ******************************/

/***********************
 * Other helper routines
 ***********************/

/*
 * usage - Print the usage of the tiny shell
 * Not async-signal-safe
 */
void usage(void) {
    printf("Usage: shell [-hvp]\n");
    printf("   -h   print this message\n");
    printf("   -v   print additional diagnostic information\n");
    printf("   -p   do not emit a command prompt\n");
    exit(EXIT_FAILURE);
}
