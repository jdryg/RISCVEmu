#include "elf/parser.h"
#include "riscv/icpu.h"
#include "riscv/cpu/single_cycle.h"
#include "riscv/memory_map.h"
#include "riscv/disasm.h"
#include "console.h"
#include "debugger.h"
#include "debug.h"
#include "config.h"

#include <nfd/nfd.h>
#include <bx/string.h>
#include <bx/math.h>
#include <bx/uint32_t.h>

#define IMGUI_INCLUDE_IMGUI_USER_H
#include "imgui/imgui.h"
#include "imgui/IconsFontAwesome.h"
#include "imgui_impl_glfw.h"
#include <GLFW/glfw3.h>

#include <stdint.h>
#include <stdio.h>
#include <malloc.h>
#include <memory.h>

#define ENABLE_TRACING         0

#define MAX_STDIN_BUFFER       256

#define CONSOLE_COLS           80
#define CONSOLE_ROWS           25

#define INIT_ERR_SUCCESS       0
#define INIT_ERR_NO_MEMORY     1
#define INIT_ERR_INVALID_ELF   2

#define UI_WIN_SETUP           0x00000001
#define UI_WIN_DEBUG           0x00000002
#define UI_WIN_REGISTERS       0x00000004
#define UI_WIN_BREAKPOINTS     0x00000008
#define UI_WIN_TERMINAL        0x00000010
#define UI_WIN_PERF_COUNTERS   0x00000020
#define UI_WIN_MEMORY_EDITOR   0x00000040

#define KERNEL_BASE_ADDR       0x00000000 // BIOS or Kernel? This is the code that runs in M-mode with no address translation for memory accesses.
#define RAM_BASE_ADDR          0x00100000
#define CONSOLE_UART_BASE_ADDR 0x80000000
#define HDD_BASE_ADDR          0x80001000

struct MemoryDeviceDesc
{
	uint8_t* m_DataPtr;
	uint32_t m_BaseAddr;
	uint32_t m_Size;
	bool m_IsReadOnly;
};

struct App
{
	Config m_Config;
	GLFWwindow* m_GLFWWindow;
	riscv::ICPU* m_CPU;
	riscv::MemoryMap* m_MemoryMap;
	riscv::Device* m_ConsoleUART;
	Console* m_Console;
	Debugger* m_Dbg;
	MemoryDeviceDesc* m_MemoryDevices;
	uint32_t m_NumMemoryDevices;

	uint8_t* m_KernelELFData;
	uint32_t m_KernelELFSize;
	int m_InitError;
	bool m_ScrollToPC;
	uint32_t m_NumCPUSteps;
	bool m_Run;

	MemoryEditor m_MemoryEditor;
	int m_SelectedMemDevice;
	char* m_MemDevicesComboStr;
	ImFont* m_MonoFont;
	char m_StdInBuffer[MAX_STDIN_BUFFER];
	uint32_t m_WinVis;

#if ENABLE_TRACING
	uint32_t* m_CPUTrace;
	uint32_t m_NumCPUTraces;
	uint32_t m_CPUTraceCapacity;
#endif

	App(uint32_t visibleWindows)
		: m_GLFWWindow(nullptr)
		, m_CPU(nullptr)
		, m_MemoryMap(nullptr)
		, m_Dbg(nullptr)
		, m_WinVis(visibleWindows)
		, m_KernelELFData(nullptr)
		, m_KernelELFSize(0)
		, m_InitError(INIT_ERR_SUCCESS)
		, m_ScrollToPC(true)
		, m_NumCPUSteps(0)
		, m_Run(false)
		, m_MonoFont(nullptr)
		, m_ConsoleUART(nullptr)
		, m_Console(nullptr)
		, m_MemoryDevices(nullptr)
		, m_NumMemoryDevices(0)
		, m_SelectedMemDevice(-1)
		, m_MemDevicesComboStr(nullptr)
#if ENABLE_TRACING
		, m_CPUTrace(nullptr)
		, m_NumCPUTraces(0)
		, m_CPUTraceCapacity(0)
#endif
	{
		bx::memSet(m_StdInBuffer, 0, sizeof(char) * MAX_STDIN_BUFFER);
		m_Config.m_ForceReloadKernelELF = false;
		m_Config.m_KernelELFFile[0] = '\0';
		m_Config.m_VHDFile[0] = '\0';
		m_Config.m_RAMSizeMB = 4;
		m_Config.m_SimSpeed = 1000;
		m_Config.m_BreakOnEBREAK = true;
	}

	~App()
	{}
};

#if ENABLE_TRACING
void tracePush(App* app, uint32_t pc)
{
	if (app->m_NumCPUTraces + 1 > app->m_CPUTraceCapacity) {
		app->m_CPUTraceCapacity = app->m_CPUTraceCapacity ? (app->m_CPUTraceCapacity * 3) / 2 : 256;
		app->m_CPUTrace = (uint32_t*)realloc(app->m_CPUTrace, sizeof(uint32_t) * app->m_CPUTraceCapacity);
	}

	app->m_CPUTrace[app->m_NumCPUTraces++] = pc;
}
#endif

uint8_t* readFile(const char* filename, uint32_t& fileSize)
{
	FILE* f = fopen(filename, "rb");
	if (!f) {
		return nullptr;
	}

	fseek(f, 0, SEEK_END);
	fileSize = (uint32_t)ftell(f);
	fseek(f, 0, SEEK_SET);

	uint8_t* data = (uint8_t*)malloc(fileSize);
	if (!data) {
		return nullptr;
	}

	fread(data, sizeof(uint8_t), fileSize, f);

	fclose(f);

	return data;
}

