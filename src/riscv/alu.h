#ifndef RISCV_ALU_H
#define RISCV_ALU_H

#include <stdint.h>

namespace riscv
{
struct ALUFunction
{
	enum Enum : uint32_t
	{
		Add_Sub = 0,
		SLL = 1,
		SLT = 2,
		SLTU = 3,
		Xor = 4,
		SRL_SRA = 5,
		Or = 6,
		And = 7
	};
};

uint32_t alu(uint32_t a, uint32_t b, ALUFunction::Enum func, bool secondaryFunc);
}

#endif
