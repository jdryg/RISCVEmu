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
	bx::snprintf(buf, len, "%08X: %08X\t---", addr, ir);

	Instruction instr;
	instr.m_Word = ir;

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	if ((opcode & 3) != 3) {
		bx::snprintf(buf, len, "%08X: %08X\tInvalid instruction (opcode[0:1] = %u)", addr, ir, opcode & 3);
		return;
	}
	
	switch (opcode) {
	case Opcode::Load:
		switch (instr.I.funct3) {
		case 0: // LB
			bx::snprintf(buf, len, "%08X: %08X\tlb %s, [%s + %03Xh]", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 1: // LH
			bx::snprintf(buf, len, "%08X: %08X\tlh %s, [%s + %03Xh]", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 2: // LW
			bx::snprintf(buf, len, "%08X: %08X\tlw %s, [%s + %03Xh]", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 4: // LBU
			bx::snprintf(buf, len, "%08X: %08X\tlbu %s, [%s + %03Xh]", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case 5: // LHU
			bx::snprintf(buf, len, "%08X: %08X\tlhu %s, [%s + %03Xh]", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		default:
			bx::snprintf(buf, len, "%08X: %08X\tInvalid LOAD instruction width (%u)", addr, instr, instr.I.funct3);
			break;
		}
		break;
	case Opcode::MiscMem:
		bx::snprintf(buf, len, "%08X: %08X\tMISC-MEM opcode not implemented yet.", addr, instr);
		break;
	case Opcode::OpImm:
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			bx::snprintf(buf, len, "%08X: %08X\taddi %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::ShiftLeft:
			bx::snprintf(buf, len, "%08X: %08X\tslli %s, %s, %02Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			break;
		case ALUOp::SLT:
			bx::snprintf(buf, len, "%08X: %08X\tslti %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::SLTU:
			bx::snprintf(buf, len, "%08X: %08X\tsltiu %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::Xor:
			bx::snprintf(buf, len, "%08X: %08X\txori %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::ShiftRight:
			if (instr.I.imm & 0x800) {
				bx::snprintf(buf, len, "%08X: %08X\tsrai %s, %s, %02Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			} else {
				bx::snprintf(buf, len, "%08X: %08X\tsrli %s, %s, %02Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], instr.I.imm & 0x1F);
			}
			break;
		case ALUOp::Or:
			bx::snprintf(buf, len, "%08X: %08X\tori %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		case ALUOp::And:
			bx::snprintf(buf, len, "%08X: %08X\tandi %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
			break;
		}
		break;
	case Opcode::AUIPC:
		bx::snprintf(buf, len, "%08X: %08X\tauipc %s, %05Xh", addr, instr, s_RegABIName[instr.U.rd], immU(instr));
		break;
	case Opcode::Store:
		switch (instr.S.funct3) {
		case 0: // SB
			bx::snprintf(buf, len, "%08X: %08X\tsb [%s + %03Xh], %s", addr, instr, s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		case 1: // SH
			bx::snprintf(buf, len, "%08X: %08X\tsh [%s + %03Xh], %s", addr, instr, s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		case 2: // SW
			bx::snprintf(buf, len, "%08X: %08X\tsw [%s + %03Xh], %s", addr, instr, s_RegABIName[instr.S.rs1], immS(instr), s_RegABIName[instr.S.rs2]);
			break;
		default:
			bx::snprintf(buf, len, "%08X: %08X\tInvalid STORE instruction width (%u)", addr, instr, instr.S.funct3);
			break;
		}
		break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			if (instr.R.funct7 != 0) {
				bx::snprintf(buf, len, "%08X: %08X\tsub %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			} else {
				bx::snprintf(buf, len, "%08X: %08X\tadd %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			}
			break;
		case ALUOp::ShiftLeft:
			bx::snprintf(buf, len, "%08X: %08X\tsll %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::SLT:
			bx::snprintf(buf, len, "%08X: %08X\tslt %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::SLTU:
			bx::snprintf(buf, len, "%08X: %08X\tsltu %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::Xor:
			bx::snprintf(buf, len, "%08X: %08X\txor %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::ShiftRight:
			if (instr.R.funct7 != 0) {
				bx::snprintf(buf, len, "%08X: %08X\tsra %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			} else {
				bx::snprintf(buf, len, "%08X: %08X\tsrl %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			}
			break;
		case ALUOp::Or:
			bx::snprintf(buf, len, "%08X: %08X\tor %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		case ALUOp::And:
			bx::snprintf(buf, len, "%08X: %08X\tand %s, %s, %s", addr, instr, s_RegABIName[instr.R.rd], s_RegABIName[instr.R.rs1], s_RegABIName[instr.R.rs2]);
			break;
		}
		break;
	case Opcode::LUI:
		bx::snprintf(buf, len, "%08X: %08X\tlui %s, %05Xh", addr, instr, s_RegABIName[instr.U.rd], immU(instr));
		break;
	case Opcode::Branch:
	{
		switch (instr.B.funct3) {
		case BranchOp::Equal:
			bx::snprintf(buf, len, "%08X: %08X\tbeq %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::NotEqual:
			bx::snprintf(buf, len, "%08X: %08X\tbne %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::LessThan:
			bx::snprintf(buf, len, "%08X: %08X\tblt %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::GreaterEqual:
			bx::snprintf(buf, len, "%08X: %08X\tbge %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::LessThanUnsigned:
			bx::snprintf(buf, len, "%08X: %08X\tbltu %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		case BranchOp::GreaterEqualUnsigned:
			bx::snprintf(buf, len, "%08X: %08X\tbgeu %s, %s, %05Xh", addr, instr, s_RegABIName[instr.B.rs1], s_RegABIName[instr.B.rs2], immB(instr));
			break;
		default:
			bx::snprintf(buf, len, "%08X: %08X\tInvalid BRANCH code (%u)", addr, instr, instr.B.funct3);
			break;
		}
	}
	break;
	case Opcode::JALR:
		bx::snprintf(buf, len, "%08X: %08X\tjalr %s, %s, %03Xh", addr, instr, s_RegABIName[instr.I.rd], s_RegABIName[instr.I.rs1], immI(instr));
		break;
	case Opcode::JAL:
		bx::snprintf(buf, len, "%08X: %08X\tjal %s, %08Xh", addr, instr, s_RegABIName[instr.J.rd], immJ(instr));
		break;
	case Opcode::System:
		switch (instr.I.imm) {
		case 0: // ECALL
			bx::snprintf(buf, len, "%08X: %08X\tecall", addr, instr);
			break;
		case 1: // EBREAK
			bx::snprintf(buf, len, "%08X: %08X\tebreak", addr, instr);
			break;
		default:
			bx::snprintf(buf, len, "%08X: %08X\tInvalid SYSTEM instruction", addr, instr);
			break;
		}
		break;
	default:
//		RISCV_CHECK(false, "Invalid opcode %02Xh", opcode);
		break;
	}
}
}
