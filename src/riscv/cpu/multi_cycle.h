#ifndef RISCV_CPU_MULTI_CYCLE_H
#define RISCV_CPU_MULTI_CYCLE_H

#include "../icpu.h"
#include "../tlb.h"
#include "../alu.h"
#include "../../debug.h"

namespace riscv
{
namespace cpu
{
class MultiCycle : public ICPU
{
public:
	MultiCycle();
	virtual ~MultiCycle();

	virtual void reset(word_t pc);
	virtual bool tick(MemoryMap* mm);

	virtual PrivLevel::Enum getPrivilegeLevel();
	virtual word_t getPC();
	virtual word_t getRegister(uint32_t reg);
	virtual word_t getCSR(uint32_t csr);
	virtual dword_t getCSR64(uint32_t csrLow);
	virtual word_t getOutputPin(OutputPin::Enum pin);
	virtual bool getMemWord(MemoryMap* mm, word_t addr, word_t& data);
	virtual void readState(CPUState* state);

private:
	struct Stage
	{
		enum Enum : uint32_t
		{
			InstructionFetch = 0,
			Decode = 1,
			Execute = 2,
			Memory = 3,
			WriteBack = 4
		};
	};

	struct RegFileDataSrc
	{
		enum Enum : uint32_t
		{
			DontCare = 0,

			ALU = 0,
			DataMemory = 1,
			AddrCalc = 2,
			PC_plus_4 = 3,
			CSR = 4
		};
	};

	struct AddrCalcSrcA
	{
		enum Enum : uint32_t
		{
			PC = 0,
			RegFileA = 1
		};
	};

	struct ALUASrc
	{
		enum Enum : uint32_t
		{
			Zero = 0,
			RegFileA = 1
		};
	};

	struct ALUBSrc
	{
		enum Enum : uint32_t
		{
			RegFileB = 0,
			Imm = 1
		};
	};

	struct NextPCSrc
	{
		enum Enum : uint32_t
		{
			PC_plus_4 = 0,
			BranchTarget = 1, // If Comparator's result is 1 use Address Calculator's output. Otherwise, use PC + 4
			AddrCalc = 2,     // Use Address Calculator's output unconditionally
			mepc = 3          // Use mepc CSR (return from exception)
		};
	};

	struct CSRDataSrc
	{
		enum Enum : uint32_t
		{
			// 3 bits: ZYX
			// X: 0 = RegFile, 1 = Imm
			// Y: 0 = Copy, 1 = Apply function
			// Z: 0 = a OR b, 1 = a AND NOT b
			RegFileA             = 0, // 000 => csr = RF.A
			Imm                  = 1, // 001 => csr = Imm
			CSR_or_RegFileA      = 2, // 010 => csr = csr | RF.A
			CSR_or_Imm           = 3, // 011 => csr = csr | Imm
			CSR_and_not_RegFileA = 6, // 110 => csr = csr & ~RF.A
			CSR_and_not_Imm      = 7  // 111 => csr = csr & ~Imm
		};
	};

	struct MMUState
	{
		enum Enum : uint32_t
		{
			Idle,
			WaitForMemory,
			PageTableWalk_L1,
			PageTableWalk_L0
		};
	};

	union MicroOp
	{
		dword_t m_Word;

		struct Control
		{
			// Register file (32-bit x 32 registers)
			// NOTE: The Register File doesn't have a WriteEnable signal. 
			// If an instruction shouldn't write to the RF, it uses x0 as its destination register.
			// The WriteEnable signal to the RF is whether the current stage is the WriteBack stage.
			uint32_t m_RegFile_rA : 5;
			uint32_t m_RegFile_rB : 5;
			uint32_t m_RegFile_rD : 5;
			uint32_t m_RegFile_dD_src : 3;

			// Address calculator (32-bit adder)
			uint32_t m_AddrCalc_srcA : 1;
			
			// Data memory
			uint32_t m_DataMem_valid : 1;
			uint32_t m_DataMem_we : 1;
			uint32_t m_DataMem_size : 2;

