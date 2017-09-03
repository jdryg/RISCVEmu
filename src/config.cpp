#include "config.h"
#include "json/json.h"
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>

void escapeString(const char* src, char* dst)
{
	while (*src) {
		if (*src == '\\') {
			*dst++ = '\\';
		}
		*dst++ = *src++;
	}

	*dst = '\0';
}

void unescapeString(const char* src, uint32_t len, char* dst)
{
	while (*src && len-- > 0) {
		if (src[0] == '\\' && src[1] == '\\') {
			*dst++ = '\\';
			src += 2;
			--len;
			continue;
		}

		*dst++ = *src++;
	}

	*dst = '\0';
}

bool configLoad(Config* cfg, const char* filename)
{
	FILE* f = fopen(filename, "rb");
	if (!f) {
		return false;
	}

	fseek(f, 0, SEEK_END);
	int fileSize = ftell(f);
	fseek(f, 0, SEEK_SET);

	char* buf = (char*)malloc(fileSize + 1);
	fread(buf, fileSize, 1, f);
	buf[fileSize] = '\0';

	fclose(f);

	// Parse the file...
	int read = 0;
	int num = json_num(buf, fileSize);
	json_token* toks = (json_token*)calloc(num, sizeof(json_token));
	if (json_load(toks, num, &read, buf, fileSize) != JSON_OK) {
		free(toks);
		free(buf);
		return false;
	}
	
	json_token* cpuTypeToken = json_query(toks, num, "CPUType");
	json_token* kernelELFToken = json_query(toks, num, "KernelELF");
	json_token* ramSizeToken = json_query(toks, num, "RAMSizeMB");
	json_token* simSpeedToken = json_query(toks, num, "SimSpeed");
	json_token* forceReloadKernelToken = json_query(toks, num, "ForceReloadKernelELF");
	json_token* vhdToken = json_query(toks, num, "VHD");
	json_token* breakOnEBREAKToken = json_query(toks, num, "BreakOnEBREAK");

	if (cpuTypeToken) {
		if (!strncmp(cpuTypeToken->str, "single_cycle", 12)) {
			cfg->m_CPUType = CPUType::SingleCycle;
		} else if (!strncmp(cpuTypeToken->str, "multi_cycle", 11)) {
			cfg->m_CPUType = CPUType::MultiCycle;
		}
	}

	if (kernelELFToken) {
		unescapeString(kernelELFToken->str, kernelELFToken->len, cfg->m_KernelELFFile);
	}
	if (ramSizeToken) {
		cfg->m_RAMSizeMB = atoi(ramSizeToken->str);
	}
	if (simSpeedToken) {
		cfg->m_SimSpeed = atoi(simSpeedToken->str);
	}
	if (forceReloadKernelToken) {
		cfg->m_ForceReloadKernelELF = !strncmp(forceReloadKernelToken->str, "true", 4);
	}
	if (vhdToken) {
		unescapeString(vhdToken->str, vhdToken->len, cfg->m_VHDFile);
	}
	if (breakOnEBREAKToken) {
		cfg->m_BreakOnEBREAK = !strncmp(breakOnEBREAKToken->str, "true", 4);
	}

	free(toks);
	free(buf);

	return true;
}

bool configSave(Config* cfg, const char* filename)
{
	FILE* f = fopen(filename, "w");
	if (!f) {
		return false;
	}

	char kernelFile[256];
	escapeString(cfg->m_KernelELFFile, kernelFile);

	char vhdFile[256];
	escapeString(cfg->m_VHDFile, vhdFile);

	fprintf(f, "{\n");
	fprintf(f, "\t\"CPUType\": \"%s\",\n", cfg->m_CPUType == CPUType::MultiCycle ? "multi_cycle" : "single_cycle");
	fprintf(f, "\t\"KernelELF\": \"%s\",\n", kernelFile);
	fprintf(f, "\t\"SimSpeed\": \"%d\",\n", cfg->m_SimSpeed);
	fprintf(f, "\t\"RAMSizeMB\": \"%d\",\n", cfg->m_RAMSizeMB);
	fprintf(f, "\t\"ForceReloadKernelELF\": \"%s\"\n,", cfg->m_ForceReloadKernelELF ? "true" : "false");
	fprintf(f, "\t\"VHD\": \"%s\"\n,", vhdFile);
	fprintf(f, "\t\"BreakOnEBREAK\": \"%s\"\n", cfg->m_BreakOnEBREAK ? "true" : "false");
	fprintf(f, "}\n");

	fclose(f);

	return true;
}
