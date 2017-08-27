#include "elf.h"

int elfIsRISCV32(const Elf32_Ehdr* hdr)
{
    const uint8_t* ident = hdr->e_ident;
    if (ident[EI_MAG0] != ELFMAG0 ||
		ident[EI_MAG1] != ELFMAG1 ||
		ident[EI_MAG2] != ELFMAG2 ||
		ident[EI_MAG3] != ELFMAG3)
	{
		return 0;
	}

	if (ident[EI_CLASS] != ELFCLASS32) {
		return 0;
    }

    return (hdr->e_type == ET_EXEC && hdr->e_machine == EM_RISCV);
}