			// ALU
			uint32_t m_ALU_srcA : 1;
			uint32_t m_ALU_srcB : 1;
			uint32_t m_ALU_func : 3;
			uint32_t m_ALU_secFunc : 1;

			// Next PC
			uint32_t m_NextPCSrc : 2;

			// CSR
			uint32_t m_CSR_id : 12;
			uint32_t m_CSR_we : 1;
			uint32_t m_CSR_src : 3;
			
			// Misc
			uint32_t m_Breakpoint : 1;
			uint32_t m_FlushTLB : 1;
		} m_Control;
	};

	struct ExceptionState
	{
		word_t m_Val;
		uint8_t m_Cause; // 4 bits
		uint8_t m_Enabled; // 1 bit
	};
	
	struct State
	{
		word_t m_IRegs[32];
		word_t m_PC;
		word_t m_CSR[4096];
		PrivLevel::Enum m_PrivLevel;
		Stage::Enum m_Stage;
		bool m_Breakpoint;

		// Intermediate stage results
		word_t m_InstrReg; // Instruction register
		word_t m_Imm;
		word_t m_RegFileA; // Filled in the Execute stage, used by the CSR logic during the WriteBack stage
		word_t m_ALUResult;
		word_t m_EffectiveAddress;
		word_t m_DataMemResult;
		uint32_t m_ComparatorResult; // 1 bit
		MicroOp m_MicroOp; // Current micro operation
		ExceptionState m_Exception;

		// Memory Management Unit
		MMUState::Enum m_MMUState;
		word_t m_MemReq_addr;
		word_t m_MemReq_data;
		uint32_t m_MemReq_size; // 0 = 1 byte, 1 = 2 bytes, 2 = 4 bytes
		bool m_MemReq_valid;
		bool m_MemReq_rw;

		word_t m_MemRes_data;
		bool m_MemRes_valid; // Flag indicating whether mmRead/mmWrite has succeeded or not.
		bool m_MemRes_ready; // Flag indicating whether mmRead/mmWrite has finished.
	};

	State m_State;
	State m_NextState;
	TLB m_ITLB;
	TLB m_DTLB;

	void stageInstructionFetch();
	void stageDecode();
	void stageExecute();
	void stageMemory();
	void stageWriteBack();

	void memRequest(word_t addr, bool we, uint32_t sz, uint32_t data);
	bool instrMemRead(word_t virtualAddress, word_t& data);
	bool dataMemRead(word_t virtualAddress, uint32_t sz, uint32_t& data);
	bool dataMemWrite(word_t virtualAddress, uint32_t sz, uint32_t data);

	void raiseException(Exception::Enum cause, word_t val);
	void clearException();

	void uop_nop(MicroOp* uop);
	void uopRegFile(MicroOp* uop, uint32_t rA, uint32_t rB, uint32_t rD, RegFileDataSrc::Enum dataSrc);
	void uopAddressCalc(MicroOp* uop, AddrCalcSrcA::Enum srcA);
	void uopDataMem(MicroOp* uop, uint32_t sz, bool we);
	void uopALU(MicroOp* uop, ALUASrc::Enum srcA, ALUBSrc::Enum srcB, ALUFunction::Enum func, bool secondaryFunc);
	void uopNextPC(MicroOp* uop, NextPCSrc::Enum src);
	void uopBreakpoint(MicroOp* uop);
	void uopFlushTLB(MicroOp* uop);
	void uopCSR(MicroOp* uop, uint32_t csr, bool we, CSRDataSrc::Enum src);

