#include "alu.h"
#include "../debug.h"

namespace riscv
{
uint32_t alu(uint32_t a, uint32_t b, ALUFunction::Enum func, bool secondaryFunc)
{
	uint32_t res = 0;
	switch (func) {
	case ALUFunction::Add_Sub:
		res = secondaryFunc ? (a - b) : (a + b);
		break;
	case ALUFunction::SLL:
		res = a << b;
		break;
	case ALUFunction::SLT:
		res = ((int32_t)a < (int32_t)b) ? 1 : 0;
		break;
	case ALUFunction::SLTU:
		res = (a < b) ? 1 : 0;
		break;
	case ALUFunction::Xor:
		res = a ^ b;
		break;
	case ALUFunction::SRL_SRA:
		res = secondaryFunc ? (((int32_t)a) >> b) : (a >> b);
		break;
	case ALUFunction::Or:
		res = a | b;
		break;
	case ALUFunction::And:
		res = a & b;
		break;
	}

	return res;
}
}