int initEmulator(App* app)
{
	const uint32_t ramSize = (uint32_t)app->m_Config.m_RAMSizeMB << 20;

	// Create memory map
	riscv::MemoryMap* mm = riscv::mmCreate();

	// Load kernel into memory
	uint32_t entryPointAddr = elf::load(app->m_KernelELFData, KERNEL_BASE_ADDR, mm);
	if (entryPointAddr == ~0u) {
		return INIT_ERR_INVALID_ELF;
	}

	// Create devices
	riscv::Device* ram = riscv::device::ramCreate(ramSize);
	if (!ram) {
		return INIT_ERR_NO_MEMORY;
	}
	riscv::mmMapDevice(mm, ram, RAM_BASE_ADDR, ramSize);

	riscv::Device* consoleUART = riscv::device::uartCreate();
	if (!consoleUART) {
		return INIT_ERR_NO_MEMORY;
	}
	riscv::mmMapDevice(mm, consoleUART, CONSOLE_UART_BASE_ADDR, riscv::device::kUARTMemorySize);

	riscv::Device* hdd = riscv::device::vhdCreate(app->m_Config.m_VHDFile);
	if (hdd) {
		riscv::mmMapDevice(mm, hdd, HDD_BASE_ADDR, riscv::device::kVHDMemorySize);
	}

	// Initialize CPU
	riscv::ICPU* cpu = new riscv::cpu::SingleCycle();
	cpu->reset(entryPointAddr);

	// Initialize app
	app->m_CPU = cpu;
	app->m_MemoryMap = mm;
	app->m_ConsoleUART = consoleUART;
	app->m_Console = consoleCreate(CONSOLE_COLS, CONSOLE_ROWS);
	app->m_Dbg = dbgCreate();
	app->m_ScrollToPC = true;
	app->m_Run = false;
	app->m_NumCPUSteps = 0;

	// Scan memory map for memory devices
	uint32_t numMemDevices = 0;
	const uint32_t numDevices = riscv::mmGetNumDevices(mm);
	for (uint32_t i = 0; i < numDevices; ++i) {
		riscv::Device* dev = riscv::mmGetDeviceByID(mm, i);
		RISCV_CHECK(dev != nullptr, "Invalid device returned by MemoryMap");
		if (riscv::device::isMemory(dev)) {
			++numMemDevices;
		}
	}

	app->m_MemoryDevices = (MemoryDeviceDesc*)malloc(sizeof(MemoryDeviceDesc) * numMemDevices);
	char* memDevicesStr = (char*)malloc(numMemDevices * 256);
	char* dst = memDevicesStr;

	// TODO: Sort devices by base address.
	uint32_t nextMemDeviceID = 0;
	for (uint32_t i = 0; i < numDevices; ++i) {
		riscv::Device* dev = riscv::mmGetDeviceByID(mm, i);
		if (riscv::device::isMemory(dev)) {
			MemoryDeviceDesc* desc = &app->m_MemoryDevices[nextMemDeviceID++];
			desc->m_BaseAddr = riscv::mmGetDeviceBaseAddr(mm, i);
			desc->m_DataPtr = riscv::device::memGetDataPtr(dev);
			desc->m_Size = riscv::device::memGetSize(dev);
			desc->m_IsReadOnly = riscv::device::memIsReadOnly(dev);

			char str[256];
			bx::snprintf(str, 255, "%s [0x%08X - 0x%08X]", desc->m_IsReadOnly ? "ROM" : "RAM", desc->m_BaseAddr, desc->m_BaseAddr + desc->m_Size - 1);
			
			uint32_t len = bx::strLen(str);
			memcpy(dst, str, len + 1);
			dst += len + 1;
		}
	}

	app->m_NumMemoryDevices = numMemDevices;

	uint32_t len = (uint32_t)(dst - memDevicesStr);
	app->m_MemDevicesComboStr = (char*)malloc(len + 2);
	memcpy(app->m_MemDevicesComboStr, memDevicesStr, len);
	app->m_MemDevicesComboStr[len] = '\0';
	app->m_MemDevicesComboStr[len + 1] = '\0';
	free(memDevicesStr);

	app->m_SelectedMemDevice = 0;

	app->m_MemoryEditor.OptAddrDigitsCount = 8;

	return INIT_ERR_SUCCESS;
}

void shutdownEmulator(App* app)
{
	delete app->m_CPU;
	app->m_CPU = nullptr;

	free(app->m_MemoryDevices);
	app->m_MemoryDevices = nullptr;
	app->m_NumMemoryDevices = 0;

	free(app->m_MemDevicesComboStr);
	app->m_MemDevicesComboStr = nullptr;
	app->m_SelectedMemDevice = -1;

	app->m_ConsoleUART = nullptr; // Will be destroyed in mmDestroy()

	riscv::mmDestroy(app->m_MemoryMap);
	app->m_MemoryMap = nullptr;

	dbgDestroy(app->m_Dbg);
	app->m_Dbg = nullptr;
}

