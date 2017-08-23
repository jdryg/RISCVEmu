#ifndef UART_H
#define UART_H

#include <stdint.h>

// Extremely simple UART interface.
#define UART_REG_TXDATA 0
#define UART_REG_RXDATA 1
#define UART_REG_STATUS 2

#define UART_STATUS_TXREADY 0x01
#define UART_STATUS_RXFULL  0x02

typedef struct UART
{
	uint32_t m_BaseAddr;
} UART;

void uartInit(UART* uart, uint32_t baseAddr);
void uartSend(UART* uart, const uint8_t* data, uint32_t len);
uint32_t uartRead(UART* uart, uint8_t* data, uint32_t len);

#endif
