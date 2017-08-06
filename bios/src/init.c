#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "syscall.h"
#include "uart.h"

#define CONSOLE_UART_BASE_ADDRESS      0x80000000

#define MCAUSE_INSTR_ADDR_MISALIGNED   0
#define MCAUSE_INSTR_ADDR_ACCESS_FAULT 1
#define MCAUSE_ILLEGAL_INSTR           2
#define MCAUSE_BREAKPOINT              3
#define MCAUSE_LOAD_ADDR_MISALIGNED    4
#define MCAUSE_LOAD_ACCESS_FAULT       5
#define MCAUSE_STORE_ADDR_MISALIGNED   6
#define MCAUSE_STORE_ACCESS_FAULT      7
#define MCAUSE_ENV_CALL_FROM_U         8
#define MCAUSE_ENV_CALL_FROM_S         9
#define MCAUSE_ENV_CALL_FROM_M         11
#define MCAUSE_INSTR_PAGE_FAULT        12
#define MCAUSE_LOAD_PAGE_FAULT         13
#define MCAUSE_STORE_PAGE_FAULT        15

void unhandled_trap(uintptr_t mcause)
{
    const char* message = "\nUnhandled trap: ";

    write(STDERR_FILENO, message, strlen(message));
    write_hex(STDERR_FILENO, mcause);
    while (1);
}

void illegalInstrTrap(uintptr_t addr)
{
    const char* message = "\nIllegal instruction at address ";
    write(STDERR_FILENO, message, strlen(message));
    write_hex(STDERR_FILENO, addr);
    while(1);
}

uintptr_t handle_trap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
    switch(mcause)
    {
    case MCAUSE_ILLEGAL_INSTR:
        illegalInstrTrap(epc);
        break;
    case MCAUSE_BREAKPOINT:
        epc += 4; // nop
        break;
    case MCAUSE_ENV_CALL_FROM_U:
    case MCAUSE_ENV_CALL_FROM_M:
        // TODO: Q: Is there a reason to distinguish the 2? 
        // For now, assume both should be handled the same way.
        regs[10] = syscallHandler(regs[17], &regs[10]);
        epc += 4;
        break;
    case MCAUSE_INSTR_ADDR_MISALIGNED:
    case MCAUSE_INSTR_ADDR_ACCESS_FAULT:
    case MCAUSE_LOAD_ADDR_MISALIGNED:
    case MCAUSE_LOAD_ACCESS_FAULT:
    case MCAUSE_STORE_ADDR_MISALIGNED:
    case MCAUSE_STORE_ACCESS_FAULT:
    case MCAUSE_ENV_CALL_FROM_S:
    case MCAUSE_INSTR_PAGE_FAULT:
    case MCAUSE_LOAD_PAGE_FAULT:
    case MCAUSE_STORE_PAGE_FAULT:
    default:
        unhandled_trap(mcause);
        break;
    }

    return epc;
}

void _init(void)
{
    extern UART g_ConsoleUART;
    uartInit(&g_ConsoleUART, CONSOLE_UART_BASE_ADDRESS);

    extern int main();
    exit(main());
}