void doMainMenu(App* app)
{
	if (ImGui::BeginMainMenuBar()) {
		if (ImGui::BeginMenu("File")) {
			if (ImGui::MenuItem("Exit", nullptr)) {
				glfwSetWindowShouldClose(app->m_GLFWWindow, 1);
			}

			ImGui::EndMenu();
		}

		if (ImGui::BeginMenu("Windows")) {
			if (ImGui::MenuItem("Setup", nullptr)) {
				app->m_WinVis |= UI_WIN_SETUP;
			}
			if (ImGui::MenuItem("Debugger", nullptr)) {
				app->m_WinVis |= UI_WIN_DEBUG;
			}
			if (ImGui::MenuItem("Registers", nullptr)) {
				app->m_WinVis |= UI_WIN_REGISTERS;
			}
			if (ImGui::MenuItem("Breakpoints", nullptr)) {
				app->m_WinVis |= UI_WIN_BREAKPOINTS;
			}
			if (ImGui::MenuItem("Terminal", nullptr)) {
				app->m_WinVis |= UI_WIN_TERMINAL;
			}
			if (ImGui::MenuItem("Perf Counters", nullptr)) {
				app->m_WinVis |= UI_WIN_PERF_COUNTERS;
			}
			if (ImGui::MenuItem("Memory Editor", nullptr)) {
				app->m_WinVis |= UI_WIN_MEMORY_EDITOR;
			}

			ImGui::EndMenu();
		}

		ImGui::EndMainMenuBar();
	}
}

