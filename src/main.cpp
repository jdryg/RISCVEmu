#include "elf/parser.h"
#include "riscv/cpu.h"
#include "riscv/memory_map.h"
#include "console.h"
#include "debugger.h"
#include "syscall.h"
#include "debug.h"

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

#define MAX_STDIN_BUFFER       256

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
	GLFWwindow* m_GLFWWindow;
	riscv::CPU* m_CPU;
	riscv::MemoryMap* m_MemoryMap;
	riscv::Device* m_ConsoleUART;
	Console* m_Console;
	Debugger* m_Dbg;
	MemoryDeviceDesc* m_MemoryDevices;
	uint32_t m_NumMemoryDevices;

	uint8_t* m_KernelELFData;
	uint8_t* m_ProgramELFData;
	uint32_t m_KernelELFSize;
	uint32_t m_ProgramELFSize;
	int m_RAMSizeMB;
	int m_InitError;
	bool m_ScrollToPC;
	uint32_t m_NumCPUSteps;
	bool m_Run;

	MemoryEditor m_MemoryEditor;
	int m_SelectedMemDevice;
	char* m_MemDevicesComboStr;
	ImFont* m_MonoFont;
	char m_StdInBuffer[MAX_STDIN_BUFFER];
	bool m_StdInInputForceUpdate;
	uint32_t m_WinVis;

	App(uint32_t visibleWindows)
		: m_GLFWWindow(nullptr)
		, m_CPU(nullptr)
		, m_MemoryMap(nullptr)
		, m_Dbg(nullptr)
		, m_WinVis(visibleWindows)
		, m_KernelELFData(nullptr)
		, m_KernelELFSize(0)
		, m_ProgramELFData(nullptr)
		, m_ProgramELFSize(0)
		, m_InitError(INIT_ERR_SUCCESS)
		, m_RAMSizeMB(4)
		, m_ScrollToPC(true)
		, m_NumCPUSteps(0)
		, m_Run(false)
		, m_MonoFont(nullptr)
		, m_ConsoleUART(nullptr)
		, m_Console(nullptr)
		, m_StdInInputForceUpdate(false)
		, m_MemoryDevices(nullptr)
		, m_NumMemoryDevices(0)
		, m_SelectedMemDevice(-1)
		, m_MemDevicesComboStr(nullptr)
	{
		bx::memSet(m_StdInBuffer, 0, sizeof(char) * MAX_STDIN_BUFFER);
	}

	~App()
	{}
};

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
	const uint32_t ramSize = (uint32_t)app->m_RAMSizeMB << 20;

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

#if 0
	riscv::Device* hdd = riscv::device::vhdCreate("./hdd.vhd"); // TODO: Configuration option
	if (!hdd) {
		return INIT_ERR_NO_MEMORY; // TODO: Different error?
	}
	riscv::mmMapDevice(mm, hdd, HDD_BASE_ADDR, riscv::device::kVHDMemorySize);
#endif

	// Initialize CPU
	riscv::CPU* cpu = (riscv::CPU*)malloc(sizeof(riscv::CPU));
	riscv::cpuReset(cpu, entryPointAddr, ramSize - 4);

	// Initialize app
	app->m_CPU = cpu;
	app->m_MemoryMap = mm;
	app->m_ConsoleUART = consoleUART;
	app->m_Console = consoleCreate(40, 25);
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
	free(app->m_CPU);
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
				ImGui::SliderInt("RAM [MB]", &app->m_RAMSizeMB, 1, 16);
			}
		}

		if (ImGui::CollapsingHeader("Kernel/BIOS", ImGuiTreeNodeFlags_DefaultOpen)) {
			static char elfFilename[256] = { 0 }; // TODO: Move to App?
			doWin_Setup_ELFFile("##kernel", elfFilename, 256, app->m_KernelELFData, app->m_KernelELFSize, !app->m_CPU);
		}

#if 0
		if (ImGui::CollapsingHeader("Program", ImGuiTreeNodeFlags_DefaultOpen)) {
			static char elfFilename[256] = { 0 }; // TODO: Move to App?
			doWin_Setup_ELFFile("##program", elfFilename, 256, app->m_ProgramELFData, app->m_ProgramELFSize, !app->m_CPU);
		}
