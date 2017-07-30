#ifndef ELF_PARSER_H
#define ELF_PARSER_H

#include <stdint.h>

struct Memory;

namespace elf
{
// Structs from: http://manpages.courier-mta.org/htmlman5/elf.5.html
// Initial code from: http://www.thomasloven.com/blog/2013/08/Loading-Elf/
// Values from: https://github.com/torvalds/linux/blob/master/include/uapi/linux/elf.h
#define EI_MAG0     0
#define EI_MAG1     1
#define EI_MAG2     2
#define EI_MAG3     3
#define	EI_CLASS	4

#define	ELFMAG0		0x7f		/* EI_MAG */
#define	ELFMAG1		'E'
#define	ELFMAG2		'L'
#define	ELFMAG3		'F'

#define	ELFCLASS32	1

#define ET_EXEC     2

#define EM_RISCV    243

#define ELF_PT_LOAD 1

#define EI_NIDENT   16

#pragma pack(push, 1)
struct Elf32_Ehdr
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
};
#pragma pack(pop)

#pragma pack(push, 1)
struct Elf32_Phdr
{
	uint32_t p_type;
	uint32_t p_offset;
	uint32_t p_vaddr;
	uint32_t p_paddr;
	uint32_t p_filesz;
	uint32_t p_memsz;
	uint32_t p_flags;
	uint32_t p_align;
};
#pragma pack(pop)

#pragma pack(push, 1)
struct Elf32_Shdr
{
	uint32_t sh_name;
	uint32_t sh_type;
	uint32_t sh_flags;
	uint32_t sh_addr;
	uint32_t sh_offset;
	uint32_t sh_size;
	uint32_t sh_link;
	uint32_t sh_info;
	uint32_t sh_addralign;
	uint32_t sh_entsize;
};
#pragma pack(pop)

struct Info
{
	uint32_t m_EntryPointAddr;
	uint32_t m_InitialBreak;
};

bool isELF32(const uint8_t* ident);
Info load(const uint8_t* data, Memory* mem);
}

#endif
