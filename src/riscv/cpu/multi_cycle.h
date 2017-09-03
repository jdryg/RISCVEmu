#ifndef RISCV_CPU_MULTI_CYCLE_H
#define RISCV_CPU_MULTI_CYCLE_H

#include "../icpu.h"

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
	virtual void tick(MemoryMap* mm);

	virtual word_t getPC();
	virtual word_t getRegister(uint32_t reg);
	virtual word_t getCSR(uint32_t csr);
	virtual dword_t getCSR64(uint32_t csrLow);
	virtual word_t getOutputPin(OutputPin::Enum pin);
	virtual bool getMemWord(MemoryMap* mm, word_t addr, word_t& data);
};
}
}

#endif
