#include "cpu.h"
#include <bx/string.h>

namespace riscv
{
static const char* s_RegABIName[32] = {
	"zero",
	"ra", "sp", "gp", "tp", "t0", "t1", "t2", "s0",
	"s1", "a0", "a1", "a2", "a3", "a4", "a5", "a6",
	"a7", "s2", "s3", "s4", "s5", "s6", "s7", "s8",
	"s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

void disasmInstruction(uint32_t ir, uint32_t addr, char* buf, uint32_t len)
{
	*buf = '\0';

	// DEBUG
	bx::snprintf(buf, len, "---");

	Instruction instr;
	instr.m_Word = ir;

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	if ((opcode & 3) != 3) {
		bx::snprintf(buf, len, "Invalid instruction (opcode[0:1] = %u)", opcode & 3);
		return;
	}
	
	switch (opcode) {
	case Opcode::Load:
		switch (instr.I.funct3) {
		case 0: // LB
			bx::snprintf(buf, len, "lb %s, [%s + %03Xh]", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 1: // LH
			bx::snprintf(buf, len, "lh %s, [%s + %03Xh]", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 2: // LW
			bx::snprintf(buf, len, "lw %s, [%s + %03Xh]", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 4: // LBU
			bx::snprintf(buf, len, "lbu %s, [%s + %03Xh]", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 5: // LHU
			bx::snprintf(buf, len, "lhu %s, [%s + %03Xh]", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		default:
			bx::snprintf(buf, len, "Invalid LOAD instruction width (%u)", instr.I.funct3);
			break;
		}
		break;
	case Opcode::MiscMem:
		bx::snprintf(buf, len, "MISC-MEM opcode not implemented yet.");
		break;
	case Opcode::OpImm:
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			if (instr.I.rs1 == 0) {
				bx::snprintf(buf, len, "li %s, %03Xh", s_RegABIName[instr.I.rd], immI(instr));
			} else if (instr.I.imm == 0) {
				bx::snprintf(buf, len, "mv %s, %s", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1]);
			} else {
				bx::snprintf(buf, len, "addi %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			}
			break;
		case ALUOp::ShiftLeft:
			bx::snprintf(buf, len, "slli %s, %s, %02Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			break;
		case ALUOp::SLT:
			bx::snprintf(buf, len, "slti %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::SLTU:
			bx::snprintf(buf, len, "sltiu %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::Xor:
			bx::snprintf(buf, len, "xori %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::ShiftRight:
			if (instr.I.imm & 0x800) {
				bx::snprintf(buf, len, "srai %s, %s, %02Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			} else {
				bx::snprintf(buf, len, "srli %s, %s, %02Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			}
			break;
		case ALUOp::Or:
			bx::snprintf(buf, len, "ori %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::And:
			bx::snprintf(buf, len, "andi %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		}
		break;
	case Opcode::AUIPC:
		bx::snprintf(buf, len, "auipc %s, %05Xh", s_RegABIName[instr.U.rd], instr.U.imm_12_31);
		break;
	case Opcode::Store:
		switch (instr.S.funct3) {
		case 0: // SB
			bx::snprintf(buf, len, "sb [%s + %03Xh], %s", s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		case 1: // SH
			bx::snprintf(buf, len, "sh [%s + %03Xh], %s", s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		case 2: // SW
			bx::snprintf(buf, len, "sw [%s + %03Xh], %s", s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		default:
			bx::snprintf(buf, len, "Invalid STORE instruction width (%u)", instr.S.funct3);
			break;
		}
		break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			if (instr.R.funct7 != 0) {
				bx::snprintf(buf, len, "sub %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			} else {
				bx::snprintf(buf, len, "add %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			}
			break;
		case ALUOp::ShiftLeft:
			bx::snprintf(buf, len, "sll %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::SLT:
			bx::snprintf(buf, len, "slt %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::SLTU:
			bx::snprintf(buf, len, "sltu %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::Xor:
			bx::snprintf(buf, len, "xor %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::ShiftRight:
			if (instr.R.funct7 != 0) {
				bx::snprintf(buf, len, "sra %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			} else {
				bx::snprintf(buf, len, "srl %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			}
			break;
		case ALUOp::Or:
			bx::snprintf(buf, len, "or %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::And:
			bx::snprintf(buf, len, "and %s, %s, %s", s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		}
		break;
	case Opcode::LUI:
		bx::snprintf(buf, len, "lui %s, %05Xh", s_RegABIName[instr.U.rd], instr.U.imm_12_31);
		break;
	case Opcode::Branch:
	{
		switch (instr.B.funct3) {
		case BranchOp::Equal:
			bx::snprintf(buf, len, "beq %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::NotEqual:
			bx::snprintf(buf, len, "bne %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::LessThan:
			bx::snprintf(buf, len, "blt %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::GreaterEqual:
			bx::snprintf(buf, len, "bge %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::LessThanUnsigned:
			bx::snprintf(buf, len, "bltu %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::GreaterEqualUnsigned:
			bx::snprintf(buf, len, "bgeu %s, %s, %05Xh", s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		default:
			bx::snprintf(buf, len, "Invalid BRANCH code (%u)", instr.B.funct3);
			break;
		}
	}
	break;
	case Opcode::JALR:
		if (instr.I.rd == 0 && instr.I.rs1 == 1 && instr.I.imm == 0) {
			bx::snprintf(buf, len, "ret", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
		} else if (instr.I.rd == 0 && instr.I.imm == 0) {
			bx::snprintf(buf, len, "jr %s", s_RegABIName[instr.I.rs1]);
		} else {
			bx::snprintf(buf, len, "jalr %s, %s, %03Xh", s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
		}
		break;
	case Opcode::JAL:
		if (instr.J.rd == 0) {
			const uint32_t absAddr = addr + immJ(instr);
			if (absAddr != addr) {
				bx::snprintf(buf, len, "j %08Xh", absAddr);
			} else {
				bx::snprintf(buf, len, "hlt");
			}
		} else if (instr.J.rd == 1) {
			bx::snprintf(buf, len, "call %08Xh", addr + immJ(instr));
		} else {
			bx::snprintf(buf, len, "jal %s, %08Xh", s_RegABIName[instr.J.rd], immJ(instr));
		}
		break;
	case Opcode::System:
		switch (instr.I.imm) {
		case 0: // ECALL
			bx::snprintf(buf, len, "ecall");
			break;
		case 1: // EBREAK
			bx::snprintf(buf, len, "ebreak");
			break;
		default:
			bx::snprintf(buf, len, "Invalid SYSTEM instruction");
			break;
		}
		break;
	default:
//		RISCV_CHECK(false, "Invalid opcode %02Xh", opcode);
		break;
	}
}
}
