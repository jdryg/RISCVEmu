#ifndef LIBKERNEL_MALLOC_H
#define LIBKERNEL_MALLOC_H

#include <stddef.h> // size_t

void* kmalloc(size_t size);
void kfree(void* ptr);
void* krealloc(void* ptr, size_t size);

#endif
