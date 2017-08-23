#include "kernel.h"
#include "stdio.h"
#include "devices/uart.h"

static UART* s_KernelConsoleUART = 0;
static const char* s_KernelPanicMsg = 0;

static void _kprintf_putc(void* userData, char c)
{
	if(userData != 0) {
		uartSend((UART*)userData, &c, 1);
	}
}

void kpanic(const char* msg)
{
	s_KernelPanicMsg = msg; // Just in case console hasn't been initialized yet.
	kputs(msg);
	while(1);
}

void kinit(UART* consoleUART)
{
	s_KernelConsoleUART = consoleUART;
	kprintfInit(s_KernelConsoleUART, _kprintf_putc);
}
