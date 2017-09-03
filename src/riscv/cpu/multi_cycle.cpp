#include "multi_cycle.h"

namespace riscv
{
namespace cpu
{
MultiCycle::MultiCycle()
{
}

MultiCycle::~MultiCycle()
{
}

void MultiCycle::reset(word_t pc)
{

}

void MultiCycle::tick(MemoryMap* mm)
{

}

word_t MultiCycle::getPC()
{
	return 0;
}

word_t MultiCycle::getRegister(uint32_t reg)
{
	return 0;
}

word_t MultiCycle::getCSR(uint32_t csr)
{
	return 0;
}

dword_t MultiCycle::getCSR64(uint32_t csrLow)
{
	return 0;
}

word_t MultiCycle::getOutputPin(OutputPin::Enum pin)
{
	return 0;
}

bool MultiCycle::getMemWord(MemoryMap* mm, word_t addr, word_t& data)
{
	return false;
}
} // namespace cpu
} // namespace riscv