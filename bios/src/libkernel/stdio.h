#ifndef LIBKERNEL_STDIO_H
#define LIBKERNEL_STDIO_H

#include <stdarg.h>

// printf.c
void kprintfInit(void* putp, void (*putf)(void*, char));
int kprintf(const char* fmt, ...);
int ksprintf(char* s, const char *fmt, ...);
int kformat(void* putp,void (*putf)(void*, char), const char *fmt, va_list va);
int kputs(const char *str);

#endif
