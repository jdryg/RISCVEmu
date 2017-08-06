#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "syscall.h"

void readLine(char* input, uint32_t len)
{
    char* dst = input;
    char c;

    uint32_t numRead = read(STDIN_FILENO, &c, 1);
    while(!numRead || (numRead && c != '\n')) {
        if(numRead && c != 0) {
            *dst++ = c;

            // echo
            write(STDOUT_FILENO, &c, 1);

            if(dst - input == len - 1) {
                break;
            }
        }

        numRead = read(STDIN_FILENO, &c, 1);
    }

    *dst = '\0';
}

int main()
{
    char input[256] = {0};

    const char* msg1 = "What's your name?\n> ";
    const char* msg2 = "\nAnything you want to say?\n> ";
    write(STDOUT_FILENO, msg1, strlen(msg1));

    readLine(input, 256);

    write(STDOUT_FILENO, "\nHello ", 7);
    write(STDOUT_FILENO, input, strlen(input));

    write(STDOUT_FILENO, msg2, strlen(msg2));

    readLine(input, 256);

    write(STDOUT_FILENO, "\nYou said: ", 11);
    write(STDOUT_FILENO, input, strlen(input));

    return 305419896; // 0x12345678
}
