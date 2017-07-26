#include "elf/parser.h"

#include <stdint.h>
#include <stdio.h>
#include <malloc.h>
#include <memory.h>
#include <assert.h>

#pragma warning(disable: 4127) // conditional expression is constant

#ifndef XLEN
#define XLEN 32
#endif

#if XLEN == 32
typedef uint32_t word_t;
#elif XLEN == 64
typedef uint64_t word_t;
#error "Not implemented yet!";
#else
#error "Invalid XLEN value";
#endif

namespace riscv
{
struct Opcode
{
	enum Enum
	{
		Load = 0x03,
		MiscMem = 0x0F,
		OpImm = 0x13,
		AUIPC = 0x17,
		Store = 0x23,
		Op = 0x33,
		LUI = 0x37,
		Branch = 0x63,
		JALR = 0x67,
		JAL = 0x6F,
		System = 0x73
	};
};

struct ALUOp
{
	enum Enum
	{
		AddSub = 0,
		ShiftLeft = 1,
		SLT = 2,
		SLTU = 3,
		Xor = 4,
		ShiftRight = 5,
		Or = 6,
		And = 7
	};
};

struct BranchOp
{
	enum Enum
	{
		// 3 bits XYZ
		// Z = Polarity (0 = don't invert result, 1 = invert result)
		// Y = Sign (0 = signed comparison, 1 = unsigned comparison)
		// X = Inequality (0 = Equal, 1 = less than)
		// 01Z doesn't make sense since the sign doesn't make a difference when comparing 2 numbers for equality.
		Equal = 0,
		NotEqual = 1,
		LessThan = 4,
		GreaterEqual = 5,
		LessThanUnsigned = 6,
		GreaterEqualUnsigned = 7,
	};
};

struct CPUState
{
	// User-visible integer state
	word_t m_IRegs[32];
	word_t m_PC;
};

struct CPU
{
	CPUState m_State;
	CPUState m_NextState;
};

struct Memory
{
	uint8_t* m_Data;
	uint32_t m_Size;
};

union Instruction
{
	uint32_t m_Word;

	struct _R
	{
		uint32_t opcode : 7;
		uint32_t rd : 5;
		uint32_t funct3 : 3;
		uint32_t rs1 : 5;
		uint32_t rs2 : 5;
		uint32_t funct7 : 7;
	} R;

	struct _I
	{
		uint32_t opcode : 7;
		uint32_t rd : 5;
		uint32_t funct3 : 3;
		uint32_t rs1 : 5;
		uint32_t imm : 12;
	} I;

	struct _S
	{
		uint32_t opcode : 7;
		uint32_t imm_0_4 : 5;
		uint32_t funct3 : 3;
		uint32_t rs1 : 5;
		uint32_t rs2 : 5;
		uint32_t imm_5_11 : 7;
	} S;

	struct _B
	{
		uint32_t opcode : 7;
		uint32_t imm_11 : 1;
		uint32_t imm_1_4 : 4;
		uint32_t funct3 : 3;
		uint32_t rs1 : 5;
		uint32_t rs2 : 5;
		uint32_t imm_5_10 : 6;
		uint32_t imm_12 : 1;
	} B;

	struct _U
	{
		uint32_t opcode : 7;
		uint32_t rd : 5;
		uint32_t imm_12_31 : 20;
	} U;

