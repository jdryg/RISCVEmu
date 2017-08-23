#include "exception_handler.h"
#include "syscall.h"
#include "libkernel/stdio.h"
#include "libkernel/kernel.h"

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
	char msg[256];
	ksprintf(msg, "\nUnhandled trap 0x%02X at address 0x%08X\n", mcause, epc);
	kpanic(msg);

	// Unreachable code
	return epc;
}

uintptr_t illegalInstrTrap(uintptr_t mcause, uintptr_t epc, uintptr_t* regs)
{
	char msg[256];
	ksprintf(msg, "\nIllegal instruction at address 0x%08X\n", epc);
	kpanic(msg);

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
