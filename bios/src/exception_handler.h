#ifndef EXCEPTION_HANDLER_H
#define EXCEPTION_HANDLER_H

#include <stdint.h>

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

#define MCAUSE_MAX_TRAPS               16

typedef uintptr_t (*TrapHandler)(uintptr_t mcause, uintptr_t epc, uintptr_t* regs);

uintptr_t trapHandler(uintptr_t mcause, uintptr_t epc, uintptr_t* regs);

TrapHandler setTrapHandler(uintptr_t mcause, TrapHandler newHandler);

#endif
