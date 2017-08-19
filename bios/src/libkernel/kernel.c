#include "kernel.h"
#include "uart.h"
#include "printf.h"

static UART* s_KernelConsoleUART = 0;
static const char* s_KernelPanicMsg = 0;

static void _kprintf_putc(void* userData, char c)
{
    if(userData != 0) {
        const char arr[2] = {c, '\r'};
        uartSend((UART*)userData, &arr[0], c == '\n' ? 2 : 1);
    }
}

void kpanic(const char* msg)
{
    s_KernelPanicMsg = msg; // Just in case console hasn't been initialized yet.
    kprintf(msg);
    while(1);
}

void kinit(UART* consoleUART)
{
    s_KernelConsoleUART = consoleUART;
    kprintfInit(s_KernelConsoleUART, _kprintf_putc);
}
