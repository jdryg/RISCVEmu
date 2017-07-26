// http://www.thomasloven.com/blog/2013/08/Loading-Elf/
#include "parser.h"
#include <string.h>
#include <assert.h>

namespace elf
{
#define ELF_TYPE_EXECUTABLE 2
#define ELF_PT_LOAD 1

int isELF(const header* elf)
{
    int iself = -1;

    if ((elf->identity[0] == 0x7f) && !strncmp((char *)&elf->identity[1], "ELF", 3)) {
        iself = 0;
    }

	if (iself != -1) {
		iself = elf->type;
	}

    return iself;
}

void load_segment(const uint8_t* data, const phead* ph, uint8_t* mem, uint32_t memSize)
{

	uint32_t memsize = ph->mem_size;
	uint32_t filesize = ph->file_size;
	uint32_t mempos = ph->virtual_address;
	uint32_t filepos = ph->offset;

	if (memsize == 0) {
		return;
	}

	assert(mempos < memSize);
	assert(mempos + memsize < memSize);

	memcpy(&mem[mempos], &data[filepos], filesize);
	memset(&mem[mempos + filesize], 0, memsize - filesize);
}

uint32_t load(const uint8_t* data, uint8_t* mem, uint32_t memSize)
{
	const header* elf = (const header*)data;
	if (isELF(elf) != ELF_TYPE_EXECUTABLE) {
		return ~0u;
	}

	const phead* ph = (const phead*)&data[elf->ph_offset];
	for (uint32_t i = 0; i < elf->ph_num; i++) {
		if (ph[i].type == ELF_PT_LOAD) {
			load_segment(data, &ph[i], mem, memSize);
		}
	}

	return elf->entry;
}
}