#include "kernel.h"
#include "string.h" // kstrlen()
#include "../devices/uart.h"

#define CONSOLE_UART_BASE_ADDRESS      0x80000000

#define CONSOLE_COMMAND             0xFF
#define CONSOLE_CMD_DEL_PREV        0
#define CONSOLE_CMD_RAW_OUTPUT      1

UART g_KernelConsoleUART;
static const char* s_KernelPanicMsg = 0;

int kputchar(int character)
{
	uint8_t c = (uint8_t)character;
	uartSend(&g_KernelConsoleUART, &c, 1);
}

int kgetchar()
{
	uint8_t c;
	while(!uartRead(&g_KernelConsoleUART, &c, 1));
	return (int)c;
}

int kputs(const char* str)
{
	const uint8_t lf = '\n';

	size_t len = kstrlen(str);
	uartSend(&g_KernelConsoleUART, (const uint8_t*)str, len + 1);
	uartSend(&g_KernelConsoleUART, &lf, 1);
}

void kconsoleDelPrevChars(uint32_t n)
{
	kassert(n < 256, "Console: Max amount of chars to delete is 255");

	uint8_t consoleCmd[3] = {
		CONSOLE_COMMAND,
		CONSOLE_CMD_DEL_PREV,
		(uint8_t)n
	};
	uartSend(&g_KernelConsoleUART, &consoleCmd[0], 3);
}

void kconsoleRawOutput(const uint8_t* buf, uint32_t len)
{
	kassert(len < 65536, "Console: Raw output max buffer size is 65535");

	char cmd[4];
	cmd[0] = CONSOLE_COMMAND;
	cmd[1] = CONSOLE_CMD_RAW_OUTPUT;
	cmd[2] = (uint8_t)(len & 0x000000FF);
	cmd[3] = (uint8_t)((len >> 8) & 0x000000FF);
	uartSend(&g_KernelConsoleUART, &cmd[0], 4);
	uartSend(&g_KernelConsoleUART, buf, len);
}

void kpanic(const char* msg)
{
	s_KernelPanicMsg = msg; // Just in case console hasn't been initialized yet.
	kputs(msg);
	while(1);
}

void kinit()
{
	uartInit(&g_KernelConsoleUART, CONSOLE_UART_BASE_ADDRESS);
}