void doWin_Setup_ELFFile(const char* str_id, char* filename, uint32_t len, uint8_t*& elfData, uint32_t& elfSize, bool editable)
{
	ImGui::PushID(str_id);

	ImGui::InputTextEx("##ELF", filename, len, editable ? ImVec2(-30.0f, 0.0f) : ImVec2(-1.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);

	if (editable) {
		ImGui::SameLine();
		if (ImGui::Button(ICON_FA_FOLDER_OPEN)) {
			nfdchar_t* outPath = nullptr;
			nfdresult_t result = NFD_OpenDialog(nullptr, nullptr, &outPath);
			if (result == NFD_OKAY) {
				bx::snprintf(filename, len, "%s", outPath);

				elfData = readFile(outPath, elfSize);

				free(outPath);
			}
		}
	}

	if (!elfData) {
		ImGui::Text("No ELF loaded yet.");
	} else {
		elf::Elf32_Ehdr* header = (elf::Elf32_Ehdr*)elfData;
		if (!elf::isELF32(header->e_ident)) {
			ImGui::Text("Loaded file is not a valid 32-bit ELF file.");
		} else {
			ImGui::Text("Type: %u", header->e_type);
			ImGui::Text("Machine: %u", header->e_machine);
			ImGui::Text("Version: %u", header->e_version);
			ImGui::Text("Entry: %08Xh", header->e_entry);
			ImGui::Text("Flags: %08Xh", header->e_flags);

			// TODO: Show program/section headers
			if (ImGui::TreeNode("Program headers")) {
				ImGui::Text("Not implemented yet.");
				ImGui::TreePop();
			}
			if (ImGui::TreeNode("Section headers")) {
				ImGui::Text("Not implemented yet.");
				ImGui::TreePop();
			}
		}
	}

	ImGui::PopID();
}

void doWin_Setup(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(350, 420), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_SETUP) != 0;
	if (ImGui::BeginDock("Setup", &opened, 0)) {
		if (!app->m_CPU) {
			if (ImGui::CollapsingHeader("System configuration", ImGuiTreeNodeFlags_DefaultOpen)) {
				ImGui::PushItemWidth(-60.0f);
				ImGui::SliderInt("RAM [MB]", &app->m_Config.m_RAMSizeMB, 1, 16);

				ImGui::InputTextEx("VHD", &app->m_Config.m_VHDFile[0], BX_COUNTOF(app->m_Config.m_VHDFile), ImVec2(-60.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);
				ImGui::SameLine();
				if (ImGui::Button(ICON_FA_FOLDER_OPEN)) {
					nfdchar_t* outPath = nullptr;
					nfdresult_t result = NFD_OpenDialog("vhd", nullptr, &outPath);
					if (result == NFD_OKAY) {
						bx::snprintf(app->m_Config.m_VHDFile, BX_COUNTOF(app->m_Config.m_VHDFile), "%s", outPath);
						free(outPath);
					}
				}
			}
		}

		if (ImGui::CollapsingHeader("Kernel/BIOS", ImGuiTreeNodeFlags_DefaultOpen)) {
			doWin_Setup_ELFFile("##kernel", &app->m_Config.m_KernelELFFile[0], BX_COUNTOF(app->m_Config.m_KernelELFFile), app->m_KernelELFData, app->m_KernelELFSize, !app->m_CPU);
		}

		if (app->m_CPU) {
			ImGui::Text("Emulator is currently running.");
			if (ImGui::Button("Stop")) {
				shutdownEmulator(app);
			}
			ImGui::SameLine();
			if (ImGui::Button("Restart")) {
				shutdownEmulator(app);
				initEmulator(app);
			}
		} else {
			if (app->m_KernelELFData) {
				if (ImGui::Button("Start", ImVec2(-1, 0))) {
					app->m_InitError = initEmulator(app);
				}
				if (app->m_InitError != INIT_ERR_SUCCESS) {
					ImGui::Text("Init Error %d", app->m_InitError);
				}
			}
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_SETUP;
	} else {
		app->m_WinVis |= UI_WIN_SETUP;
	}
}

void doWin_Debugger(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(780, 700), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(350, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_DEBUG) != 0;
	if (ImGui::BeginDock("Debugger", &opened, 0)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			if (app->m_Run) {
				if (ImGui::Button(ICON_FA_STOP)) {
					app->m_NumCPUSteps = 0;
					app->m_Run = false;
				}
				if (ImGui::IsItemHovered()) {
					ImGui::SetTooltip("Break");
				}
			} else {
				if (ImGui::Button(ICON_FA_PLAY)) {
					app->m_NumCPUSteps = app->m_Config.m_SimSpeed;
					app->m_Run = true;
				}
				if (ImGui::IsItemHovered()) {
					ImGui::SetTooltip("Run");
				}

				ImGui::SameLine();
				if (ImGui::Button(ICON_FA_STEP_FORWARD)) {
					app->m_NumCPUSteps = 1;
				}
				if (ImGui::IsItemHovered()) {
					ImGui::SetTooltip("Step x1");
				}

				ImGui::SameLine();
				if (ImGui::Button(ICON_FA_FAST_FORWARD)) {
					app->m_NumCPUSteps = 100;
				}
				if (ImGui::IsItemHovered()) {
					ImGui::SetTooltip("Step x100");
				}

				ImGui::SameLine();
				ImGui::PushItemWidth(-80.0f);
				ImGui::DragInt("Ticks/frame", &app->m_Config.m_SimSpeed, 1.0f, 1, 10000);

				if (ImGui::Button("Go to PC")) {
					app->m_ScrollToPC = true;
				}
			}

			const float lineHeight = ImGui::GetTextLineHeightWithSpacing();

			// TODO: Change scrolling to be able to see the whole address space.
			const uint32_t ramSize = 1 << 20;
			const uint32_t numWords = ramSize / 4;
			const uint32_t pc = app->m_CPU->getPC();

			static float infoRegionHeight = 80.0f;
			ImGui::SetNextWindowContentSize(ImVec2(0.0f, numWords * lineHeight));
			if (ImGui::BeginChild("##disasm", ImVec2(-1, -infoRegionHeight), true)) {
				const float winHeight = ImGui::GetWindowHeight();
				const uint32_t numLinesVisible = (uint32_t)bx::ffloor(winHeight / lineHeight);

				const float scrollY = ImGui::GetScrollY();
				float newScrollY = scrollY;
				uint32_t scrollAddr = 4 * (uint32_t)bx::ffloor(scrollY / lineHeight);
				uint32_t minAddr = scrollAddr;
				uint32_t maxAddr = bx::uint32_min(scrollAddr + numLinesVisible * 4, ramSize - 4);
				if (app->m_ScrollToPC && (pc <= minAddr || pc >= maxAddr)) {
					minAddr = pc > 8 ? pc - 8 : 0;
					maxAddr = bx::uint32_min(minAddr + numLinesVisible * 4, ramSize - 4);

					newScrollY = (minAddr / 4) * lineHeight;
				} else {
					app->m_ScrollToPC = false;
				}

				ImGui::SetCursorPosY(newScrollY);
				if (app->m_ScrollToPC) {
					ImGui::SetScrollFromPosY(newScrollY - scrollY, 0.0f);
					app->m_ScrollToPC = false;
				}

				ImGui::Columns(4, nullptr, true);
				static bool firstTime = true;
				if (firstTime) {
					ImGui::SetColumnOffset(0, 0.0f);
					ImGui::SetColumnOffset(1, 28.0f);
					ImGui::SetColumnOffset(2, 106.0f);
					ImGui::SetColumnOffset(3, 177.0f);
					firstTime = false;
				}
				ImGui::SetColumnOffset(1, 28.0f);

				for (uint32_t addr = minAddr; addr <= maxAddr; addr += 4) {
					char disasm[256];

					uint32_t instr;
					if (!app->m_CPU->getMemWord(app->m_MemoryMap, addr, instr)) {
						bx::snprintf(disasm, 256, "Unmapped memory location");
					} else {
						riscv::disasmInstruction(instr, addr, disasm, 256);
					}

					bool hasBP = dbgHasCodeBreakpoint(app->m_Dbg, addr);
					if (ImGui::BreakpointButton(addr, hasBP)) {
						if (hasBP) {
							dbgRemoveCodeBreakpoint(app->m_Dbg, addr);
						} else {
							dbgAddCodeBreakpoint(app->m_Dbg, addr);
						}
					}
					ImGui::NextColumn();

					char addrStr[32];
					bx::snprintf(addrStr, 32, "%08Xh", addr);
					ImGui::Selectable(addrStr, addr == pc, ImGuiSelectableFlags_SpanAllColumns);
					ImGui::SetItemAllowOverlap();
					ImGui::NextColumn();

					ImGui::Text("%08X", instr);
					ImGui::NextColumn();

					ImGui::Text(disasm);
					ImGui::NextColumn();
				}

				ImGui::Columns(1);

				ImGui::EndChild();
			}

			// Splitter
			ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0, 0));

			ImGui::InvisibleButton("hsplitter", ImVec2(-1, 8.0f));
			if (ImGui::IsItemActive()) {
				infoRegionHeight -= ImGui::GetIO().MouseDelta.y;

				const float totalHeight = ImGui::GetWindowHeight();
				if (infoRegionHeight > totalHeight - 150.0f) {
					infoRegionHeight = totalHeight - 150.0f;
				} else if (infoRegionHeight < 50.0f) {
					infoRegionHeight = 50.0f;
				}
			}

			ImGui::PopStyleVar();

			// Instruction operands
			if (ImGui::BeginChild("##instrOperands", ImVec2(-1, -1), true)) {
				char str[1024];

				uint32_t nextInstr;
				if (!riscv::mmRead(app->m_MemoryMap, pc, 0xFFFFFFFF, nextInstr)) {
					bx::snprintf(str, 1024, "Unmapped memory address");
				} else {
					riscv::disasmGetInstrOperandValues(app->m_CPU, app->m_MemoryMap, nextInstr, pc, str, 1024);
				}

				ImGui::TextWrapped(str);

				ImGui::EndChild();
			}
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_DEBUG;
	} else {
		app->m_WinVis |= UI_WIN_DEBUG;
	}
}

