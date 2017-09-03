#ifndef RISCV_ALU_H
#define RISCV_ALU_H

#include <stdint.h>

namespace riscv
{
struct ALUOperation
{
	enum Enum : uint32_t
	{
		Add = 0,
		Sub = 1,
		SLL = 2,
		SRL = 3,
		SRA = 4,
		Xor = 5,
		Or = 6,
		And = 7,
		SLT = 8,
		SLTU = 9,
		SEQ = 10,
	};
};

struct ALUInput
{
	uint32_t m_A;
	uint32_t m_B;
	ALUOperation::Enum m_Op;
};

struct ALUOutput
{
	uint32_t m_Res;
};

void alu(const ALUInput& input, ALUOutput& output);
uint32_t alu(uint32_t a, uint32_t b, ALUOperation::Enum op);
}

#endif
