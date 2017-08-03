#include "cpu.h"
#include "../memory.h"
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
		switch (instr.I.funct3) {
		case 0: // ECALL, EBREAK, XRET
			if (instr.I.imm == 0) {
				bx::snprintf(buf, len, "ecall");
			} else if (instr.I.imm == 1) {
				bx::snprintf(buf, len, "ebreak");
			} else {
				if ((instr.I.imm & 0x1F) == 2) {
					const char* xret[] = { "uret", "sret", "hret", "mret" };
					bx::snprintf(buf, len, "%s", xret[(instr.I.imm >> 8) & 0x03]);
				} else {
					bx::snprintf(buf, len, "Invalid SYSTEM instruction");
				}
			}
			break;
		case 1: // CSRRW
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrw %03Xh, %s", instr.I.imm, s_RegABIName[instr.I.rs1]);
			} else {
				bx::snprintf(buf, len, "csrrw %s, %03Xh, %s", s_RegABIName[instr.I.rd], instr.I.imm, s_RegABIName[instr.I.rs1]);
			}
			break;
		case 2: // CSRRS
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrs %03Xh, %s", instr.I.imm, s_RegABIName[instr.I.rs1]);
			} else if (instr.I.rs1 == 0) {
				bx::snprintf(buf, len, "csrr %s, %03Xh", s_RegABIName[instr.I.rd], instr.I.imm);
			} else {
				bx::snprintf(buf, len, "csrrs %s, %03Xh, %s", s_RegABIName[instr.I.rd], instr.I.imm, s_RegABIName[instr.I.rs1]);
			}
			break;
		case 3: // CSRRC
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrc %03Xh, %s", instr.I.imm, s_RegABIName[instr.I.rs1]);
			} else {
				bx::snprintf(buf, len, "csrrc %s, %03Xh, %s", s_RegABIName[instr.I.rd], instr.I.imm, s_RegABIName[instr.I.rs1]);
			}
			break;
		case 5: // CSRRWI
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrwi %03Xh, %03Xh", instr.I.imm, instr.I.rs1);
			} else {
				bx::snprintf(buf, len, "csrrwi %s, %03Xh, %03Xh", s_RegABIName[instr.I.rd], instr.I.imm, instr.I.rs1);
			}
			break;
		case 6: // CSRRSI
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrsi %03Xh, %03Xh", instr.I.imm, instr.I.rs1);
			} else {
				bx::snprintf(buf, len, "csrrsi %s, %03Xh, %03Xh", s_RegABIName[instr.I.rd], instr.I.imm, instr.I.rs1);
			}
			break;
		case 7: // CSRRCI
			if (instr.I.rd == 0) {
				bx::snprintf(buf, len, "csrci %03Xh, %03Xh", instr.I.imm, instr.I.rs1);
			} else {
				bx::snprintf(buf, len, "csrrci %s, %03Xh, %03Xh", s_RegABIName[instr.I.rd], instr.I.imm, instr.I.rs1);
			}
			break;
		default:
			// Invalid instruction
			break;
		}
		break;
	default:
//		RISCV_CHECK(false, "Invalid opcode %02Xh", opcode);
		break;
	}
}