	struct _J
	{
		uint32_t opcode : 7;
		uint32_t rd : 5;
		uint32_t imm_12_19 : 8;
		uint32_t imm_11 : 1;
		uint32_t imm_1_10 : 10;
		uint32_t imm_20 : 1;
	} J;
};

word_t sext(uint32_t v, uint32_t signBitPos)
{
	const uint32_t shiftAmount = 31 - signBitPos;
	return (word_t)((((int32_t)v) << shiftAmount) >> shiftAmount);
}

word_t immI(Instruction instr)
{
	return sext(instr.I.imm, 11);
}

word_t immU(Instruction instr)
{
	return instr.U.imm_12_31 << 12;
}

word_t immS(Instruction instr)
{
	return sext(instr.S.imm_0_4 | (instr.S.imm_5_11 << 5), 11);
}

word_t immJ(Instruction instr)
{
	return sext((instr.J.imm_1_10 << 1) | (instr.J.imm_11 << 11) | (instr.J.imm_12_19 << 12) | (instr.J.imm_20 << 20), 20);
}

word_t immB(Instruction instr)
{
	return sext((instr.B.imm_1_4 << 1) | (instr.B.imm_5_10 << 5) | (instr.B.imm_11 << 11) | (instr.B.imm_12 << 12), 12);
}

bool memInit(Memory* mem, uint32_t size)
{
	mem->m_Data = (uint8_t*)malloc(size);
	if (!mem->m_Data) {
		return false;
	}

	memset(mem->m_Data, 0x55, size);
	mem->m_Size = size;

	return true;
}

uint32_t memRead32(Memory* mem, uint32_t addr)
{
	assert(addr + 3 < mem->m_Size);
	return *(uint32_t*)&mem->m_Data[addr];
}

void memWrite32(Memory* mem, uint32_t addr, uint32_t val)
{
	assert(addr + 3 < mem->m_Size);
	*(uint32_t*)&mem->m_Data[addr] = val;
}

void memWrite16(Memory* mem, uint32_t addr, uint16_t val)
{
	assert(addr + 1 < mem->m_Size);
	*(uint16_t*)&mem->m_Data[addr] = val;
}

void memWrite8(Memory* mem, uint32_t addr, uint8_t val)
{
	assert(addr < mem->m_Size);
	mem->m_Data[addr] = val;
}

word_t cpuGetPC(CPU* cpu)
{
	return cpu->m_State.m_PC;
}

void cpuSetPC(CPU* cpu, word_t val)
{
	cpu->m_NextState.m_PC = val;
}

word_t cpuGetRegister(CPU* cpu, uint32_t reg)
{
	return reg == 0 ? 0 : cpu->m_State.m_IRegs[reg];
}

void cpuSetRegister(CPU* cpu, uint32_t reg, word_t val)
{
	if (reg != 0) {
		cpu->m_NextState.m_IRegs[reg] = val;
	}
}

void cpuReset(CPU* cpu)
{
	cpu->m_State.m_IRegs[0] = 0;
	cpu->m_State.m_PC = 0;
}

// Issues: Multiple memory reads and writes in a single cycle (assuming Von Neumann architecture).
// A single read (read next instruction) and a single write (i.e. from store instructions) can be implemented
// by using both the rising and falling edge of the clock. But a 2nd read (i.e. from load instructions) cannot
// be implemented (requires a combinational read from memory; if at all possible).
void cpuTick_SingleCycle(CPU* cpu, Memory* mem)
{
	// instruction register
//	uint32_t ir = 0x00000013; // ADDI x0, x0, 0 == NOP
// 	uint32_t ir = 0x555550B7; // LUI x1, 0x55555000;
//	uint32_t ir = 0x0000F097; // AUIPC x1, 0x0000F000;
	const uint32_t ir = memRead32(mem, cpuGetPC(cpu));

	Instruction instr;
	instr.m_Word = ir;

	cpuSetPC(cpu, cpuGetPC(cpu) + 4);

	// Opcode is common to all instruction types.
	const uint32_t opcode = instr.R.opcode;
	assert((opcode & 3) == 3);
	switch (opcode) {
	case Opcode::Load:
		switch (instr.I.funct3) {
		case 0: // LB
			cpuSetRegister(cpu, instr.I.rd, sext(memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr)) & 0xFF, 7));
			break;
		case 1: // LH
			cpuSetRegister(cpu, instr.I.rd, sext(memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr)) & 0xFFFF, 15));
			break;
		case 2: // LW
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr)));
			break;
		case 4: // LBU
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr)) & 0xFF);
			break;
		case 5: // LHU
			cpuSetRegister(cpu, instr.I.rd, memRead32(mem, cpuGetRegister(cpu, instr.I.rs1) + immI(instr)) & 0xFFFF);
			break;
		default:
			assert(false);
			break;
		}
		break;
	case Opcode::MiscMem:
		// TODO: 
		assert(false); // Not implemented yet.
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
			assert(false); // Invalid branch code
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
		assert(instr.I.funct3 == 0);
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
		// TODO: ECALL?
		assert(false);
		break;
	default:
		assert(false);
		break;
	}

	// Switch states
	memcpy(&cpu->m_State, &cpu->m_NextState, sizeof(CPUState));
}
}

uint8_t* readFile(const char* filename, uint32_t& fileSize)
{
	FILE* f = fopen(filename, "rb");
	if (!f) {
		return nullptr;
	}

	fseek(f, 0, SEEK_END);
	fileSize = (uint32_t)ftell(f);
	fseek(f, 0, SEEK_SET);

	uint8_t* data = (uint8_t*)malloc(fileSize);
	if (!data) {
		return nullptr;
	}

	fread(data, sizeof(uint8_t), fileSize, f);

	fclose(f);

	return data;
}

int main()
{
	const char* elfFilename = "./multiply";

	uint32_t elfSize = ~0u;
	uint8_t* elfData = readFile(elfFilename, elfSize);
	if (!elfData) {
		printf("Failed read ELF file\n");
		return 1;
	}

	riscv::Memory mem;
	riscv::memInit(&mem, 1024 << 10); // 1MB RAM

	uint32_t entryPointAddr = elf::load(elfData, mem.m_Data, mem.m_Size);

	free(elfData);

	if (entryPointAddr == ~0u) {
		printf("Failed to load ELF file into memory.\n");
		return 1;
	}

	riscv::CPU cpu;
	riscv::cpuReset(&cpu);

	cpu.m_State.m_PC = entryPointAddr;

	while (true) {
		riscv::cpuTick_SingleCycle(&cpu, &mem);
	}

	return 0;
}
