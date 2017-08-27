#ifndef LIBKERNEL_INTERNAL_ELF_H
#define LIBKERNEL_INTERNAL_ELF_H

#include <stdint.h>

#define EI_MAG0     0
#define EI_MAG1     1
#define EI_MAG2     2
#define EI_MAG3     3
#define	EI_CLASS    4

#define	ELFMAG0	    0x7f		/* EI_MAG */
#define	ELFMAG1	    'E'
#define	ELFMAG2	    'L'
#define	ELFMAG3	    'F'

#define	ELFCLASS32  1

#define ET_EXEC     2

#define EM_RISCV    243

#define EI_NIDENT   16

#define PT_LOAD     1

#define PF_R        0x4
#define PF_W        0x2
#define PF_X        0x1

#define PF_R_SHIFT  2
#define PF_W_SHIFT  1
#define PF_X_SHIFT  0

typedef struct Elf32_Ehdr
{
	uint8_t e_ident[EI_NIDENT];
	uint16_t e_type;
	uint16_t e_machine;
	uint32_t e_version;
	uint32_t e_entry;
	uint32_t e_phoff;
	uint32_t e_shoff;
	uint32_t e_flags;
	uint16_t e_ehsize;
	uint16_t e_phentsize;
	uint16_t e_phnum;
	uint16_t e_shentsize;
	uint16_t e_shnum;
	uint16_t e_shstrndx;
} __attribute__((packed)) Elf32_Ehdr;

typedef struct Elf32_Phdr
{
	uint32_t p_type;
	uint32_t p_offset;
	uint32_t p_vaddr;
	uint32_t p_paddr;
	uint32_t p_filesz;
	uint32_t p_memsz;
	uint32_t p_flags;
	uint32_t p_align;
} __attribute__((packed)) Elf32_Phdr;

int elfIsRISCV32(const Elf32_Ehdr* hdr);

#endif
