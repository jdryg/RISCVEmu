#include "memory.h"
#include <stdint.h>

void* memcpy(void* dst, const void* src, size_t n)
{
    uint8_t* dst8 = (uint8_t*)dst;
    const uint8_t* src8 = (const uint8_t*)src;

    if(n >= 4) {
        uint32_t* dst32 = (uint32_t*)dst;
        const uint32_t* src32 = (const uint32_t*)src;
        size_t n32 = n >> 2;
        while(n32-- > 0) {
            *dst32++ = *src32++;
        }

        dst8 = (uint8_t*)dst32;
        src8 = (const uint8_t*)src32;
    }

    const size_t rem = n & 3;
    switch(rem) {
    case 3:
        *dst8++ = *src8++;
    case 2:
        *dst8++ = *src8++;
    case 1:
        *dst8 = *src8;
    }

    return dst;
}

void* memset(void* s, int c, size_t n)
{
    uint8_t* dst8 = (uint8_t*)s;
    uint8_t c8 = (uint8_t)c;

    if(n >= 4) {
        uint32_t* dst32 = (uint32_t*)s;
        const uint32_t c32 = 0 
            | ((uint32_t)c8) 
            | ((uint32_t)c8 << 8)
            | ((uint32_t)c8 << 16)
            | ((uint32_t)c8 << 24);

        size_t n32 = n >> 2;
        while(n32-- > 0) {
            *dst32++ = c32;
        }

        dst8 = (uint8_t*)dst32;
    }

    const size_t rem = n & 3;
    switch(rem) {
    case 3:
        *dst8++ = c8;
    case 2:
        *dst8++ = c8;
    case 1:
        *dst8 = c8;
    }

    return s;
}
