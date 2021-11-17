/**
 * @file tsh_helper.h
 * @brief Definitions and interfaces for tshlab
 *
 * This file defines enumerations and structs used in tshlab, as well as the
 * interfaces for various helper routines. You should use these routines to
 * help write your tiny shell.
 *
 * Many of the helper routines are focused around maintaining a job list,
 * which you can only access through the routines themselves. Each job is
 * represented by a job ID ranging from 1 to `MAXJOBS`.
 *
 * The signal safety of each helper function is documented in this file. You
 * must ensure that any helper routines that you call within a signal handler
 * are async-signal-safe.
 *
 * A caveat is that the CSAPP functions, some of which are used in tsh_helper,
 * are technically not async-signal-safe due to the use of strerror. However,
 * we ignore this caveat for the sake of simplicity. See the comment in
 * csapp.h for more details.
 */

#ifndef TSH_HELPER_H
#define TSH_HELPER_H

#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>

/* Misc manifest constants */
#define MAXLINE_TSH 1024 /**< Max line size */
#define MAXARGS 128      /**< Max args on a command line */
#define MAXJOBS 64       /**< Max jobs at any point in time */

/** @brief Integer type used for job IDs */
typedef int jid_t;

/**
 * @brief Enum representing a job state
 *
 * Job state transitions and enabling actions:
 *   - FG -> ST  : Ctrl-Z
 *   - ST -> FG  : fg command
 *   - ST -> BG  : bg command
 *   - BG -> FG  : fg command
 *
 * At most 1 job can be in the FG state.
 */
typedef enum job_state {
    UNDEF = 0, ///< Undefined (do not use)
    FG = 1,    ///< Foreground job
    BG = 2,    ///< Background job
    ST = 3,    ///< Stopped job
} job_state;

/**
 * @brief Parseline return value indicating the type of cmdline parsed
 */
typedef enum parseline_return {
    PARSELINE_FG = 4,    ///< Foreground job
    PARSELINE_BG = 5,    ///< Background job
    PARSELINE_EMPTY = 6, ///< Empty cmdline
    PARSELINE_ERROR = 7, ///< Parse error
} parseline_return;

/**
 * @brief Types of builtins that can be executed by the shell
 */
typedef enum builtin_state {
    BUILTIN_NONE = 8,  ///< Not a builtin command
    BUILTIN_QUIT = 9,  ///< `quit` (exit the shell)
    BUILTIN_JOBS = 10, ///< `jobs` (list running jobs)
    BUILTIN_BG = 11,   ///< `bg` (run job in background)
    BUILTIN_FG = 12    ///< `fg` (run job in foreground)
} builtin_state;

/**
 * @brief Result of parsing a command line from parseline
 */
struct cmdline_tokens {
    int argc;               ///< Number of arguments passed
    char *argv[MAXARGS];    ///< The arguments list
    char *infile;           ///< The filename for input redirection, or NULL
    char *outfile;          ///< The filename for output redirection, or NULL
    builtin_state builtin;  ///< Indicates if argv[0] is a builtin command
    char _buf[MAXLINE_TSH]; ///< Internal backing buffer (do not use)
};

/* These variables are externally defined in tsh_helper.c. */
extern const char prompt[]; ///< Command line prompt (do not change)
extern bool verbose;        ///< If true, prints additional output

/**
 * @brief Parses a command line into a tokens struct.
 *
 * From a command line, this extracts the arguments, input/output redirection
 * files, and whether the command line corresponds to a background job. The
 * results are stored in the token argument, including a modified copy of the
 * command line used as a backing buffer for the other fields.
 *
 * Characters enclosed in single or double quotes are treated as a single
 * argument. The maximum number of arguments that will be parsed is `MAXARGS`.
 *
 * Only the first `MAXLINE_TSH - 1` characters of the command line will be
 * parsed. The command line is in the form:
 *
 *     command [arguments...] [< infile] [> oufile] [&]
 *
 * If the function cannot successfully parse the command line, it will return
 * `PARSELINE_ERROR`, and the contents of the token struct may be in an
 * inconsistent state.
 *
 * @param[in]  cmdline  The command line to parse.
 * @param[out] token    Pointer to a cmdline_tokens structure, which will
 *                      be populated with the parsed tokens.
 *
 * @return `PARSELINE_EMPTY`  if the command line is empty
 * @return `PARSELINE_BG`     if the user has requested a BG job
 * @return `PARSELINE_FG`     if the user has requested a FG job
 * @return `PARSELINE_ERROR`  if cmdline is incorrectly formatted
 *
 * @remark Async-signal-safety: Not async-signal-safe.
 */
parseline_return parseline(const char *cmdline, struct cmdline_tokens *token);

/**
 * @brief Initializes the job list.
 *
 * This function must be called before accessing the job list through any
 * of the other functions.
 *
 * @pre The job list has not yet been initialized by previously calling
 *      this function.
 * @pre Any signal handlers that might access the job list must not yet
 *      have been installed.
 *
 * @remark Async-signal-safety: Not async-signal-safe.
 */
void init_job_list(void);

/**
 * @brief Destroys the job list, freeing any allocated memory used in it.
 *
 * @pre The job list must have been previously initialized by calling
 *      `init_job_list` before calling this function.
 * @pre Any signal handlers that might access the job list must be removed,
 *      or have their corresponding signals blocked.
 *
 * @remark Async-signal-safety: Not async-signal-safe.
 */