void disasmGetInstrOperandValues(CPU* cpu, Memory* mem, uint32_t ir, uint32_t addr, char* buf, uint32_t len)
{
	*buf = '\0';

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
		case 4: // LBU
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.I.rs1);
			uint32_t memAddr = rs1v + immI(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %02Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], rs1v,
				memAddr, *memVirtualToPhysical(mem, memAddr));
		}
		break;
		case 1: // LH
		case 5: // LHU
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.I.rs1);
			uint32_t memAddr = rs1v + immI(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %04Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], rs1v,
				memAddr, *(uint16_t*)memVirtualToPhysical(mem, memAddr));
		}
		break;
		case 2: // LW
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.I.rs1);
			uint32_t memAddr = rs1v + immI(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %08Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], rs1v,
				memAddr, *(uint32_t*)memVirtualToPhysical(mem, memAddr));
		}
		break;
		default:
			break;
		}
		break;
	case Opcode::MiscMem:
		break;
	case Opcode::OpImm:
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			if (instr.I.rs1 == 0) {
				bx::snprintf(buf, len, "%s = %08Xh", s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd));
			} else {
				bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh", 
					s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
					s_RegABIName[instr.I.rs1], cpuGetRegister(cpu, instr.I.rs1));
			}
			break;
		case ALUOp::ShiftLeft:
		case ALUOp::ShiftRight:
		case ALUOp::Xor:
		case ALUOp::Or:
		case ALUOp::And:
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], cpuGetRegister(cpu, instr.I.rs1));
			break;
		case ALUOp::SLT:
			// Show set/not set
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], cpuGetRegister(cpu, instr.I.rs1));
			break;
		case ALUOp::SLTU:
			// Show set/not set
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], cpuGetRegister(cpu, instr.I.rs1));
			break;
		}
		break;
	case Opcode::AUIPC:
		bx::snprintf(buf, len, "%s = %08Xh\npc = %08Xh",
			s_RegABIName[instr.U.rd], cpuGetRegister(cpu, instr.U.rd),
			addr);
		break;
	case Opcode::Store:
		switch (instr.S.funct3) {
		case 0: // SB
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.S.rs1);
			uint32_t memAddr = rs1v + immS(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %02Xh",
				s_RegABIName[instr.S.rs1], rs1v,
				s_RegABIName[instr.S.rs2], cpuGetRegister(cpu, instr.S.rs2),
				memAddr, *memVirtualToPhysical(mem, memAddr));
		}
		break;
		case 1: // SH
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.S.rs1);
			uint32_t memAddr = rs1v + immS(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %04Xh",
				s_RegABIName[instr.S.rs1], rs1v,
				s_RegABIName[instr.S.rs2], cpuGetRegister(cpu, instr.S.rs2),
				memAddr, *(uint16_t*)memVirtualToPhysical(mem, memAddr));
		}
		break;
		case 2: // SW
		{
			uint32_t rs1v = cpuGetRegister(cpu, instr.S.rs1);
			uint32_t memAddr = rs1v + immS(instr);
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n[%08Xh] = %08Xh",
				s_RegABIName[instr.S.rs1], rs1v,
				s_RegABIName[instr.S.rs2], cpuGetRegister(cpu, instr.S.rs2),
				memAddr, *(uint32_t*)memVirtualToPhysical(mem, memAddr));
		}
		break;
		default:
			break;
		}
		break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
		case ALUOp::ShiftLeft:
		case ALUOp::SLT:
		case ALUOp::SLTU:
		case ALUOp::Xor:
		case ALUOp::ShiftRight:
		case ALUOp::Or:
		case ALUOp::And:
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\n%s = %08Xh",
				s_RegABIName[instr.R.rd], cpuGetRegister(cpu, instr.R.rd),
				s_RegABIName[instr.R.rs1], cpuGetRegister(cpu, instr.R.rs1),
				s_RegABIName[instr.R.rs2], cpuGetRegister(cpu, instr.R.rs2));
			break;
		}
		break;
	case Opcode::LUI:
		bx::snprintf(buf, len, "%s = %08Xh", 
			s_RegABIName[instr.U.rd], cpuGetRegister(cpu, instr.U.rd));
		break;
	case Opcode::Branch:
	{
		uint32_t rs1v = cpuGetRegister(cpu, instr.B.rs1);
		uint32_t rs2v = cpuGetRegister(cpu, instr.B.rs2);
		uint32_t targetAddr = addr + immB(instr);

		bool jump = false;
		switch (instr.B.funct3) {
		case BranchOp::Equal:                jump = rs1v == rs2v;                   break;
		case BranchOp::NotEqual:             jump = rs1v != rs2v;                   break;
		case BranchOp::LessThan:             jump = (int32_t)rs1v < (int32_t)rs2v;  break;
		case BranchOp::GreaterEqual:         jump = (int32_t)rs1v >= (int32_t)rs2v; break;
		case BranchOp::LessThanUnsigned:     jump = rs1v < rs2v;                    break;
		case BranchOp::GreaterEqualUnsigned: jump = rs1v >= rs2v;                   break;
		default: break; 
		}

		bx::snprintf(buf, len, "Branch is %staken\nTarget = %08Xh\n%s = %08Xh\n%s = %08Xh\n",
			jump ? "" : "NOT ",
			targetAddr,
			s_RegABIName[instr.B.rs1], rs1v,
			s_RegABIName[instr.B.rs2], rs2v);
	}
	break;
	case Opcode::JALR:
	{
		uint32_t rs1v = cpuGetRegister(cpu, instr.I.rs1);
		uint32_t targetAddr = (rs1v + immI(instr)) & 0xFFFFFFFE;
		if (instr.I.rd == 0 && instr.I.rs1 == 1 && instr.I.imm == 0) {
			bx::snprintf(buf, len, "Return to %08Xh", targetAddr);
		} else if (instr.I.rd == 0 && instr.I.imm == 0) {
			bx::snprintf(buf, len, "%s = %08Xh\nTarget = %08Xh",
				s_RegABIName[instr.I.rs1], rs1v,
				targetAddr);
		} else {
			bx::snprintf(buf, len, "%s = %08Xh\n%s = %08Xh\nTarget = %08Xh",
				s_RegABIName[instr.I.rd], cpuGetRegister(cpu, instr.I.rd),
				s_RegABIName[instr.I.rs1], rs1v, 
				targetAddr);
		}
	}
	break;
	case Opcode::JAL:
	{
		uint32_t targetAddr = addr + immJ(instr);
		if (instr.J.rd == 0) {
			// Unconditional jump or halt
		} else if (instr.J.rd == 1) {
			// call
		} else {
			bx::snprintf(buf, len, "%s = %08Xh\nTarget = %08Xh", 
				s_RegABIName[instr.J.rd], cpuGetRegister(cpu, instr.J.rd),
				targetAddr);
		}
	}
	break;
	case Opcode::System:
		// TODO: Implement all the other system instructions.
		switch (instr.I.imm) {
		case 0: // ECALL
		{
			uint32_t a0v = cpuGetRegister(cpu, IReg::a0);
			bx::snprintf(buf, len, "syscall %04Xh (decimal %u)", a0v, a0v);
			break;
		}
		case 1: // EBREAK
			break;
		default:
			break;
		}
		break;
	default:
		break;
	}
}
}
