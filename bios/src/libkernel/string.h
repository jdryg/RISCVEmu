#ifndef LIBKERNEL_STRING_H
#define LIBKERNEL_STRING_H

#include <stddef.h>

int kstrcmp(const char* str1, const char* str2);
int kstrncmp(const char* str1, const char* str2, size_t num);
const char* kstrchr(const char* str, int character);
size_t kstrlen(const char* str);

#endif
