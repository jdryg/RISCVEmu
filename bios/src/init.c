#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "syscall.h"
#include "exception_handler.h"
#include "uart.h"
#include "ram.h"

#define PAGE_SIZE                      0x00001000

#define RAM_BASE_ADDRESS               0x00100000
#define CONSOLE_UART_BASE_ADDRESS      0x80000000

static RAM g_RAM;

void _init()
{
    extern UART g_ConsoleUART;
    uartInit(&g_ConsoleUART, CONSOLE_UART_BASE_ADDRESS);

    write(STDOUT_FILENO, "RAM: ", 5);
    ramInit(&g_RAM, RAM_BASE_ADDRESS, PAGE_SIZE);
    write_hex(STDOUT_FILENO, g_RAM.m_TotalSize);
    write(STDOUT_FILENO, " bytes\n", 7);

    extern int main();
    exit(main());
}
