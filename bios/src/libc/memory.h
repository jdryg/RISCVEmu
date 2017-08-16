#ifndef LIBC_MEMORY_H
#define LIBC_MEMORY_H

#include <stddef.h>

void* memcpy(void* dest, const void* src, size_t n);
void* memset(void* s, int c, size_t n);

#endif
