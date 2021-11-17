/*
 * myusleep - Shell lab test program
 *
 * Reimplement usleep for portability purposes
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv) {
    if (argc == 2) {
        usleep((useconds_t)atoi(argv[1]));
    }
    return 0;
}
