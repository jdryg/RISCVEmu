#include "alu.h"
#include "../debug.h"

namespace riscv
{
void alu(const ALUInput& input, ALUOutput& output)
{
	output.m_Res = alu(input.m_A, input.m_B, input.m_Op);
}

uint32_t alu(uint32_t a, uint32_t b, ALUOperation::Enum op)
{
	uint32_t res = 0;
	switch (op) {
	case ALUOperation::Add:
		res = a + b;
		break;
	case ALUOperation::Sub:
		res = a - b;
		break;
	case ALUOperation::SLL:
		res = a << b;
		break;
	case ALUOperation::SRL:
		res = a >> b;
		break;
	case ALUOperation::SRA:
		res = ((int32_t)a) >> b;
	case ALUOperation::Xor:
		res = a ^ b;
		break;
	case ALUOperation::Or:
		res = a | b;
		break;
	case ALUOperation::And:
		res = a & b;
		break;
	case ALUOperation::SLT:
		res = ((int32_t)a < (int32_t)b) ? 1 : 0;
		break;
	case ALUOperation::SLTU:
		res = (a < b) ? 1 : 0;
		break;
	case ALUOperation::SEQ:
		res = (a == b) ? 1 : 0;
		break;
	}

	return res;
}
}
