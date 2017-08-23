#ifndef LIBKERNEL_STDIO_H
#define LIBKERNEL_STDIO_H

#include <stdarg.h>

// printf.c
int kprintf(const char* fmt, ...);
int ksprintf(char* s, const char *fmt, ...);
int kputs(const char *str);
int kputchar(int character);
int kgetchar();

#endif