	void csr64Inc(CSR::Enum csrLow, uint64_t n);
};

//////////////////////////////////////////////////////////////////////////
// Inline functions...
//
inline void MultiCycle::uop_nop(MicroOp* uop)
{
	uop->m_Word = 0;
}

inline void MultiCycle::uopRegFile(MicroOp* uop, uint32_t rA, uint32_t rB, uint32_t rD, RegFileDataSrc::Enum dataSrc)
{
	RISCV_CHECK(rA < 32 && rB < 32 && rD < 32 && dataSrc < 8, "Invalid control signals");
	uop->m_Control.m_RegFile_rA = rA;
	uop->m_Control.m_RegFile_rB = rB;
	uop->m_Control.m_RegFile_rD = rD;
	uop->m_Control.m_RegFile_dD_src = dataSrc;
}

inline void MultiCycle::uopAddressCalc(MicroOp* uop, AddrCalcSrcA::Enum srcA)
{
	RISCV_CHECK(srcA < 2, "Invalid control signals");
	uop->m_Control.m_AddrCalc_srcA = srcA;
}

inline void MultiCycle::uopDataMem(MicroOp* uop, uint32_t sz, bool we)
{
	RISCV_CHECK(sz < 4, "Invalid control signals");
	uop->m_Control.m_DataMem_size = sz;
	uop->m_Control.m_DataMem_we = we ? 1 : 0;
	uop->m_Control.m_DataMem_valid = true;
}

inline void MultiCycle::uopALU(MicroOp* uop, ALUASrc::Enum srcA, ALUBSrc::Enum srcB, ALUFunction::Enum func, bool secondaryFunc)
{
	RISCV_CHECK(srcA < 2 && srcB < 2 && func < 8, "Invalid control signals");
	uop->m_Control.m_ALU_srcA = srcA;
	uop->m_Control.m_ALU_srcB = srcB;
	uop->m_Control.m_ALU_func = func;
	uop->m_Control.m_ALU_secFunc = secondaryFunc ? 1 : 0;
}

inline void MultiCycle::uopNextPC(MicroOp* uop, NextPCSrc::Enum src)
{
	RISCV_CHECK(src < 4, "Invalid control signals");
	uop->m_Control.m_NextPCSrc = src;
}

inline void MultiCycle::uopBreakpoint(MicroOp* uop)
{
	uop->m_Control.m_Breakpoint = 1;
}

inline void MultiCycle::uopFlushTLB(MicroOp* uop)
{
	uop->m_Control.m_FlushTLB = 1;
}

inline void MultiCycle::uopCSR(MicroOp* uop, uint32_t csr, bool we, CSRDataSrc::Enum src)
{
	RISCV_CHECK(csr < 4096 && src < 8, "Invalid control signals");
	uop->m_Control.m_CSR_id = csr;
	uop->m_Control.m_CSR_we = we ? 1 : 0;
	uop->m_Control.m_CSR_src = src;
}

// Exceptions
inline void MultiCycle::raiseException(Exception::Enum cause, word_t val)
{
	m_NextState.m_Exception.m_Enabled = 1;
	m_NextState.m_Exception.m_Cause = (uint8_t)cause;
	m_NextState.m_Exception.m_Val = val;
}

inline void MultiCycle::clearException()
{
	m_NextState.m_Exception.m_Enabled = 0;
}

// CSRs
inline void MultiCycle::csr64Inc(CSR::Enum csrLow, uint64_t n)
{
	const uint32_t l = m_State.m_CSR[csrLow];
	const uint32_t h = m_State.m_CSR[csrLow | 0x80];
	const uint64_t cnt = (uint64_t)l | (((uint64_t)h) << 32);
	const uint64_t cntNew = cnt + n;
	const uint32_t nl = (uint32_t)(cntNew & 0x00000000FFFFFFFF);
	const uint32_t hi = (uint32_t)((cntNew & 0xFFFFFFFF00000000) >> 32);

	m_NextState.m_CSR[csrLow] = nl;
	m_NextState.m_CSR[csrLow | 0x80] = hi;
}

// Memory
inline void MultiCycle::memRequest(word_t addr, bool we, uint32_t sz, uint32_t data)
{
	m_NextState.m_MemReq_valid = true;
	m_NextState.m_MemReq_addr = addr;
	m_NextState.m_MemReq_rw = we;
	m_NextState.m_MemReq_size = sz;
	m_NextState.m_MemReq_data = data;
}
}
}

#endif