void doWin_Registers(App* app)
{
	const float regControlWidth = 110.0f;
	const float csrControlWidth = 150.0f;

	ImGui::SetNextWindowSize(ImVec2(150, 445), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(1130, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_REGISTERS) != 0;
	if (ImGui::BeginDock("Registers", &opened, 0)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			char str[256];

			// PC
			bx::snprintf(str, 256, "%08Xh", app->m_CPU->getPC());
			ImGui::InputTextEx("pc", str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);

			// Integer registers
			if (ImGui::CollapsingHeader("Integer Registers", ImGuiTreeNodeFlags_DefaultOpen)) {
				const float winWidth = ImGui::GetWindowContentRegionWidth();
				const uint32_t numControlsPerLine = bx::uint32_max((uint32_t)floorf(winWidth / regControlWidth), 1);

				for (uint32_t x = 1; x < 32;) {
					for (uint32_t i = 0; i < numControlsPerLine && x < 32; ++i, ++x) {
						ImGui::SetCursorPosX(i * regControlWidth + ImGui::GetStyle().WindowPadding.x);

						bx::snprintf(str, 256, "%08Xh", app->m_CPU->getRegister(x));
						ImGui::InputTextEx(riscv::disasmGetRegisterABIName(x), str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);
						ImGui::SameLine();
					}
					ImGui::NewLine();
				}
			}

			// CSRs
			if (ImGui::CollapsingHeader("Control & Status Registers", ImGuiTreeNodeFlags_DefaultOpen)) {
				struct CSRDesc {
					uint32_t m_ID;
					const char* m_Name;
				} csrList[] = {
					{ riscv::CSR::mvendorid, "mvendorid" },
					{ riscv::CSR::marchid, "marchid" },
					{ riscv::CSR::mimpid, "mimpid" },
					{ riscv::CSR::mhartid, "mhartid" },
					{ riscv::CSR::mstatus, "mstatus" },
					{ riscv::CSR::misa, "misa" },
					{ riscv::CSR::medeleg, "medeleg" },
					{ riscv::CSR::mideleg, "mideleg" },
					{ riscv::CSR::mie, "mie" },
					{ riscv::CSR::mtvec, "mtvec" },
					{ riscv::CSR::mcounteren, "mcounteren" },
					{ riscv::CSR::mscratch, "mscratch" },
					{ riscv::CSR::mepc, "mepc" },
					{ riscv::CSR::mcause, "mcause" },
					{ riscv::CSR::mtval, "mtval" },
					{ riscv::CSR::mip, "mip" },
					{ riscv::CSR::satp, "satp" }
				};
				const uint32_t numCSRs = BX_COUNTOF(csrList);

				const float winWidth = ImGui::GetWindowContentRegionWidth();
				const uint32_t numControlsPerLine = bx::uint32_max((uint32_t)floorf(winWidth / csrControlWidth), 1);

				for (uint32_t csr = 0; csr < numCSRs;) {
					for (uint32_t i = 0; i < numControlsPerLine && csr < numCSRs; ++i, ++csr) {
						ImGui::SetCursorPosX(i * csrControlWidth + ImGui::GetStyle().WindowPadding.x);

						bx::snprintf(str, 256, "%08Xh", app->m_CPU->getCSR(csrList[csr].m_ID));
						ImGui::InputTextEx(csrList[csr].m_Name, str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);
						ImGui::SameLine();
					}
					ImGui::NewLine();
				}
			}
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_REGISTERS;
	} else {
		app->m_WinVis |= UI_WIN_REGISTERS;
	}
}

void doWin_Breakpoints(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(150, 260), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(1130, 460), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_BREAKPOINTS) != 0;
	if (ImGui::BeginDock("Breakpoints", &opened, 0)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			ImGui::Checkbox("Break on EBREAK", &app->m_Config.m_BreakOnEBREAK);

			// 2 column layout
			ImGui::Columns(2, nullptr, true);

			const uint32_t nbp = dbgGetNumCodeBreakpoints(app->m_Dbg);
			for (uint32_t i = 0; i < nbp; ++i) {
				const uint32_t addr = dbgGetCodeBreakpointAddressByID(app->m_Dbg, i);

				ImGui::PushID(addr);
				ImGui::Text("%08X", addr);
				ImGui::NextColumn();
				if (ImGui::Button("Delete")) {
					dbgRemoveCodeBreakpoint(app->m_Dbg, addr);
				}
				ImGui::NextColumn();
				ImGui::PopID();
			}
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_BREAKPOINTS;
	} else {
		app->m_WinVis |= UI_WIN_BREAKPOINTS;
	}
}