void destroy_job_list(void);

/**
 * @brief Adds a new job to the job list.
 *
 * This involves creating a new job, allocating a job ID to represent the
 * job, and writing the job to the job list with the given parameters. This
 * allows the job to be tracked by the functions provided in the job list.
 *
 * @param[in] pid: The process ID of the main process of the job.
 * @param[in] state: The initial state of the job (should not be UNDEF).
 * @param[in] cmdline: The command line used to start the job.
 *
 * @return The JID of the added job, if successful
 * @return `0` if the job could not be added. The function may fail to add a
 *         job if there are no more job IDs available (restricted by the
 *         `MAXJOBS` constant).
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `state` must represent a valid job state other than `UNDEF`.
 * @pre If `state` is equal to `FG`, then there must currently be no
 *      other foreground job in the job list.
 *
 * @remark Async-signal-safety: Not async-signal-safe.
 */
jid_t add_job(pid_t pid, job_state state, const char *cmdline);

/**
 * @brief Deletes a job from the job list.
 *
 * This removes the job's data from the job list, and frees the job ID to
 * allow it to be used by another job.
 *
 * The shell should call this function when it becomes aware that the job
 * has ended; it does not stop any processes itself. Future calls that
 * reference this job ID will fail, unless the job ID is recycled.
 *
 * @param[in] jid The job ID of the job to delete.
 *
 * @return true if the job was successfully deleted
 * @return false if the job could not be deleted. The function may fail to
 *         delete a job if no job with the given job ID currently exists in
 *         the job list.
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @remark Async-signal-safety: Async-signal-safe.
 */
bool delete_job(jid_t jid);

/**
 * @brief Finds the current foreground job in the job list.
 *
 * At most one job in the job list may have a foreground state. If there is
 * such a job, its JID will be returned by this function. Otherwise, a JID
 * of 0 will be returned to indicate that no such job exists.
 *
 * @return The job ID of the foreground job, if it exists
 * @return 0 if there is currently no foreground job in the job list.
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @remark Async-signal-safety: Async-signal-safe.
 */
jid_t fg_job(void);

/**
 * @brief Determines whether a job with a given job ID exists in the job list.
 *
 * @param[in] jid The job ID to look up
 * @return true if a job with the given job ID exists
 * @return false if no job with the provided job ID exists
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @remark Async-signal-safety: Async-signal-safe.
 */
bool job_exists(jid_t jid);

/**
 * @brief Finds a job corresponding to a process ID.
 *
 * Each job can be identified by the process ID of the initial (root) process
 * in the job. However, there can be multiple processes in a job, which will
 * not be tracked by the job list.
 *
 * @param[in] pid The process ID to search for
 *
 * @return The job ID that corresponds to the given PID, if it exists
 * @return 0 if no job with the given PID exists
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @remark Async-signal-safety: Async-signal-safe.
 */
jid_t job_from_pid(pid_t pid);

/**
 * @brief Gets the process ID of a job
 *
 * @param[in] jid The job ID to look up
 * @return The PID of the initial process in the job
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `jid` must be a valid job ID
 * @remark Async-signal-safety: Async-signal-safe.
 */
pid_t job_get_pid(jid_t jid);

/**
 * @brief Gets the command line of a job
 *
 * @param[in] jid The job ID to look up
 * @return The command line of the job
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `jid` must be a valid job ID
 * @remark Async-signal-safety: Async-signal-safe.
 */
const char *job_get_cmdline(jid_t jid);

/**
 * @brief Gets the state of a job
 *
 * @param[in] jid The job ID to look up
 * @return The state corresponding to the job
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `jid` must be a valid job ID
 * @remark Async-signal-safety: Async-signal-safe.
 */
job_state job_get_state(jid_t jid);

/**
 * @brief Sets the state of a job
 *
 * @param[in] jid    The job ID to modify
 * @param[in] state  The new state to update the job with
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `jid` must be a valid job ID
 * @pre `state` must represent a valid job state other than `UNDEF`.
 * @pre If `state` is equal to `FG`, then there must currently be no
 *      other foreground job in the job list.
 * @remark Async-signal-safe
 */
void job_set_state(jid_t jid, job_state state);

/**
 * @brief Writes a representation of the job list to a file descriptor.
 *
 * This function writes information about each of the jobs currently in the
 * job list to the provided file descriptor. A good choice for a default
 * file descriptor is `STDOUT_FILENO`.
 *
 * @param[in] output_fd: The file descriptor to write to.
 * @return true if the function succeeded
 * @return false if an error occurred while writing to the file descriptor
 *
 * @pre Any signals that could modify the job list must be blocked.
 * @pre `output_fd` must be a valid file descriptor open for writing.
 * @remark Async-signal-safety: Async-signal-safe.
 */
bool list_jobs(int output_fd);

/**
 * @brief Prints usage instructions for the tiny shell.
 * @remark Async-signal-safety: Not async-signal-safe.
 */
void usage(void);

/**
 * @brief Terminates the shell immediately, printing an error message.
 *
 * This function is to be used as a signal handler for the SIGQUIT signal,
 * and should not be called directly.
 *
 * @param[in] sig The signal being handled (unused)
 *
 * @remark Async-signal-safety: Async-signal-safe.
 */
void sigquit_handler(int sig);

#endif /* TSH_HELPER_H */
