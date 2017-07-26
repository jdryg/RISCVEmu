#ifndef ELF_PARSER_H
#define ELF_PARSER_H

#include <stdint.h>

namespace elf
{
#pragma pack(push, 1)
struct header
{
	uint8_t identity[16];
	uint16_t type;
	uint16_t machine;
	uint32_t version;
	uint32_t entry;
	uint32_t ph_offset;
	uint32_t sh_offset;
	uint32_t flags;
	uint16_t header_size;
	uint16_t ph_size;
	uint16_t ph_num;
	uint16_t sh_size;
	uint16_t sh_num;
	uint16_t strtab_index;
};
#pragma pack(pop)

#pragma pack(push, 1)
struct phead
{
	uint32_t type;
	uint32_t offset;
	uint32_t virtual_address;
	uint32_t physical_address;
	uint32_t file_size;
	uint32_t mem_size;
	uint32_t flags;
	uint32_t align;
};
#pragma pack(pop)

uint32_t load(const uint8_t* data, uint8_t* mem, uint32_t memSize);
}

#endif
