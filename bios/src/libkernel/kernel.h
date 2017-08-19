#ifndef LIBKERNEL_KERNEL_H
#define LIBKERNEL_KERNEL_H

#include <stdint.h>

typedef struct UART_t UART;

void kinit(UART* consoleUART);

void kpanic(const char* msg);

#define kassert(expr, msg) do { if(!(expr)) { kpanic(msg); } } while(0);

#endif
