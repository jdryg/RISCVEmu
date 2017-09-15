#ifndef RISCV_MEMORY_MAP_H
#define RISCV_MEMORY_MAP_H

#include <stdint.h>

namespace riscv
{
struct MemoryMap;

struct Device
{
	uint32_t m_Flags;

	bool (*read)(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t& val);
	bool (*write)(Device* dev, uint32_t relAddr, uint32_t byteMask, uint32_t val);
	uint32_t (*get)(Device* dev, uint32_t relAddr, uint32_t byteMask); // Non-destructive read (see uartRead/uartGet for an example)
};

struct MemoryRequest
{
	uint32_t m_Addr;
	uint32_t m_Data; // Used for writes

	union Control
	{
		uint8_t m_Word;

		struct Fields
		{
			uint8_t m_Size : 2; // 0 = 1 byte, 1 = 2 bytes, 2 = 4 bytes
			uint8_t m_WriteEnable : 1; // false = Read, true = Write
			uint8_t m_Valid : 1; // Is this a valid request?
		} m_Fields;
	} m_Control;
};

struct MemoryResponse
{
	uint32_t m_Data; // Valid for Read requests. Undefined for Write requests.

	union Control
	{
		uint8_t m_Word;

		struct Fields
		{
			uint8_t m_Valid : 1; // Was the specified address a valid one?
			uint8_t m_Ready : 1; // Has the request been processed?
		} m_Fields;
	} m_Control;
};

MemoryMap* mmCreate();
void mmDestroy(MemoryMap* mm);

void mmMapDevice(MemoryMap* mm, Device* dev, uint32_t baseAddr, uint32_t size);
uint32_t mmGetDeviceBaseAddr(const MemoryMap* mm, uint32_t id);
uint32_t mmGetNumDevices(const MemoryMap* mm);
Device* mmGetDeviceByID(MemoryMap* mm, uint32_t id);

bool mmRead(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val);
bool mmWrite(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t val);
bool mmGet(MemoryMap* mm, uint32_t addr, uint32_t byteMask, uint32_t& val);

MemoryResponse mmRequest(MemoryMap* mm, const MemoryRequest& req);

namespace device
{
const uint32_t kUARTMemorySize = sizeof(uint32_t) * 3; // NOTE: 3 == UART_NUM_REGS in .cpp
const uint32_t kVHDMemorySize = sizeof(uint32_t) * 8; // NOTE: 8 == VHD_NUM_REGS in .cpp

void destroy(Device* dev);

bool isMemory(const Device* dev);
uint32_t memGetSize(const Device* dev);
uint8_t* memGetDataPtr(Device* dev);
bool memIsReadOnly(const Device* dev);

Device* ramCreate(uint32_t size);
Device* romCreate(uint32_t size, const uint8_t* data, uint32_t dataSize);
Device* uartCreate();
bool uartTransmit(Device* dev, uint8_t& data);
bool uartReceive(Device* dev, uint8_t data);

Device* vhdCreate(const char* filename);
}
}

#endif
