#include "string.h"

// http://clc-wiki.net/wiki/strcmp
int kstrcmp(const char* str1, const char* str2)
{
	while(*str1 && (*str1 == *str2)) {
		str1++;
		str2++;
	}

	return *(const unsigned char*)str1 - *(const unsigned char*)str2;
}

// http://clc-wiki.net/wiki/strncmp
int kstrncmp(const char* str1, const char* str2, size_t num)
{
	while(num--) {
		if(*str1++ != *str2++) {
			return *(unsigned char*)(str1 - 1) - *(unsigned char*)(str2 - 1);
		}
	}

	return 0;
}

// http://clc-wiki.net/wiki/strchr
const char* kstrchr(const char* str, int character)
{
	while(*str != (char)character) {
		if (!*str++) {
			return 0;
		}
	}

	return (char*)str;
}

// http://clc-wiki.net/wiki/strlen
size_t kstrlen(const char* str)
{
	const char* p = str;
	while(*str) {
		++str;
	}

	return str - p;
}
