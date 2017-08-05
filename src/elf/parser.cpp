#include "parser.h"
#include "../riscv/memory_map.h"
#include "../debug.h"
#include <string.h>
#include <bx/bx.h>

namespace elf
{
bool isELF32(const uint8_t* ident)
{
	if (ident[EI_MAG0] != ELFMAG0 ||
		ident[EI_MAG1] != ELFMAG1 ||
		ident[EI_MAG2] != ELFMAG2 ||
		ident[EI_MAG3] != ELFMAG3)
	{
		return false;
	}

	if (ident[EI_CLASS] != ELFCLASS32) {
		return false;
	}
	
	return true;
}

void load_segment(const uint8_t* data, const Elf32_Phdr* ph, riscv::MemoryMap* mm, uint32_t baseAddr)
{
	const uint32_t memsize = ph->p_memsz;
	if (memsize == 0) {
		return;
	}

	const uint32_t filesize = ph->p_filesz;
	const uint32_t mempos = ph->p_vaddr;
	const uint32_t filepos = ph->p_offset;

	if (ph->p_flags & PF_W) {
		riscv::Device* ram = riscv::device::ramCreate(memsize);
		riscv::mmMapDevice(mm, ram, baseAddr + mempos, memsize);
	} else {
		riscv::Device* rom = riscv::device::romCreate(memsize, &data[filepos], filesize);
		riscv::mmMapDevice(mm, rom, baseAddr + mempos, memsize);
	}
}

uint32_t load(const uint8_t* data, uint32_t baseAddr, riscv::MemoryMap* mm)
{
	const Elf32_Ehdr* elf = (const Elf32_Ehdr*)data;
	if (!isELF32(elf->e_ident) || 
		elf->e_type != ET_EXEC ||
		elf->e_machine != EM_RISCV) 
	{
		return ~0u;
	}

	const Elf32_Phdr* ph = (const Elf32_Phdr*)&data[elf->e_phoff];
	for (uint32_t i = 0; i < elf->e_phnum; ++i) {
		if (ph[i].p_type == ELF_PT_LOAD) {
			load_segment(data, &ph[i], mm, baseAddr);
		}
	}
	
	return elf->e_entry;
}
}
