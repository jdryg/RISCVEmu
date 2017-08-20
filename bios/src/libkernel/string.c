#include "string.h"

int kstrcmp(const char* str1, const char* str2)
{
    while(*str1 != 0 && str2 != 0) {
        int dif = (int)(*str1++) - (int)(*str2++);
        if(dif != 0) {
            return dif;
        }
    }

    return (int)(*str1++) - (int)(*str2++);
}

int kstrncmp(const char* str1, const char* str2, size_t num)
{
    while(num > 0 && *str1 != 0 && *str2 != 0) {
        int dif = (int)(*str1++) - (int)(*str2++);
        if(dif != 0) {
            return dif;
        }

        --num;
    }

    return num != 0 ? (int)(*str1++) - (int)(*str2++) : 0;
}

const char* kstrchr(const char* str, int character)
{
    while(*str != 0) {
        if(*str == (char)character) {
            return str;
        }

        str++;
    }

    return 0;
}

size_t kstrlen(const char* str)
{
    size_t size = 0;
    while(*str++ != 0) {
        ++size;
    }
    return size;
}
