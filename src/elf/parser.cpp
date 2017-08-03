#include "parser.h"
#include "../memory.h"
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

void load_segment(const uint8_t* data, const Elf32_Phdr* ph, Memory* memory)
{
	const uint32_t memsize = ph->p_memsz;
	if (memsize == 0) {
		return;
	}

	const uint32_t filesize = ph->p_filesz;
	const uint32_t mempos = ph->p_vaddr;
	const uint32_t filepos = ph->p_offset;
	RISCV_CHECK(mempos < memory->m_Size, "Invalid segment virtual address");
	RISCV_CHECK(mempos + memsize < memory->m_Size, "Invalid segment virtual address");

	bx::memCopy(memVirtualToPhysical(memory, mempos), &data[filepos], filesize);
	bx::memSet(memVirtualToPhysical(memory, mempos + filesize), 0, memsize - filesize);

	memAddRegion(memory, mempos, memsize, ph->p_flags, 0);
}

Info load(const uint8_t* data, Memory* memory)
{
	const Elf32_Ehdr* elf = (const Elf32_Ehdr*)data;
	if (!isELF32(elf->e_ident) || 
		elf->e_type != ET_EXEC ||
		elf->e_machine != EM_RISCV) 
	{
		return { ~0u, ~0u };
	}

	const Elf32_Phdr* ph = (const Elf32_Phdr*)&data[elf->e_phoff];
	for (uint32_t i = 0; i < elf->e_phnum; ++i) {
		if (ph[i].p_type == ELF_PT_LOAD) {
			load_segment(data, &ph[i], memory);
		}
	}
	
	// Find .bss section
	uint32_t initialBreak = ~0u;
	const Elf32_Shdr* sh = (const Elf32_Shdr*)&data[elf->e_shoff];
	const Elf32_Shdr* stringTable = &sh[elf->e_shstrndx];
	const char* stringTableData = (const char*)&data[stringTable->sh_offset];
	for (uint32_t i = 0; i < elf->e_shnum; ++i) {
		const char* name = &stringTableData[sh[i].sh_name];
		if (!strcmp(name, ".bss")) {
			// Zero initialize bss section
			bx::memSet(memVirtualToPhysical(memory, sh[i].sh_addr), 0, sh[i].sh_size);
			initialBreak = sh[i].sh_addr + sh[i].sh_size;

			memAddRegion(memory, sh[i].sh_addr, sh[i].sh_size, RegionFlags::Read | RegionFlags::Write, 0);

			break;
		}
	}

	RISCV_CHECK(initialBreak != ~0u, ".bss section not found or it has and invalid virtual address.");

	Info inf;
	inf.m_EntryPointAddr = elf->e_entry;
	inf.m_InitialBreak = initialBreak;

	return inf;
}
}
