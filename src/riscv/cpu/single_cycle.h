#ifndef RISCV_CPU_SINGLE_CYCLE_H
#define RISCV_CPU_SINGLE_CYCLE_H

#include "../icpu.h"
#include "../tlb.h"

namespace riscv
{
namespace cpu
{
class SingleCycle : public ICPU
{
public:
	SingleCycle();
	virtual ~SingleCycle();

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
	struct State
	{
		// User-visible integer state
		word_t m_IRegs[32];
		word_t m_PC;

		// Control and Status Registers (CSRs)
		word_t m_CSR[4096]; // NOTE: Only a handful of CSRs are defined/used but lets have them all :)

		PrivLevel::Enum m_PrivLevel;

		// Outputs
		bool m_Breakpoint; // Was the last executed instruction an EBREAK?
	};

	State m_State;
	State m_NextState;
	TLB m_ITLB;
	TLB m_DTLB;

	word_t readReg(uint32_t reg);
	void writeReg(uint32_t reg, word_t val);

	word_t readCSR(uint32_t csr);
	void writeCSR(uint32_t csr, word_t val);

	void raiseException(Exception::Enum exception);
	void returnFromException();

	void pageTableWalk(MemoryMap* mm, TLB* tlb, uint32_t satp, uint32_t vpn, bool read, bool write, bool execute, bool isStore);
	bool memRead(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t& data, bool isInstruction);
	bool memWrite(MemoryMap* mm, TLB* tlb, uint32_t virtualAddress, uint32_t byteMask, uint32_t data);
};

//////////////////////////////////////////////////////////////////////////
// Inline functions...
//
inline word_t SingleCycle::readReg(uint32_t reg)
{
	return m_State.m_IRegs[reg];
}

inline void SingleCycle::writeReg(uint32_t reg, word_t val)
{
	if (reg != 0) {
		m_NextState.m_IRegs[reg] = val;
	}
}
} // namespace cpu
} // namespace riscv

#endif
