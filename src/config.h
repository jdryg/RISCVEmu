#ifndef CONFIG_H
#define CONFIG_H

struct Config
{
	char m_KernelELFFile[256];
	char m_VHDFile[256];
	int m_RAMSizeMB;
	int m_SimSpeed;
	bool m_ForceReloadKernelELF;
};

bool configLoad(Config* cfg, const char* filename);
bool configSave(Config* cfg, const char* filename);

#endif
