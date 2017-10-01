#ifndef RISCV_CPU_MULTI_CYCLE_CACHE_H
#define RISCV_CPU_MULTI_CYCLE_CACHE_H

#include "../icpu.h"
#include "../tlb.h"
#include "../alu.h"
#include "../cache.h"
#include "../memory_map.h" // MemoryRequest, MemoryResponse
#include "../../debug.h"

namespace riscv
{
namespace cpu
{
class MultiCycleCache : public ICPU
{
public:
	MultiCycleCache();
	virtual ~MultiCycleCache();

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
	struct Mode
	{
		enum Enum : uint32_t
		{
			InstrExec = 0,
			PageTableWalk = 1,
		};
	};

	struct Stage
	{
		enum Enum : uint32_t
		{
			InstructionFetch1 = 0,
			InstructionFetch2 = 1,
			Decode = 2,
			Execute = 3,
			Memory1 = 4,
			Memory2 = 5,
			WriteBack = 6
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

	struct MMUException
	{
		enum Enum : uint8_t
		{
			None,
			AccessFault,
			PageFault
		};
	};

	struct MMULookupResult
	{
		word_t m_PhysicalAddress;
		MMUException::Enum m_Exception;
		bool m_Ready;
		bool m_Valid;
		bool m_Cacheable;
	};

	struct ExceptionState
	{
		word_t m_Val;
		uint8_t m_Cause; // 4 bits
		uint8_t m_Enabled; // 1 bit
	};
	
	struct State
	{
		Mode::Enum m_Mode;
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

		word_t m_IFPhysicalAddress;
		word_t m_MemPhysicalAddress;

		// Page table walk mode state
		word_t m_MMUVirtualAddr;
		TLB* m_MMUTLB; // Either ITLB or DTLB (1 bit selection signal)
		MMUException::Enum m_MMULookupException;
		uint32_t m_MMUPTWalkLevel;
	};

	State m_State;
	State m_NextState;

	// Data Cache
	Cache m_DCache;
	MemoryRequest m_DCacheReq; // CPU -> cache
	MemoryResponse m_DCacheRes; // cache -> CPU

	// Instruction Cache
	Cache m_ICache;
	MemoryRequest m_ICacheReq; // CPU -> cache
	MemoryResponse m_ICacheRes; // cache -> CPU

	// Memory Management Unit
	TLB m_ITLB;
	TLB m_DTLB;
	MemoryRequest m_MMUMemReq;
	MemoryResponse m_MMUMemRes;

	// Uncached memory access
	MemoryRequest m_UncachedMemReq;
	MemoryResponse m_UncachedMemRes;

	void stageInstructionFetch1();
	void stageInstructionFetch2();
	void stageDecode();
	void stageExecute();
	void stageMemory1();
	void stageMemory2();
	void stageWriteBack();

	void mmuTranslateAddress(MMULookupResult* res, TLB* tlb, word_t virtualAddress, uint32_t protectionFlags);
	void mmuPageTableWalk();

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
inline void MultiCycleCache::uop_nop(MicroOp* uop)
{
	uop->m_Word = 0;
}

inline void MultiCycleCache::uopRegFile(MicroOp* uop, uint32_t rA, uint32_t rB, uint32_t rD, RegFileDataSrc::Enum dataSrc)
{
	RISCV_CHECK(rA < 32 && rB < 32 && rD < 32 && dataSrc < 8, "Invalid control signals");
	uop->m_Control.m_RegFile_rA = rA;
	uop->m_Control.m_RegFile_rB = rB;
	uop->m_Control.m_RegFile_rD = rD;
	uop->m_Control.m_RegFile_dD_src = dataSrc;
}

inline void MultiCycleCache::uopAddressCalc(MicroOp* uop, AddrCalcSrcA::Enum srcA)
{
	RISCV_CHECK(srcA < 2, "Invalid control signals");
	uop->m_Control.m_AddrCalc_srcA = srcA;
}

inline void MultiCycleCache::uopDataMem(MicroOp* uop, uint32_t sz, bool we)
{
	RISCV_CHECK(sz < 4, "Invalid control signals");
	uop->m_Control.m_DataMem_size = sz;
	uop->m_Control.m_DataMem_we = we ? 1 : 0;
	uop->m_Control.m_DataMem_valid = true;
}

inline void MultiCycleCache::uopALU(MicroOp* uop, ALUASrc::Enum srcA, ALUBSrc::Enum srcB, ALUFunction::Enum func, bool secondaryFunc)
{
	RISCV_CHECK(srcA < 2 && srcB < 2 && func < 8, "Invalid control signals");
	uop->m_Control.m_ALU_srcA = srcA;
	uop->m_Control.m_ALU_srcB = srcB;
	uop->m_Control.m_ALU_func = func;
	uop->m_Control.m_ALU_secFunc = secondaryFunc ? 1 : 0;
}

inline void MultiCycleCache::uopNextPC(MicroOp* uop, NextPCSrc::Enum src)
{
	RISCV_CHECK(src < 4, "Invalid control signals");
	uop->m_Control.m_NextPCSrc = src;
}

inline void MultiCycleCache::uopBreakpoint(MicroOp* uop)
{
	uop->m_Control.m_Breakpoint = 1;
}

inline void MultiCycleCache::uopFlushTLB(MicroOp* uop)
{
	uop->m_Control.m_FlushTLB = 1;
}

inline void MultiCycleCache::uopCSR(MicroOp* uop, uint32_t csr, bool we, CSRDataSrc::Enum src)
{
	RISCV_CHECK(csr < 4096 && src < 8, "Invalid control signals");
	uop->m_Control.m_CSR_id = csr;
	uop->m_Control.m_CSR_we = we ? 1 : 0;
	uop->m_Control.m_CSR_src = src;
}

// Exceptions
inline void MultiCycleCache::raiseException(Exception::Enum cause, word_t val)
{
	m_NextState.m_Exception.m_Enabled = 1;
	m_NextState.m_Exception.m_Cause = (uint8_t)cause;
	m_NextState.m_Exception.m_Val = val;
}

inline void MultiCycleCache::clearException()
{
	m_NextState.m_Exception.m_Enabled = 0;
}

// CSRs
inline void MultiCycleCache::csr64Inc(CSR::Enum csrLow, uint64_t n)
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
}
}

#endif
