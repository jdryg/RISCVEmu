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