void doWin_Terminal(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(CONSOLE_COLS * 8 + 30, CONSOLE_ROWS * 8 + 80), ImGuiSetCond_Always);
	ImGui::SetNextWindowPos(ImVec2(0, 440), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_TERMINAL) != 0;
	if (ImGui::BeginDock("Terminal", &opened, 0 | ImGuiWindowFlags_NoResize)) {
		if (!app->m_Console) {
			ImGui::Text("Emulator is not running");
		} else {
			static float consoleCursorAnimTimer = 0.0f;
			consoleCursorAnimTimer += ImGui::GetIO().DeltaTime;
			const bool consoleCursorVisible = (consoleCursorAnimTimer <= 0.0f) || fmodf(consoleCursorAnimTimer, 1.20f) <= 0.80f;

			const uint8_t* consoleBuffer = consoleGetBuffer(app->m_Console);
			ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(10.0f, 10.0f));
			if (ImGui::BeginChild("##console", ImVec2(-1.0f, -25.0f), true)) {
				ImGui::PushFont(app->m_MonoFont);
				ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0.0f, 0.0));

				ImVec2 cursor = ImGui::GetCursorScreenPos();
				cursor += ImVec2(1.0f, 1.0f);

				for (uint32_t i = 0; i < CONSOLE_ROWS; ++i) {
					char row[256];
					bx::memCopy(row, &consoleBuffer[i * CONSOLE_COLS], CONSOLE_COLS);
					row[CONSOLE_COLS] = '\0';
					ImGui::Text(row);
				}

				if (consoleCursorVisible) {
					uint32_t cX, cY;
					consoleGetCursorPos(app->m_Console, cX, cY);
					ImGui::GetWindowDrawList()->AddRectFilled(cursor + ImVec2(cX * 8.0f, cY * 8.0f), cursor + ImVec2((cX + 1) * 8.0f, (cY + 1) * 8.0f), ImGui::GetColorU32(ImGuiCol_Text), 0.0f);
				}

				ImGui::PopFont();
				ImGui::PopStyleVar(1);
				ImGui::EndChild();
			}
			ImGui::PopStyleVar(1);

			ImGui::PushFont(app->m_MonoFont);
			ImGui::KeyboardInput("##stdin", &app->m_StdInBuffer[0], BX_COUNTOF(app->m_StdInBuffer), ImVec2(-30.0f, 19.0f), true);
			ImGui::PopFont();

			ImGui::SameLine();
			if (ImGui::Button(ICON_FA_TRASH)) {
				bx::memSet(app->m_StdInBuffer, 0, BX_COUNTOF(app->m_StdInBuffer));
			}
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_TERMINAL;
	} else {
		app->m_WinVis |= UI_WIN_TERMINAL;
	}
}

void doWin_PerfCounters(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(350, 280), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 440), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_PERF_COUNTERS) != 0;
	if (ImGui::BeginDock("Performance counters", &opened, 0)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			char str[256];

			bx::snprintf(str, 256, "%" PRIu64, app->m_CPU->getCSR64(riscv::CSR::mcycle));
			ImGui::InputTextEx("mcycle", str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);

			bx::snprintf(str, 256, "%" PRIu64, app->m_CPU->getCSR64(riscv::CSR::minstret));
			ImGui::InputTextEx("minstret", str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_PERF_COUNTERS;
	} else {
		app->m_WinVis |= UI_WIN_PERF_COUNTERS;
	}
}

void doWin_MemoryEditor(App* app)
{
	bool opened = (app->m_WinVis & UI_WIN_MEMORY_EDITOR) != 0;
	if (ImGui::BeginDock("Memory Editor", &opened, ImGuiWindowFlags_NoScrollbar)) {
		if (!app->m_MemoryDevices || !app->m_NumMemoryDevices) {
			ImGui::Text("Emulator is not running");
		} else {
			ImGui::PushItemWidth(240.0f);
			ImGui::Combo("Device", &app->m_SelectedMemDevice, app->m_MemDevicesComboStr);

			MemoryDeviceDesc* memDev = &app->m_MemoryDevices[app->m_SelectedMemDevice];
			app->m_MemoryEditor.ReadOnly = memDev->m_IsReadOnly;
			app->m_MemoryEditor.DrawContents(memDev->m_DataPtr, memDev->m_Size, memDev->m_BaseAddr);
		}
	}
	ImGui::EndDock();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_MEMORY_EDITOR;
	} else {
		app->m_WinVis |= UI_WIN_MEMORY_EDITOR;
	}
}

void doUI(App* app)
{
	doMainMenu(app);

	if (app->m_WinVis & UI_WIN_SETUP) {
		doWin_Setup(app);
	}
	
	if (app->m_WinVis & UI_WIN_DEBUG) {
		doWin_Debugger(app);
	}
	
	if (app->m_WinVis & UI_WIN_REGISTERS) {
		doWin_Registers(app);
	}

	if (app->m_WinVis & UI_WIN_BREAKPOINTS) {
		doWin_Breakpoints(app);
	}

	if (app->m_WinVis & UI_WIN_TERMINAL) {
		doWin_Terminal(app);
	}

	if (app->m_WinVis & UI_WIN_PERF_COUNTERS) {
		doWin_PerfCounters(app);
	}

	if (app->m_WinVis & UI_WIN_MEMORY_EDITOR) {
		doWin_MemoryEditor(app);
	}

	//ImGui::Begin("Style Editor", nullptr); 
	//ImGui::ShowStyleEditor(); 
	//ImGui::End();
}

