#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "syscall.h"
#include "uart.h"

#define PAGE_SIZE                      0x00001000

#define RAM_BASE_ADDRESS               0x00100000
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

static int g_IsInsideMemTest = 0;

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
    case MCAUSE_LOAD_ACCESS_FAULT:
    case MCAUSE_STORE_ACCESS_FAULT:
        if(g_IsInsideMemTest) {
            epc += 4;
        } else {
            unhandled_trap(mcause);
        }
        break;
    case MCAUSE_INSTR_ADDR_MISALIGNED:
    case MCAUSE_INSTR_ADDR_ACCESS_FAULT:
    case MCAUSE_LOAD_ADDR_MISALIGNED:
    case MCAUSE_STORE_ADDR_MISALIGNED:
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

uint32_t memtest()
{
    g_IsInsideMemTest = 1;

    volatile uint32_t dummy = 0;
    volatile uint32_t newValue = 0;
    volatile uint32_t oldValue = 0;
    
    uint32_t pageAddr = RAM_BASE_ADDRESS;
    uint32_t ramSize = 0;
    while(1) {
        uint32_t endOfPage = pageAddr + PAGE_SIZE - 4;

        volatile uint32_t* ptr = (uint32_t*)endOfPage;
        oldValue = *ptr;
        *ptr = oldValue ^ 0x55555555;
        dummy = oldValue;
        
        // TODO: Flush cache once we have caches

        newValue = *ptr;
        *ptr = oldValue;

        if(newValue != (oldValue ^ 0x55555555)) {
            break;
        }

        newValue = oldValue ^ 0xAAAAAAAA;

        ramSize += PAGE_SIZE;
        pageAddr += PAGE_SIZE;
    }

    g_IsInsideMemTest = 0;

    return ramSize;
}

void _init()
{
    extern UART g_ConsoleUART;
    uartInit(&g_ConsoleUART, CONSOLE_UART_BASE_ADDRESS);

    write(STDOUT_FILENO, "MemTest: ", 9);
    uint32_t ramSize = memtest();
    write_hex(STDOUT_FILENO, ramSize);
    write(STDOUT_FILENO, "\n", 1);

    extern int main();
    exit(main());
}
