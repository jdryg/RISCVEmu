#ifndef RISCV_MATH_H
#define RISCV_MATH_H

#include <stdint.h>

#define EXTRACT_BITS(word, startBit, numBits) ((word >> startBit) & ((1 << numBits) - 1))

inline bool isPowerOfTwo(uint32_t x)
{
	return (x & (x - 1)) == 0;
}

inline uint32_t log2ui_pow2(uint32_t v)
{
	static const uint32_t b[] = { 0xAAAAAAAA, 0xCCCCCCCC, 0xF0F0F0F0, 0xFF00FF00, 0xFFFF0000 };

	uint32_t r = (v & b[0]) != 0;
	for (uint32_t i = 4; i > 0; i--) {
		r |= ((v & b[i]) != 0) << i;
	}

	return r;
}

#endif