void glfw_errorCallback(int error, const char* description)
{
	RISCV_CHECK(false, "GLFW Error %d: %s", error, description);
	printf("GLFW Error %d: %s\n", error, description);
}


void ImGui_InitStyle()
{
	ImGuiStyle& style = ImGui::GetStyle();

	style.Colors[ImGuiCol_Text] = ImVec4(0.00f, 0.00f, 0.00f, 1.00f);
	style.Colors[ImGuiCol_TextDisabled] = ImVec4(0.60f, 0.60f, 0.60f, 1.00f);
//	style.Colors[ImGuiCol_TextHovered] = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
//	style.Colors[ImGuiCol_TextActive] = ImVec4(1.00f, 1.00f, 0.00f, 1.00f);
	style.Colors[ImGuiCol_WindowBg] = ImVec4(0.94f, 0.94f, 0.94f, 1.00f);
	style.Colors[ImGuiCol_ChildWindowBg] = ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
	style.Colors[ImGuiCol_Border] = ImVec4(0.00f, 0.00f, 0.00f, 0.39f);
	style.Colors[ImGuiCol_BorderShadow] = ImVec4(1.00f, 1.00f, 1.00f, 0.10f);
	style.Colors[ImGuiCol_FrameBg] = ImVec4(1.00f, 1.00f, 1.00f, 1.00f);
	style.Colors[ImGuiCol_FrameBgHovered] = ImVec4(0.26f, 0.59f, 0.98f, 0.40f);
	style.Colors[ImGuiCol_FrameBgActive] = ImVec4(0.26f, 0.59f, 0.98f, 0.67f);
	style.Colors[ImGuiCol_TitleBg] = ImVec4(0.96f, 0.96f, 0.96f, 1.00f);
	style.Colors[ImGuiCol_TitleBgCollapsed] = ImVec4(1.00f, 1.00f, 1.00f, 0.51f);
	style.Colors[ImGuiCol_TitleBgActive] = ImVec4(0.82f, 0.82f, 0.82f, 1.00f);
	style.Colors[ImGuiCol_MenuBarBg] = ImVec4(0.86f, 0.86f, 0.86f, 1.00f);
	style.Colors[ImGuiCol_ScrollbarBg] = ImVec4(0.98f, 0.98f, 0.98f, 0.53f);
	style.Colors[ImGuiCol_ScrollbarGrab] = ImVec4(0.69f, 0.69f, 0.69f, 0.80f);
	style.Colors[ImGuiCol_ScrollbarGrabHovered] = ImVec4(0.49f, 0.49f, 0.49f, 0.80f);
	style.Colors[ImGuiCol_ScrollbarGrabActive] = ImVec4(0.49f, 0.49f, 0.49f, 1.00f);
	style.Colors[ImGuiCol_ComboBg] = ImVec4(0.86f, 0.86f, 0.86f, 0.99f);
	style.Colors[ImGuiCol_CheckMark] = ImVec4(0.26f, 0.59f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_SliderGrab] = ImVec4(0.26f, 0.59f, 0.98f, 0.78f);
	style.Colors[ImGuiCol_SliderGrabActive] = ImVec4(0.26f, 0.59f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_Button] = ImVec4(0.26f, 0.59f, 0.98f, 0.40f);
	style.Colors[ImGuiCol_ButtonHovered] = ImVec4(0.26f, 0.59f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_ButtonActive] = ImVec4(0.06f, 0.53f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_Header] = ImVec4(0.26f, 0.59f, 0.98f, 0.31f);
	style.Colors[ImGuiCol_HeaderHovered] = ImVec4(0.26f, 0.59f, 0.98f, 0.80f);
	style.Colors[ImGuiCol_HeaderActive] = ImVec4(0.26f, 0.59f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_Column] = ImVec4(0.39f, 0.39f, 0.39f, 1.00f);
	style.Colors[ImGuiCol_ColumnHovered] = ImVec4(0.26f, 0.59f, 0.98f, 0.78f);
	style.Colors[ImGuiCol_ColumnActive] = ImVec4(0.26f, 0.59f, 0.98f, 1.00f);
	style.Colors[ImGuiCol_ResizeGrip] = ImVec4(1.00f, 1.00f, 1.00f, 0.00f);
	style.Colors[ImGuiCol_ResizeGripHovered] = ImVec4(0.26f, 0.59f, 0.98f, 0.67f);
	style.Colors[ImGuiCol_ResizeGripActive] = ImVec4(0.26f, 0.59f, 0.98f, 0.95f);
	style.Colors[ImGuiCol_CloseButton] = ImVec4(0.59f, 0.59f, 0.59f, 0.50f);
	style.Colors[ImGuiCol_CloseButtonHovered] = ImVec4(0.98f, 0.39f, 0.36f, 1.00f);
	style.Colors[ImGuiCol_CloseButtonActive] = ImVec4(0.98f, 0.39f, 0.36f, 1.00f);
	style.Colors[ImGuiCol_PlotLines] = ImVec4(0.39f, 0.39f, 0.39f, 1.00f);
	style.Colors[ImGuiCol_PlotLinesHovered] = ImVec4(1.00f, 0.43f, 0.35f, 1.00f);
	style.Colors[ImGuiCol_PlotHistogram] = ImVec4(0.90f, 0.70f, 0.00f, 1.00f);
	style.Colors[ImGuiCol_PlotHistogramHovered] = ImVec4(1.00f, 0.60f, 0.00f, 1.00f);
	style.Colors[ImGuiCol_TextSelectedBg] = ImVec4(0.26f, 0.59f, 0.98f, 0.35f);
//	style.Colors[ImGuiCol_TooltipBg] = ImVec4(1.00f, 1.00f, 1.00f, 0.94f);
	style.Colors[ImGuiCol_ModalWindowDarkening] = ImVec4(0.20f, 0.20f, 0.20f, 0.35f);
}

