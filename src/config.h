#ifndef CONFIG_H
#define CONFIG_H

#include <stdint.h>

struct CPUType
{
	enum Enum : uint32_t
	{
		SingleCycle = 0,
		MultiCycle
	};
};

struct Config
{
	int m_CPUType;
	char m_KernelELFFile[256];
	char m_VHDFile[256];
	int m_RAMSizeMB;
	int m_SimSpeed;
	bool m_ForceReloadKernelELF;
	bool m_BreakOnEBREAK;
};

bool configLoad(Config* cfg, const char* filename);
bool configSave(Config* cfg, const char* filename);

#endif
