#include <stdio.h>

int main(int argc, char argv) {

    char c = getc(stdin);
    printf("c=%x\n", c);
    exit(0);
}
