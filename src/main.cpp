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
#include "imgui_impl_glfw.h"
#include <GLFW/glfw3.h>

#include <stdint.h>
#include <stdio.h>
#include <malloc.h>
#include <memory.h>

#define MAX_STDIN_BUFFER 256

#define INIT_ERR_SUCCESS     0
#define INIT_ERR_NO_MEMORY   1
#define INIT_ERR_INVALID_ELF 2

#define UI_WIN_SETUP       0x00000001
#define UI_WIN_DEBUG       0x00000002
#define UI_WIN_REGISTERS   0x00000004
#define UI_WIN_BREAKPOINTS 0x00000008
#define UI_WIN_TERMINAL    0x00000010

#define KERNEL_BASE_ADDR       0x00000000 // BIOS or Kernel? This is the code that runs in M-mode with no address translation for memory accesses.
#define RAM_BASE_ADDR          0x00100000
#define CONSOLE_UART_BASE_ADDR 0x80000000

struct App
{
	GLFWwindow* m_GLFWWindow;
	riscv::CPU* m_CPU;
	riscv::MemoryMap* m_MemoryMap;
	riscv::Device* m_ConsoleUART;
	Console* m_Console;
	Debugger* m_Dbg;

	uint8_t* m_KernelELFData;
	uint8_t* m_ProgramELFData;
	uint32_t m_KernelELFSize;
	uint32_t m_ProgramELFSize;
	int m_RAMSizeMB;
	int m_InitError;
	bool m_ScrollToPC;
	uint32_t m_NumCPUSteps;
	bool m_Run;

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

	// Load kernel into memory...
	uint32_t entryPointAddr = elf::load(app->m_KernelELFData, KERNEL_BASE_ADDR, mm);
	if (entryPointAddr == ~0u) {
		return INIT_ERR_INVALID_ELF;
	}

	riscv::CPU* cpu = (riscv::CPU*)malloc(sizeof(riscv::CPU));
	riscv::cpuReset(cpu, entryPointAddr, ramSize - 4);

	app->m_CPU = cpu;
	app->m_MemoryMap = mm;
	app->m_ConsoleUART = consoleUART;
	app->m_Console = consoleCreate(40, 25);
	app->m_Dbg = dbgCreate();
	app->m_ScrollToPC = true;

	return INIT_ERR_SUCCESS;
}

void shutdownEmulator(App* app)
{
	free(app->m_CPU);
	app->m_CPU = nullptr;

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

			ImGui::EndMenu();
		}

		ImGui::EndMainMenuBar();
	}
}

void doWin_Setup_ELFFile(const char* str_id, char* filename, uint32_t len, uint8_t*& elfData, uint32_t& elfSize, bool editable)
{
	ImGui::PushID(str_id);

	ImGui::InputText("##ELF", filename, len, ImGuiInputTextFlags_ReadOnly);

	if (editable) {
		ImGui::SameLine();
		if (ImGui::Button("Browse...")) {
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
	ImGui::SetNextWindowSize(ImVec2(300, 300), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_SETUP) != 0;
	if (ImGui::Begin("Setup", &opened, ImGuiWindowFlags_ShowBorders)) {
		if (!app->m_CPU) {
			if (ImGui::CollapsingHeader("System configuration")) {
				ImGui::SliderInt("RAM [MB]", &app->m_RAMSizeMB, 1, 16);
			}
		}

		if (ImGui::CollapsingHeader("Kernel", ImGuiTreeNodeFlags_DefaultOpen)) {
			static char elfFilename[256] = { 0 }; // TODO: Move to App?
			doWin_Setup_ELFFile("##kernel", elfFilename, 256, app->m_KernelELFData, app->m_KernelELFSize, !app->m_CPU);
		}

		if (ImGui::CollapsingHeader("Program", ImGuiTreeNodeFlags_DefaultOpen)) {
			static char elfFilename[256] = { 0 }; // TODO: Move to App?
			doWin_Setup_ELFFile("##program", elfFilename, 256, app->m_ProgramELFData, app->m_ProgramELFSize, !app->m_CPU);
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
	ImGui::End();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_SETUP;
	} else {
		app->m_WinVis |= UI_WIN_SETUP;
	}
}

void doWin_Debugger(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(500, 580), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(300, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_DEBUG) != 0;
	if (ImGui::Begin("Debugger", &opened, ImGuiWindowFlags_ShowBorders)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			// TODO: move those to a toolbar?
			if (ImGui::Button("Go to PC")) {
				app->m_ScrollToPC = true;
			}
			ImGui::SameLine();
			if (app->m_Run) {
				if (ImGui::Button("Break")) {
					app->m_NumCPUSteps = 0;
					app->m_Run = false;
				}
			} else {
				static int ticksPerFrame = 1;

				if (ImGui::Button("Run")) {
					app->m_NumCPUSteps = ticksPerFrame;
					app->m_Run = true;
				}

				ImGui::SameLine();
				if (ImGui::Button("Step 1")) {
					app->m_NumCPUSteps = 1;
				}

				ImGui::SameLine();
				if (ImGui::Button("Step 100")) {
					app->m_NumCPUSteps = 100;
				}

				ImGui::SameLine();
				ImGui::DragInt("Ticks/frame", &ticksPerFrame, 1.0f, 1, 10000);
			}

			const float lineHeight = ImGui::GetTextLineHeightWithSpacing();

			// TODO: Change scrolling to be able to see the whole address space.
			const uint32_t ramSize = 1 << 20;
			const uint32_t numWords = ramSize / 4; // TODO: Disassemble only the .text section.
			const uint32_t pc = cpuGetPC(app->m_CPU);

			static float infoRegionHeight = 150.0f;
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
	ImGui::End();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_DEBUG;
	} else {
		app->m_WinVis |= UI_WIN_DEBUG;
	}
}

void doWin_Registers(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(300, 300), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_REGISTERS) != 0;
	if (ImGui::Begin("Registers", &opened, ImGuiWindowFlags_ShowBorders)) {
		if (!app->m_CPU) {
			ImGui::Text("Emulator is not running");
		} else {
			ImGui::TextWrapped("ra: %08Xh\tsp: %08Xh\tgp: %08Xh\ttp: %08Xh\tt0: %08Xh\tt1: %08Xh\tt2: %08Xh\ts0: %08Xh\ts1: %08Xh\ta0: %08Xh\ta1: %08Xh\ta2: %08Xh\ta3: %08Xh\ta4: %08Xh\ta5: %08Xh\ta6: %08Xh\ta7: %08Xh\ts2: %08Xh\ts3: %08Xh\ts4: %08Xh\ts5: %08Xh\ts6: %08Xh\ts7: %08Xh\ts8: %08Xh\ts9: %08Xh\ts10: %08Xh\ts11: %08Xh\tt3: %08Xh\tt4: %08Xh\tt5: %08Xh\tt6: %08Xh"
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::ra)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::sp)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::gp)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::tp)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t0)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t1)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t2)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s0)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s1)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a0)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a1)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a2)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a3)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a4)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a5)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a6)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::a7)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s2)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s3)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s4)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s5)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s6)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s7)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s8)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s9)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s10)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::s11)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t3)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t4)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t5)
				, riscv::cpuGetRegister(app->m_CPU, riscv::IReg::t6));
		}
	}
	ImGui::End();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_REGISTERS;
	} else {
		app->m_WinVis |= UI_WIN_REGISTERS;
	}
}

