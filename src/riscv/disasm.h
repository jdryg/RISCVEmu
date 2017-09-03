#ifndef RISCV_DISASM_H
#define RISCV_DISASM_H

#include <stdint.h>

namespace riscv
{
class ICPU;
struct MemoryMap;

void disasmInstruction(uint32_t instr, uint32_t addr, char* buf, uint32_t len);
void disasmGetInstrOperandValues(ICPU* cpu, MemoryMap* mem, uint32_t instr, uint32_t addr, char* str, uint32_t len);
const char* disasmGetRegisterABIName(uint32_t reg);
}

#endif
