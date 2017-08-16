#include "exception_handler.h"
#include "syscall.h"
#include <string.h>
#include <unistd.h>

uintptr_t unhandledTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs);
uintptr_t illegalInstrTrap(uintptr_t mcaus, uintptr_t epc, uintptr_t* regs);
uintptr_t breakpointTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs);
uintptr_t syscallTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs);

static TrapHandler g_TrapHandlers[MCAUSE_MAX_TRAPS] = {
	unhandledTrap,
	unhandledTrap,
	illegalInstrTrap,
	breakpointTrap,
	unhandledTrap,
	unhandledTrap,
	unhandledTrap,
	unhandledTrap,
	syscallTrap,
	unhandledTrap,
	unhandledTrap,
	syscallTrap,
	unhandledTrap,
	unhandledTrap,
	unhandledTrap,
	unhandledTrap
};

uintptr_t unhandledTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	const char* message = "\nUnhandled trap: ";

	sys_write(STDERR_FILENO, message, strlen(message));
	sys_write_hex(STDERR_FILENO, mcause);
	while (1);

	// Unreachable code
	return epc;
}

uintptr_t illegalInstrTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	const char* message = "\nIllegal instruction at address ";
	sys_write(STDERR_FILENO, message, strlen(message));
	sys_write_hex(STDERR_FILENO, epc);
	while(1);

	// Unreachable code
	return epc;
}

uintptr_t breakpointTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	return epc + 4;
}

uintptr_t syscallTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	regs[10] = syscallHandler(regs[17], &regs[10]);
	return epc + 4;
}

uintptr_t trapHandler(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	return g_TrapHandlers[mcause](mcause, epc, regs);
}

TrapHandler setTrapHandler(uintptr_t mcause, TrapHandler newHandler)
{
	TrapHandler oldHandler = g_TrapHandlers[mcause];
	g_TrapHandlers[mcause] = newHandler;
	return oldHandler;
}