void doWin_Breakpoints(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(300, 300), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_BREAKPOINTS) != 0;
	if (ImGui::Begin("Breakpoints", &opened, ImGuiWindowFlags_ShowBorders)) {
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
	ImGui::End();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_BREAKPOINTS;
	} else {
		app->m_WinVis |= UI_WIN_BREAKPOINTS;
	}
}

void doWin_Terminal(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(355, 280), ImGuiSetCond_Always);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_TERMINAL) != 0;
	if (ImGui::Begin("Terminal", &opened, ImGuiWindowFlags_ShowBorders | ImGuiWindowFlags_NoResize)) {
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

			const uint32_t flags = ImGuiInputTextFlags_AllowTabInput
				| ImGuiInputTextFlags_EnterReturnsTrue
				| (app->m_StdInInputForceUpdate ? ImGuiInputTextFlags_ReadOnly : 0);

			if (ImGui::InputTextEx("##stdin", &app->m_StdInBuffer[0], 256, ImVec2(-1.0f, 0.0f), flags, nullptr, app)) {
				const uint32_t len = (uint32_t)strlen(app->m_StdInBuffer);
				app->m_StdInBuffer[len] = '\n';
				app->m_StdInBuffer[len + 1] = '\0';
			}
			app->m_StdInInputForceUpdate = false;
		}
	}
	ImGui::End();

	if (!opened) {
		app->m_WinVis &= ~UI_WIN_TERMINAL;
	} else {
		app->m_WinVis |= UI_WIN_TERMINAL;
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

	doWin_Terminal(app);
}

void glfw_errorCallback(int error, const char* description)
{
	RISCV_CHECK(false, "GLFW Error %d: %s", error, description);
	printf("GLFW Error %d: %s\n", error, description);
}

int main()
{
	App app(UI_WIN_SETUP | UI_WIN_DEBUG | UI_WIN_REGISTERS | UI_WIN_BREAKPOINTS);

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

	ImGuiIO& io = ImGui::GetIO();
	io.Fonts->AddFontDefault();
	app.m_MonoFont = io.Fonts->AddFontFromFileTTF("./Px437_IBM_CGA.ttf", 8.0f);

	const ImVec4 clear_color = ImColor(114, 144, 154);

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
					const uint32_t stdInBufLen = (uint32_t)strlen(app.m_StdInBuffer);
					if (stdInBufLen != 0) {
						if (riscv::device::uartReceive(app.m_ConsoleUART, app.m_StdInBuffer[0])) {
							// 1 character consumed by the CPU.
							bx::memCopy(&app.m_StdInBuffer[0], &app.m_StdInBuffer[1], strlen(app.m_StdInBuffer));
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
	}

	// Cleanup
	ImGui_ImplGlfw_Shutdown();
	glfwTerminate();

	return 0;
}
