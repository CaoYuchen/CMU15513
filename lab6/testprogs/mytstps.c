/*
 * mytstps.c - Sends a SIGTSTP to itself, terminates when restarted.
 */
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
    if (kill(getpid(), SIGTSTP) < 0) {
        perror("kill");
        exit(1);
    }
    exit(0);
}