#endif

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
				static int ticksPerFrame = 1;

				if (ImGui::Button(ICON_FA_PLAY)) {
					app->m_NumCPUSteps = ticksPerFrame;
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
				ImGui::DragInt("Ticks/frame", &ticksPerFrame, 1.0f, 1, 10000);

				if (ImGui::Button("Go to PC")) {
					app->m_ScrollToPC = true;
				}
			}

			const float lineHeight = ImGui::GetTextLineHeightWithSpacing();

			// TODO: Change scrolling to be able to see the whole address space.
			const uint32_t ramSize = 1 << 20;
			const uint32_t numWords = ramSize / 4;
			const uint32_t pc = cpuGetPC(app->m_CPU);

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
					if (!riscv::mmRead(app->m_MemoryMap, addr, 0xFFFFFFFF, instr)) {
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
	const float fieldWidth = 110.0f;

	ImGui::SetNextWindowSize(ImVec2(150, 445), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(1130, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_REGISTERS) != 0;
	if (ImGui::BeginDock("Registers", &opened, 0)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			const float winWidth = ImGui::GetWindowContentRegionWidth();
			const uint32_t numFieldsPerLine = bx::uint32_max((uint32_t)floorf(winWidth / fieldWidth), 1);

			for (uint32_t x = 1; x < 32;) {
				for (uint32_t i = 0; i < numFieldsPerLine && x < 32; ++i, ++x) {
					ImGui::SetCursorPosX(i * fieldWidth + ImGui::GetStyle().WindowPadding.x);

					char str[256];
					bx::snprintf(str, 256, "%08Xh", riscv::cpuGetRegister(app->m_CPU, x));
					ImGui::InputTextEx(riscv::disasmGetRegisterABIName(x), str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);
					ImGui::SameLine();
				}
				ImGui::NewLine();
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
	ImGui::SetNextWindowSize(ImVec2(350, 280), ImGuiSetCond_Always);
	ImGui::SetNextWindowPos(ImVec2(0, 440), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_TERMINAL) != 0;
	if (ImGui::BeginDock("Terminal", &opened, 0 | ImGuiWindowFlags_NoResize)) {
		if (!app->m_Console) {
			ImGui::Text("Emulator is not running");
		} else {
			const uint8_t* consoleBuffer = consoleGetBuffer(app->m_Console);
			ImGui::PushStyleVar(ImGuiStyleVar_WindowPadding, ImVec2(10.0f, 10.0f));
			if (ImGui::BeginChild("##console", ImVec2(-1.0f, -25.0f), true)) {
				ImGui::PushFont(app->m_MonoFont);
				ImGui::PushStyleVar(ImGuiStyleVar_ItemSpacing, ImVec2(0.0f, 0.0));
				for (uint32_t i = 0; i < 25; ++i) {
					char row[256];
					bx::memCopy(row, &consoleBuffer[i * 40], 40);
					row[40] = '\0';
					ImGui::Text(row);
				}
				ImGui::PopFont();
				ImGui::PopStyleVar(1);
				ImGui::EndChild();
			}
			ImGui::PopStyleVar(1);

			const uint32_t flags = 0
				| ImGuiInputTextFlags_AllowTabInput
				| ImGuiInputTextFlags_EnterReturnsTrue
				| (app->m_StdInInputForceUpdate ? ImGuiInputTextFlags_ReadOnly : 0);

			if (ImGui::InputTextEx("##stdin", &app->m_StdInBuffer[0], BX_COUNTOF(app->m_StdInBuffer), ImVec2(-1.0f, 0.0f), flags, nullptr, app)) {
				const uint32_t len = (uint32_t)bx::strLen(app->m_StdInBuffer);
				app->m_StdInBuffer[len] = '\n';
				app->m_StdInBuffer[len + 1] = '\0';

				ImGui::SetKeyboardFocusHere();
			}
			app->m_StdInInputForceUpdate = false;
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

			bx::snprintf(str, 256, "%" PRIu64, riscv::cpuGetCSR64(app->m_CPU, riscv::CSR::mcycle));
			ImGui::InputTextEx("mcycle", str, 256, ImVec2(75.0f, 0.0f), ImGuiInputTextFlags_ReadOnly);

			bx::snprintf(str, 256, "%" PRIu64, riscv::cpuGetCSR64(app->m_CPU, riscv::CSR::minstret));
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
}

void glfw_errorCallback(int error, const char* description)
{
	RISCV_CHECK(false, "GLFW Error %d: %s", error, description);
	printf("GLFW Error %d: %s\n", error, description);
}

#if 0
#pragma pack(push, 1)
struct PartitionTableEntry
{
	uint8_t m_Status;
	uint8_t m_FirstHead;
	uint16_t m_FirstSector : 5;
	uint16_t m_FirstCylinder : 11;
	uint8_t m_PartitionType;
	uint8_t m_LastHead;
	uint16_t m_LastSector : 5;
	uint16_t m_LastCylinder : 11;
	uint32_t m_FirstSectorLBA;
	uint32_t m_NumSectors;
};
#pragma pack(pop)

// https://staff.washington.edu/dittrich/misc/fatgen103.pdf
#pragma pack(push, 1)
struct BIOSParamBlock
{
	uint8_t m_JmpBoot[3]; // 0xE9 0xXX 0xXX
	uint8_t m_OEMName[8];
	uint16_t m_BytesPerSector;
	uint8_t m_SectorsPerCluster;
	uint16_t m_ReservedSectorCount;
	uint8_t m_NumFATs;
	uint16_t m_RootEntriesCount;
	uint16_t m_TotalSectors16;
	uint8_t m_Media;
	uint16_t m_FATSize16;
	uint16_t m_SectorsPerTrack;
	uint16_t m_NumHeads;
	uint32_t m_HiddenSectors;
	uint32_t m_TotalSectors32;

	union FAT {
		struct FAT16
		{
			uint8_t m_DriveNumber;
			uint8_t m_Reserved1;
			uint8_t m_BootSig;
			uint32_t m_VolID;
			uint8_t m_VolLab[11];
			uint8_t m_FileSysType[8];
		} FAT16;

		struct FAT32
		{
			uint32_t m_FATSize32;
			uint16_t m_ExtFlags;
			uint16_t m_FSVer;
			uint32_t m_RootClus;
			uint16_t m_FSInfo;
			uint16_t m_BkBootSec;
			uint8_t m_Reserved[8];
			uint8_t m_DriveNumber;
			uint8_t m_Reserved1;
			uint8_t m_BootSig;
			uint32_t m_VolID;
			uint8_t m_VolLab[11];
			uint8_t m_FileSysType[8];
		} FAT32;
	} FAT;
};
#pragma pack(pop)

#pragma pack(push, 1)
struct DirectoryEntry
{
	uint8_t m_Filename[8];
	uint8_t m_Extension[3];
	uint8_t m_Attrs;
	uint8_t m_Reserved[10];
	uint16_t m_LastUpdateTime;
	uint16_t m_LastDateTime;
	uint16_t m_StartClusterNumber;
	uint32_t m_FileSize;
};
#pragma pack(pop)

struct FATType
{
	enum Enum : uint32_t
	{
		FAT12 = 0,
		FAT16 = 1,
		FAT32 = 2,
		Unknown = 0xFFFFFFFF
	};
};

void vhdReadSector(riscv::Device* vhd, uint32_t lba, uint8_t* sectorData)
{
	uint16_t* dst = (uint16_t*)&sectorData[0];
	vhd->write(vhd, 6 * sizeof(uint32_t), 0x000000FF, lba >> 24); // LBA[24:27]
	vhd->write(vhd, 2 * sizeof(uint32_t), 0x000000FF, 1); // sector count
	vhd->write(vhd, 3 * sizeof(uint32_t), 0x000000FF, lba & 0x000000FF); // LBA[0:7]
	vhd->write(vhd, 4 * sizeof(uint32_t), 0x000000FF, (lba >> 8) & 0x000000FF); // LBA[8:15]
	vhd->write(vhd, 5 * sizeof(uint32_t), 0x000000FF, (lba >> 16) & 0x000000FF); // LBA[16:23]
	vhd->write(vhd, 7 * sizeof(uint32_t), 0x000000FF, 0x20); // READ SECTORS command
	while (!(vhd->read(vhd, 7 * sizeof(uint32_t), 0x000000FF) & 0x08)); // Wait for the DRQ status bit.
	for (uint32_t i = 0; i < 256; ++i) {
		uint32_t halfWord = vhd->read(vhd, 0 * sizeof(uint32_t), 0x0000FFFF);
		*dst++ = (uint16_t)halfWord;
	}
}

void sectorFromCluster(uint32_t N, BIOSParamBlock* bpb, uint32_t& secNum, uint32_t& entOff)
{
	// Assume FAT16
	const uint32_t FATOffset = N << 1;
	secNum = bpb->m_ReservedSectorCount + (FATOffset / bpb->m_BytesPerSector);
	entOff = FATOffset % bpb->m_BytesPerSector;
}
#endif // 0

int main()
{
#if 0
	// TEST/DEBUG
	{
		// VHD device test
		riscv::Device* vhd = riscv::device::vhdCreate("./hdd.vhd");
		if (!vhd) {
			return -1;
		}

		// Read the first sector
		uint8_t sector[512];
		vhdReadSector(vhd, 0, sector);

		// Search sector #0 for partition information...
		PartitionTableEntry* pte = (PartitionTableEntry*)&sector[446];
		if (pte->m_PartitionType != 0) {
			// Not an empty partition.
			// Read the first partition sector.
			uint8_t bootSector[512];
			vhdReadSector(vhd, pte->m_FirstSectorLBA, bootSector);

			BIOSParamBlock* bpbc = (BIOSParamBlock*)&bootSector[0];

			// FAT type determination (see pdf).
			uint32_t rootDirSectors = ((bpbc->m_RootEntriesCount * 32) + (bpbc->m_BytesPerSector - 1)) / bpbc->m_BytesPerSector;
			uint32_t FATsz = bpbc->m_FATSize16 != 0 ? bpbc->m_FATSize16 : bpbc->FAT.FAT32.m_FATSize32;
			uint32_t totalSec = bpbc->m_TotalSectors16 != 0 ? bpbc->m_TotalSectors16 : bpbc->m_TotalSectors32;
			uint32_t dataSec = totalSec - (bpbc->m_ReservedSectorCount + (bpbc->m_NumFATs * FATsz) + rootDirSectors);
			uint32_t countOfClusters = dataSec / bpbc->m_SectorsPerCluster;

			FATType::Enum fatType = FATType::Unknown;
			if (countOfClusters < 4085) {
				fatType = FATType::FAT12;
			} else if (countOfClusters < 65525) {
				fatType = FATType::FAT16;
			} else {
				fatType = FATType::FAT32;
			}

			uint32_t firstRootDirSectorRel = bpbc->m_ReservedSectorCount + (bpbc->m_NumFATs * FATsz);
			uint32_t firstRootDirSectorAbs = pte->m_FirstSectorLBA + firstRootDirSectorRel ;

			uint8_t rootDirSector[512];
			vhdReadSector(vhd, firstRootDirSectorAbs, rootDirSector);

			DirectoryEntry* de = (DirectoryEntry*)&rootDirSector[0];
			de++; // Skip first entry.

			// Assume FAT16 from now on
			uint32_t sectorNumberRel, entOffset;
			sectorFromCluster(de->m_StartClusterNumber, bpbc, sectorNumberRel, entOffset);

			uint8_t fatSector[512];
			vhdReadSector(vhd, pte->m_FirstSectorLBA + sectorNumberRel, fatSector);

			uint16_t FAT16ClusEntryVal = *(uint16_t*)&fatSector[entOffset];

			uint32_t firstDataSector = bpbc->m_ReservedSectorCount + (bpbc->m_NumFATs * FATsz) + rootDirSectors;
			uint32_t firstSectorofCluster = ((FAT16ClusEntryVal - 2) * bpbc->m_SectorsPerCluster) + firstDataSector;

			uint8_t fileDataSector[512];
			vhdReadSector(vhd, pte->m_FirstSectorLBA + firstSectorofCluster, fileDataSector);

			int a = 0;
		}

		riscv::device::destroy(vhd);
	}
#endif

	App app(UI_WIN_SETUP | UI_WIN_DEBUG | UI_WIN_REGISTERS | UI_WIN_BREAKPOINTS | UI_WIN_TERMINAL | UI_WIN_PERF_COUNTERS | UI_WIN_MEMORY_EDITOR);

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
		app.m_MonoFont = io.Fonts->AddFontFromFileTTF("./Px437_IBM_CGA.ttf", 8.0f);
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
							app.m_StdInInputForceUpdate = true;
						}
					}

					riscv::cpuTick_SingleCycle(app.m_CPU, app.m_MemoryMap);
					
					if (dbgHasCodeBreakpoint(app.m_Dbg, cpuGetPC(app.m_CPU))) {
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
	ImGui::SaveDock();
	ImGui_ImplGlfw_Shutdown();
	glfwTerminate();

	return 0;
}
