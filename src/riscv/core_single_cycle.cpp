#include "cpu.h"
#include "../memory.h"
#include "../debug.h"
#include "../syscall.h"
#include <bx/bx.h>

namespace riscv
{
void cpuReset(CPU* cpu, word_t pc, word_t sp)
{
	cpu->m_NextState.m_IRegs[0] = 0;
	cpu->m_NextState.m_IRegs[2] = sp;
	cpu->m_NextState.m_PC = pc;
	bx::memCopy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}

void cpuExecuteSystemCall(CPU* cpu, Memory* mem)
{
	uint32_t sysCallID = cpuGetRegister(cpu, 17);
	switch (sysCallID) {
	case SYS_fstat:
		cpuSetRegister(cpu, 10, (uint32_t)sys_fstat((int)cpuGetRegister(cpu, 10), memVirtualToPhysical(mem, cpuGetRegister(cpu, 11))));
		break;
	case SYS_brk:
		cpuSetRegister(cpu, 10, (uint32_t)sys_brk(cpuGetRegister(cpu, 10)));
		break;
	case SYS_close:
		cpuSetRegister(cpu, 10, (uint32_t)sys_close((int)cpuGetRegister(cpu, 10)));
		break;
	case SYS_lseek:
		cpuSetRegister(cpu, 10, (uint32_t)sys_lseek((int)cpuGetRegister(cpu, 10), (size_t)cpuGetRegister(cpu, 11), (int)cpuGetRegister(cpu, 12)));
		break;
	case SYS_read:
		cpuSetRegister(cpu, 10, (uint32_t)sys_read((int)cpuGetRegister(cpu, 10), (char*)memVirtualToPhysical(mem, cpuGetRegister(cpu, 11)), (size_t)cpuGetRegister(cpu, 12)));
		break;
	case SYS_write:
		cpuSetRegister(cpu, 10, (uint32_t)sys_write((int)cpuGetRegister(cpu, 10), (const char*)memVirtualToPhysical(mem, cpuGetRegister(cpu, 11)), (size_t)cpuGetRegister(cpu, 12)));
		break;
	case SYS_exit:
		sys_exit((int)cpuGetRegister(cpu, 10));
		break;
	default:
		RISCV_TRACE("0x%08X: ECALL a0=%08Xh, a1=%08Xh, a2=%08Xh, a3=%08Xh, a4=%08Xh, a5=%08Xh, a6=%08Xh, a7=%08Xh\n"
			, cpuGetPC(cpu)
			, cpuGetRegister(cpu, 10)
			, cpuGetRegister(cpu, 11)
			, cpuGetRegister(cpu, 12)
			, cpuGetRegister(cpu, 13)
			, cpuGetRegister(cpu, 14)
			, cpuGetRegister(cpu, 15)
			, cpuGetRegister(cpu, 16)
			, cpuGetRegister(cpu, 17));
		RISCV_CHECK(false, "Unknown syscall %08Xh", cpuGetRegister(cpu, 17));
		break;
	}
}

// Issues: Multiple memory reads and writes in a single cycle (assuming Von Neumann architecture).
// A single read (read next instruction) and a single write (i.e. from store instructions) can be implemented
// by using both the rising and falling edge of the clock. But a 2nd read (i.e. from load instructions) cannot
// be implemented (requires a combinational read from memory; if at all possible).
void cpuTick_SingleCycle(CPU* cpu, Memory* mem)
{
	Instruction instr;
	instr.m_Word = memRead32(mem, cpuGetPC(cpu), RegionFlags::Execute);

	cpuSetPC(cpu, cpuGetPC(cpu) + 4);

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	RISCV_CHECK((opcode & 3) == 3, "Invalid opcode");
	switch (opcode) {
	case Opcode::Load:
		switch (instr.I.funct3) {
		case 0: // LB
			cpuSetRegister(cpu, instr.I.rd, sext(memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr), 0) & 0xFF, 7));
			break;
		case 1: // LH
			cpuSetRegister(cpu, instr.I.rd, sext(memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr), 0) & 0xFFFF, 15));
			break;
		case 2: // LW
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr), 0));
			break;
		case 4: // LBU
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr), 0) & 0xFF);
			break;
		case 5: // LHU
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr), 0) & 0xFFFF);
			break;
		default:
			RISCV_CHECK(false, "Invalid load size (%01Xh)", instr.I.funct3);
			break;
		}
		break;
	case Opcode::MiscMem:
		// TODO: 
		RISCV_CHECK(false, "MISC-MEM opcodes not implemented yet");
		break;
	case Opcode::OpImm:
		switch (instr.I.funct3) {
		case ALUOp::AddSub:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) + immI(instr));
			break;
		case ALUOp::ShiftLeft:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) << shamt);
		}
			break;
		case ALUOp::SLT:
			cpuSetRegister(cpu, instr.I.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.I.rs1) < (int32_t)immI(instr) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			cpuSetRegister(cpu, instr.I.rd, (word_t)(cpuGetRegister(cpu, instr.I.rs1) < immI(instr) ? 1 : 0));
			break;
		case ALUOp::Xor:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) ^ immI(instr));
			break;
		case ALUOp::ShiftRight:
		{
			const uint32_t shamt = instr.I.imm & 0x1F;
			const uint32_t arithmeticShift = instr.I.imm & 0x800;
			if (arithmeticShift) {
				cpuSetRegister(cpu, instr.I.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.I.rs1) >> shamt));
			} else {
				cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) >> shamt);
			}
		}
			break;
		case ALUOp::Or:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) | immI(instr));
			break;
		case ALUOp::And:
			cpuSetRegister(cpu, instr.I.rd, cpuGetRegister(cpu, instr.I.rs1) & immI(instr));
			break;
		}
		break;
	case Opcode::AUIPC:
		cpuSetRegister(cpu, instr.U.rd, cpuGetPC(cpu) + immU(instr));
		break;
	case Opcode::Store:
		switch (instr.S.funct3) {
		case 0: // SB
			memWrite8(mem, cpuGetRegister(cpu, instr.S.rs1) + immS(instr), (uint8_t)(cpuGetRegister(cpu, instr.S.rs2) & 0xFF));
			break;
		case 1: // SH
			memWrite16(mem, cpuGetRegister(cpu, instr.S.rs1) + immS(instr), (uint16_t)(cpuGetRegister(cpu, instr.S.rs2) & 0xFFFF));
			break;
		case 2: // SW
			memWrite32(mem, cpuGetRegister(cpu, instr.S.rs1) + immS(instr), cpuGetRegister(cpu, instr.S.rs2));
			break;
		default:
			RISCV_CHECK(false, "Invalid store width (%02Xh)", instr.S.funct3);
			break;
		}
		break;
	case Opcode::Op:
		switch (instr.R.funct3) {
		case ALUOp::AddSub:
			if (instr.R.funct7 != 0) {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) - cpuGetRegister(cpu, instr.R.rs2));
			} else {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) + cpuGetRegister(cpu, instr.R.rs2));
			}
			break;
		case ALUOp::ShiftLeft:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) << (cpuGetRegister(cpu, instr.R.rs2) & 0x1F));
			break;
		case ALUOp::SLT:
			cpuSetRegister(cpu, instr.R.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.R.rs1) < (int32_t)cpuGetRegister(cpu, instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::SLTU:
			cpuSetRegister(cpu, instr.R.rd, (word_t)(cpuGetRegister(cpu, instr.R.rs1) < cpuGetRegister(cpu, instr.R.rs2) ? 1 : 0));
			break;
		case ALUOp::Xor:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) ^ cpuGetRegister(cpu, instr.R.rs2));
			break;
		case ALUOp::ShiftRight:
			if (instr.R.funct7 != 0) {
				cpuSetRegister(cpu, instr.R.rd, (word_t)((int32_t)cpuGetRegister(cpu, instr.R.rs1) >> (cpuGetRegister(cpu, instr.R.rs2) & 0x1F)));
			} else {
				cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) >> (cpuGetRegister(cpu, instr.R.rs2) & 0x1F));
			}
			break;
		case ALUOp::Or:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) | cpuGetRegister(cpu, instr.R.rs2));
			break;
		case ALUOp::And:
			cpuSetRegister(cpu, instr.R.rd, cpuGetRegister(cpu, instr.R.rs1) & cpuGetRegister(cpu, instr.R.rs2));
			break;
		}
		break;
	case Opcode::LUI:
		cpuSetRegister(cpu, instr.U.rd, immU(instr));
		break;
	case Opcode::Branch:
	{
		bool jump = false;
		switch (instr.B.funct3) {
		case BranchOp::Equal:
			jump = cpuGetRegister(cpu, instr.B.rs1) == cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::NotEqual:
			jump = cpuGetRegister(cpu, instr.B.rs1) != cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::LessThan:
			jump = (int32_t)cpuGetRegister(cpu, instr.B.rs1) < (int32_t)cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::GreaterEqual:
			jump = (int32_t)cpuGetRegister(cpu, instr.B.rs1) >= (int32_t)cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::LessThanUnsigned:
			jump = cpuGetRegister(cpu, instr.B.rs1) < cpuGetRegister(cpu, instr.B.rs2);
			break;
		case BranchOp::GreaterEqualUnsigned:
			jump = cpuGetRegister(cpu, instr.B.rs1) >= cpuGetRegister(cpu, instr.B.rs2);
			break;
		default:
			RISCV_CHECK(false, "Invalid branch code %02Xh", instr.B.funct3);
			break;
		}

		if (jump) {
			cpuSetPC(cpu, cpuGetPC(cpu) + immB(instr));
		}
	}
		break;
	case Opcode::JALR:
		// TODO: The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
		// address is not aligned to a four-byte boundary.
		RISCV_CHECK(instr.I.funct3 == 0, "Invalid funct3 field in JALR. Expecting 00h, found %02Xh", instr.I.funct3);
		cpuSetRegister(cpu, instr.I.rd, cpuGetPC(cpu) + 4);
		cpuSetPC(cpu, (cpuGetRegister(cpu, instr.I.rs1) + immI(instr)) & 0xFFFFFFFE);
		break;
	case Opcode::JAL:
		// TODO: The JAL and JALR instructions will generate a misaligned instruction fetch exception if the target
		// address is not aligned to a four-byte boundary.
		cpuSetRegister(cpu, instr.J.rd, cpuGetPC(cpu) + 4);
		cpuSetPC(cpu, cpuGetPC(cpu) + immJ(instr));
		break;
	case Opcode::System:
		RISCV_CHECK(instr.I.funct3 == 0, "Invalid funct3 field in SYSTEM instruction. Expecting 00h, found %02Xh", instr.I.funct3);
		RISCV_CHECK(instr.I.rd == 0, "Invalid rd field in SYSTEM instruction. Expecting 00h, found %02Xh", instr.I.rd);
		RISCV_CHECK(instr.I.rs1 == 0, "Invalid rs1 field in SYSTEM instruction. Expecting 00h, found %02Xh", instr.I.rs1);
		switch (instr.I.imm) {
		case 0: // ECALL
			cpuExecuteSystemCall(cpu, mem);
			break;
		case 1: // EBREAK
			RISCV_CHECK(false, "EBREAK not implemented yet");
			break;
		default:
			RISCV_CHECK(false, "Invalid SYSTEM instruction (imm = %08Xh)", instr.I.imm);
		}
		break;
	default:
		RISCV_CHECK(false, "Invalid opcode %02Xh", opcode);
		break;
	}

	// Switch states
	bx::memCopy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}
}
