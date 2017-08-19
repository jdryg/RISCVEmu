#ifndef LIBKERNEL_MEMORY_H
#define LIBKERNEL_MEMORY_H

#include <stddef.h> // size_t

void* kmemcpy(void* dest, const void* src, size_t n);
void* kmemset(void* s, int c, size_t n);

#endif