int main()
{
	App app(UI_WIN_SETUP | UI_WIN_DEBUG | UI_WIN_REGISTERS | UI_WIN_BREAKPOINTS | UI_WIN_TERMINAL | UI_WIN_PERF_COUNTERS | UI_WIN_MEMORY_EDITOR);

	if (configLoad(&app.m_Config, "./config.json")) {
		app.m_KernelELFData = readFile(app.m_Config.m_KernelELFFile, app.m_KernelELFSize);
	} else {
		// TODO: Reset to default values?
	}

	// Setup window
	glfwSetErrorCallback(glfw_errorCallback);
	if (!glfwInit()) {
		return -1;
	}

	app.m_GLFWWindow = glfwCreateWindow(1280, 720, "RISC-V Emulator (RV32I)", nullptr, nullptr);
	glfwMakeContextCurrent(app.m_GLFWWindow);
//	glfwSwapInterval(0);

	// Setup ImGui binding
	ImGui_ImplGlfw_Init(app.m_GLFWWindow, true);
	ImGui_InitStyle();

	// Initialize extra fonts...
	{
		ImGuiIO& io = ImGui::GetIO();

		// Default font
		io.Fonts->AddFontDefault();

		// Merge FontAwesome into default font
		ImFontConfig config;
		config.MergeMode = true;
		static const ImWchar icon_ranges[] = { ICON_MIN_FA, ICON_MAX_FA, 0 };
		io.Fonts->AddFontFromFileTTF("./fontawesome-webfont.ttf", 13.0f, &config, icon_ranges);

		// Terminal font as separate font.
		static const ImWchar mono_ranges[] = { 1, 255, 0 };
		app.m_MonoFont = io.Fonts->AddFontFromFileTTF("./Px437_IBM_CGA.ttf", 8.0f, nullptr, mono_ranges);
	}

	const ImVec4 clear_color = ImColor(114, 144, 154);

	ImGui::LoadDock();

	while (!glfwWindowShouldClose(app.m_GLFWWindow)) {
		glfwPollEvents();
		ImGui_ImplGlfw_NewFrame();

		doUI(&app);

		if (app.m_CPU && app.m_MemoryMap) {
			if (app.m_NumCPUSteps != 0) {
				uint32_t ns = app.m_NumCPUSteps;
				bool breakpointReached = false;
				while (ns-- > 0) {
					// Transmit any data stored in UART's TX buffer to the console.
					uint8_t consoleData;
					if (riscv::device::uartTransmit(app.m_ConsoleUART, consoleData)) {
						consoleWrite(app.m_Console, consoleData);
					}

					// Transmit any data from stdin to the UART.
					if (app.m_StdInBuffer[0] != '\0') {
						if (riscv::device::uartReceive(app.m_ConsoleUART, app.m_StdInBuffer[0])) {
							// 1 character consumed by the CPU.
							const uint32_t stdInBufLen = (uint32_t)bx::strLen(app.m_StdInBuffer);
							bx::memCopy(&app.m_StdInBuffer[0], &app.m_StdInBuffer[1], stdInBufLen);
						}
					}

#if ENABLE_TRACING
					tracePush(&app, app.m_CPU->getPC());
#endif
					
					app.m_CPU->tick(app.m_MemoryMap);
					
					if ((app.m_Config.m_BreakOnEBREAK && app.m_CPU->getOutputPin(riscv::OutputPin::Breakpoint)) || 
						dbgHasCodeBreakpoint(app.m_Dbg, app.m_CPU->getPC())) 
					{
						breakpointReached = true;
						break;
					}
				}

				if (app.m_Run) {
					if (breakpointReached) {
						app.m_Run = false;
						app.m_NumCPUSteps = 0;
					}
				} else {
					app.m_NumCPUSteps = 0;
				}
				app.m_ScrollToPC = true;
			}
		}

		// Rendering
		int display_w, display_h;
		glfwGetFramebufferSize(app.m_GLFWWindow, &display_w, &display_h);
		glViewport(0, 0, display_w, display_h);
		glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w);
		glClear(GL_COLOR_BUFFER_BIT);
		ImGui::Render();
		glfwSwapBuffers(app.m_GLFWWindow);

		if (ImGui::GetIO().DisplaySize.y > 0) {
			ImVec2 pos = ImVec2(0, 20.0f);
			ImVec2 size = ImGui::GetIO().DisplaySize;
			size.y -= pos.y;
			ImGui::RootDock(pos, size);
		}
	}

	// Cleanup
	configSave(&app.m_Config, "./config.json");
	ImGui::SaveDock();
	ImGui_ImplGlfw_Shutdown();
	glfwTerminate();

	return 0;
}
