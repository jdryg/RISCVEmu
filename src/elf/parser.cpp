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

uint32_t load(const uint8_t* data, uint32_t baseAddr, riscv::MemoryMap* mm)
{
	const Elf32_Ehdr* elf = (const Elf32_Ehdr*)data;
	if (!isELF32(elf->e_ident) || 
		elf->e_type != ET_EXEC ||
		elf->e_machine != EM_RISCV) 
	{
		return ~0u;
	}

	// Collect all program headers with data in a single, continuous memory block (the ROM).
	// NOTE: Assumes program headers are in ascending order wrt physical addresses.
	uint32_t romSize = 0;
	uint8_t* romData = nullptr;
	const Elf32_Phdr* ph = (const Elf32_Phdr*)&data[elf->e_phoff];
	for (uint32_t i = 0; i < elf->e_phnum; ++i) {
		const Elf32_Phdr* curHeader = &ph[i];
		if (curHeader->p_type == ELF_PT_LOAD) {
			if (curHeader->p_paddr > romSize) {
				const uint32_t emptySpace = curHeader->p_paddr - romSize;
				romData = (uint8_t*)realloc(romData, romSize + emptySpace);
				bx::memSet(&romData[romSize], 0, emptySpace);
				romSize += emptySpace;
			}

			const uint32_t dataSize = curHeader->p_filesz;
			const uint8_t* headerData = &data[curHeader->p_offset];
			romData = (uint8_t*)realloc(romData, romSize + dataSize);
			bx::memCopy(&romData[romSize], headerData, dataSize);
			romSize += dataSize;
		}
	}

	// Make sure the ROM size is a multiply of the page size.
	if ((romSize & 4095) != 0) {
		romSize = (romSize & 0xFFFFFC00) + 4096;
		romData = (uint8_t*)realloc(romData, romSize);
	}

	// Create the ROM
	riscv::Device* rom = riscv::device::romCreate(romSize, romData, romSize);
	riscv::mmMapDevice(mm, rom, baseAddr, romSize);

	// Create all RAM sections (should be only 1).
	ph = (const Elf32_Phdr*)&data[elf->e_phoff];
	for (uint32_t i = 0; i < elf->e_phnum; ++i) {
		if ((ph[i].p_type == ELF_PT_LOAD) && (ph[i].p_flags & PF_W)) {
			const uint32_t memSize = ph[i].p_memsz;
			if (memSize == 0) {
				continue;
			}

			riscv::Device* ram = riscv::device::ramCreate(memSize);
			riscv::mmMapDevice(mm, ram, baseAddr + ph[i].p_vaddr, memSize);
		}
	}
	
	return elf->e_entry;
}
}
