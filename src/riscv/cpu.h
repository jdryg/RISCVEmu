#ifndef RISCV_CPU_H
#define RISCV_CPU_H

#include <stdint.h>
#include "tlb.h"

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
struct MemoryMap;

const uint32_t kPageShift = 12; // 4k
const uint32_t kPageSize = 1 << kPageShift; // virtual and physical
const uint32_t kAddressOffsetMask = (1 << kPageShift) - 1;
const uint32_t kVirtualPageNumberMask = ~kAddressOffsetMask;

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

struct CSR
{
	enum Enum
	{
		// User Counter/Timers
		cycle = 0xC00,       // URO
		time = 0xC01,        // URO
		instret = 0xC02,     // URO
		cycleh = 0xC80,      // URO
		timeh = 0xC81,       // URO
		instreth = 0xC82,    // URO

		// Machine Information Registers
		mvendorid = 0xF11,   // MRO
		marchid = 0xF12,     // MRO
		mimpid = 0xF13,      // MRO
		mhartid = 0xF14,     // MRO

		// Machine Trap Setup
		mstatus = 0x300,     // MRW
		misa = 0x301,        // MRW
		medeleg = 0x302,     // MRW
		mideleg = 0x303,     // MRW
		mie = 0x304,         // MRW
		mtvec = 0x305,       // MRW
		mcounteren = 0x306,  // MRW

		// Machine Trap Handling
		mscratch = 0x340,    // MRW
		mepc = 0x341,        // MRW
		mcause = 0x342,      // MRW
		mtval = 0x343,       // MRW
		mip = 0x344,         // MRW

		// Machine Protection and Translation
		// ???

		// Machine Counter/Timers
		mcycle = 0xB00,      // MRW
		minstret = 0xB02,    // MRW
		mcycleh = 0xB80,     // MRW
		minstreth = 0xB82,    // MRW

		// Supervisor Protection and Translation 
		// NOTE: Even though the current simulator only supports U + M modes this is the only 
		// supervisor CSR used because it has a well defined meaning in the specs and can be
		// used even in machine mode (higher privilege level).
		satp = 0x180,
	};
};

struct IReg
{
	enum Enum
	{
		zero = 0,
		ra = 1,
		sp = 2,
		gp = 3,
		tp = 4,
		t0 = 5,
		t1 = 6,
		t2 = 7,
		s0 = 8,
		s1 = 9,
		a0 = 10,
		a1 = 11,
		a2 = 12,
		a3 = 13,
		a4 = 14,
		a5 = 15,
		a6 = 16,
		a7 = 17,
		s2 = 18,
		s3 = 19,
		s4 = 20, 
		s5 = 21, 
		s6 = 22, 
		s7 = 23,
		s8 = 24,
		s9 = 25,
		s10 = 26,
		s11 = 27,
		t3 = 28,
		t4 = 29,
		t5 = 30, 
		t6 = 31
	};
};

struct PrivLevel
{
	// 2 bits
	enum Enum : uint32_t
	{
		User = 0,
//		Supervisor = 1, // Unused
//		Reserved = 2, 
		Machine = 3
	};
};

struct Exception
{
	enum Enum : uint32_t
	{
		InstructionAddressMisaligned = 0,
		InstructionAccessFault = 1,
		IllegalInstruction = 2,
		Breakpoint = 3,
		LoadAddressMisaligned = 4,
		LoadAccessFault = 5,
		StoreAddressMisaligned = 6,
		StoreAccessFault = 7,
		EnvCallFromUser = 8,
		EnvCallFromSupervisor = 9,
		EnvCallFromMachine = 11,
		InstructionPageFault = 12,
		LoadPageFault = 13,
		StorePageFault = 14,
	};
};

struct CPUState
{
	// User-visible integer state
	word_t m_IRegs[32];
	word_t m_PC;

	// Control and Status Registers (CSRs)
	word_t m_CSR[4096]; // NOTE: Only a handful of CSRs are defined/used but lets have them all :)

	PrivLevel::Enum m_PrivLevel;
};

struct CPU
{
	CPUState m_State;
	CPUState m_NextState;
	TLB m_ITLB;
	TLB m_DTLB;
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

union PageTableEntry
{
	uint32_t m_Word;

	struct _Fields
	{
		uint32_t m_Valid : 1;
		uint32_t m_Read : 1;
		uint32_t m_Write : 1;
		uint32_t m_Execute : 1;
		uint32_t m_UserModeAccessible : 1;
		uint32_t m_Global : 1;
		uint32_t m_Accessed : 1;
		uint32_t m_Dirty : 1;
		uint32_t m_RSW : 2;
		uint32_t m_PhysicalPageNumber : 22;
	} m_Fields;
};

inline word_t sext(uint32_t v, uint32_t signBitPos)
{
	const uint32_t shiftAmount = 31 - signBitPos;
	return (word_t)((((int32_t)v) << shiftAmount) >> shiftAmount);
}

inline word_t immI(Instruction instr)
{
	return sext(instr.I.imm, 11);
}

inline word_t immU(Instruction instr)
{
	return instr.U.imm_12_31 << 12;
}

inline word_t immS(Instruction instr)
{
	return sext(instr.S.imm_0_4 | (instr.S.imm_5_11 << 5), 11);
}

inline word_t immJ(Instruction instr)
{
	return sext((instr.J.imm_1_10 << 1) | (instr.J.imm_11 << 11) | (instr.J.imm_12_19 << 12) | (instr.J.imm_20 << 20), 20);
}

inline word_t immB(Instruction instr)
{
	return sext((instr.B.imm_1_4 << 1) | (instr.B.imm_5_10 << 5) | (instr.B.imm_11 << 11) | (instr.B.imm_12 << 12), 12);
}

word_t cpuGetPC(CPU* cpu);
void cpuSetPC(CPU* cpu, word_t val);
word_t cpuGetRegister(CPU* cpu, uint32_t reg);
void cpuSetRegister(CPU* cpu, uint32_t reg, word_t val);
word_t cpuGetCSR(CPU* cpu, uint32_t csr);
word_t cpuReadCSR(CPU* cpu, uint32_t csr); // Same as GetCSR() but without the privilege checks. Used by the page table walker.
void cpuSetCSR(CPU* cpu, uint32_t csr, word_t val);
uint32_t cpuGetPrivLevel(CPU* cpu);
void cpuRaiseException(CPU* cpu, Exception::Enum cause);
void cpuReturnFromException(CPU* cpu);
void cpuIncCounter64(CPU* cpu, CSR::Enum csrLow, uint32_t n);
void cpuShadowCSR64(CPU* cpu, CSR::Enum dst, CSR::Enum src);
uint64_t cpuGetCSR64(CPU* cpu, CSR::Enum csrLow);

// core_single_cycle.cpp
void cpuReset(CPU* cpu, word_t pc, word_t sp);
void cpuTick_SingleCycle(CPU* cpu, MemoryMap* mem);

// disasm.cpp
void disasmInstruction(uint32_t instr, uint32_t addr, char* buf, uint32_t len);
void disasmGetInstrOperandValues(CPU* cpu, MemoryMap* mem, uint32_t instr, uint32_t addr, char* str, uint32_t len);
const char* disasmGetRegisterABIName(uint32_t reg);
}

#endif
