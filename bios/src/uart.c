#include "uart.h"

inline uint8_t uartReadReg(UART* uart, uint32_t reg)
{
    volatile uint8_t* ptr = (uint8_t*)uart->m_BaseAddr + (reg << 2);
    return *ptr;
}

inline void uartWriteReg(UART* uart, uint32_t reg, uint8_t val)
{
    volatile uint8_t* ptr = (uint8_t*)uart->m_BaseAddr + (reg << 2);
    *ptr = val;
}

void uartInit(UART* uart, uint32_t baseAddr)
{
    uint8_t status;

    uart->m_BaseAddr = baseAddr;

    // Empty receive buffer.
    status = uartReadReg(uart, UART_REG_STATUS);
    while(status & UART_STATUS_RXFULL) {
        volatile uint8_t rxdata;
        rxdata = uartReadReg(uart, UART_REG_RXDATA);
        status = uartReadReg(uart, UART_REG_STATUS);
    }
}

void uartSend(UART* uart, const uint8_t* data, uint32_t len)
{
    uint32_t i;
    uint8_t status;

    if(len > 0) {
        for (i = 0; i < len; i++) {
            do {
                status = uartReadReg(uart, UART_REG_STATUS);
            } while (!(status & UART_STATUS_TXREADY));

            uartWriteReg(uart, UART_REG_TXDATA, data[i]);
        }
    }
}

uint32_t uartRead(UART* uart, uint8_t* data, uint32_t len)
{
    uint8_t status;
    uint32_t id = 0;

    if(len > 0) {
        status = uartReadReg(uart, UART_REG_STATUS);
        while((status & UART_STATUS_RXFULL) && (id < len)) {
            data[id++] = uartReadReg(uart, UART_REG_RXDATA);

            status = uartReadReg(uart, UART_REG_STATUS);
        }
    }

    return id;
}
