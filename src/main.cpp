#include "elf/parser.h"
#include "riscv/cpu.h"
#include "debugger.h"
#include "memory.h"
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

#define INIT_ERR_SUCCESS     0
#define INIT_ERR_NO_MEMORY   1
#define INIT_ERR_INVALID_ELF 2

#define UI_WIN_SETUP       0x00000001
#define UI_WIN_DEBUG       0x00000002
#define UI_WIN_REGISTERS   0x00000004
#define UI_WIN_BREAKPOINTS 0x00000008

struct App
{
	GLFWwindow* m_GLFWWindow;
	riscv::CPU* m_CPU;
	Memory* m_RAM;
	Debugger* m_Dbg;

	uint8_t* m_ELFData;
	uint32_t m_ELFSize;
	int m_RAMSizeMB;
	int m_StackSizeKB;
	int m_InitError;
	bool m_ScrollToPC;
	uint32_t m_NumCPUSteps;
	bool m_Run;

	uint32_t m_WinVis;

	App(uint32_t visibleWindows) 
		: m_GLFWWindow(nullptr)
		, m_CPU(nullptr)
		, m_RAM(nullptr)
		, m_Dbg(nullptr)
		, m_WinVis(visibleWindows)
		, m_ELFData(nullptr)
		, m_ELFSize(0)
		, m_InitError(INIT_ERR_SUCCESS)
		, m_RAMSizeMB(4)
		, m_StackSizeKB(128)
		, m_ScrollToPC(true)
		, m_NumCPUSteps(0)
		, m_Run(false)
	{}

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
	const uint32_t stackSize = (uint32_t)app->m_StackSizeKB << 10;

	Memory* mem = memCreate(ramSize);
	if (!mem) {
		return INIT_ERR_NO_MEMORY;
	}

	// Create a RW region for the stack at the end of the address space
	memAddRegion(mem, ramSize - stackSize, stackSize, RegionFlags::Read | RegionFlags::Write);

	elf::Info elfInfo = elf::load(app->m_ELFData, mem);
	if (elfInfo.m_EntryPointAddr == ~0u) {
		return INIT_ERR_INVALID_ELF;
	}

	sys__init(mem, elfInfo.m_InitialBreak);

	riscv::CPU* cpu = (riscv::CPU*)malloc(sizeof(riscv::CPU));
	riscv::cpuReset(cpu, elfInfo.m_EntryPointAddr, ramSize - 4);

	app->m_CPU = cpu;
	app->m_RAM = mem;
	app->m_Dbg = dbgCreate();
	app->m_ScrollToPC = true;

	return INIT_ERR_SUCCESS;
}

void shutdownEmulator(App* app)
{
	free(app->m_CPU);
	app->m_CPU = nullptr;

	memDestroy(app->m_RAM);
	app->m_RAM = nullptr;

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

			ImGui::EndMenu();
		}

		ImGui::EndMainMenuBar();
	}
}

void doWin_Setup(App* app)
{
	ImGui::SetNextWindowSize(ImVec2(300, 300), ImGuiSetCond_FirstUseEver);
	ImGui::SetNextWindowPos(ImVec2(0, 20), ImGuiSetCond_FirstUseEver);

	bool opened = (app->m_WinVis & UI_WIN_SETUP) != 0;
	if (ImGui::Begin("Setup", &opened, ImGuiWindowFlags_ShowBorders)) {
		if (!app->m_CPU) {
			ImGui::SliderInt("RAM [MB]", &app->m_RAMSizeMB, 1, 16);
			ImGui::SliderInt("Stack [KB]", &app->m_StackSizeKB, 8, 1024);

			static char elfFilename[_MAX_PATH] = { 0 }; // TODO: Move to App?
			ImGui::InputText("##ELF", elfFilename, _MAX_PATH, ImGuiInputTextFlags_ReadOnly);
			ImGui::SameLine();
			if (ImGui::Button("Browse...")) {
				nfdchar_t* outPath = nullptr;
				nfdresult_t result = NFD_OpenDialog(nullptr, nullptr, &outPath);
				if (result == NFD_OKAY) {
					bx::snprintf(elfFilename, _MAX_PATH, "%s", outPath);

					app->m_ELFData = readFile(outPath, app->m_ELFSize);

					free(outPath);
				}
			}
		}

		if (ImGui::CollapsingHeader("ELF Info", ImGuiTreeNodeFlags_DefaultOpen)) {
			if (!app->m_ELFData) {
				ImGui::Text("No ELF loaded yet.");
			} else {
				elf::Elf32_Ehdr* header = (elf::Elf32_Ehdr*)app->m_ELFData;
				if (!elf::isELF32(header->e_ident)) {
					ImGui::Text("Loaded file is not a valid 32-bit ELF file.");
				} else {
					ImGui::Text("Type: %u", header->e_type);
					ImGui::Text("Machine: %u", header->e_machine);
					ImGui::Text("Version: %u", header->e_version);
					ImGui::Text("Entry: %08Xh", header->e_entry);
					ImGui::Text("Flags: %08Xh", header->e_flags);
					
					// TODO: Show program/section headers
					if (ImGui::CollapsingHeader("Program headers")) {
						ImGui::Text("Not implemented yet.");
					}
					if (ImGui::CollapsingHeader("Section headers")) {
						ImGui::Text("Not implemented yet.");
					}
				}
			}
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
			if (app->m_ELFData) {
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
				if (ImGui::Button("Run")) {
					app->m_NumCPUSteps = 1;
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
			}

			const float lineHeight = ImGui::GetTextLineHeightWithSpacing();

			const uint32_t numWords = app->m_RAM->m_Size / 4; // TODO: Disassemble only the .text section.
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
				uint32_t maxAddr = bx::uint32_min(scrollAddr + numLinesVisible * 4, app->m_RAM->m_Size - 4);
				if (app->m_ScrollToPC && (pc <= minAddr || pc >= maxAddr)) {
//					if (pc < minAddr) {
						minAddr = pc > 8 ? pc - 8 : 0;
						maxAddr = bx::uint32_min(minAddr + numLinesVisible * 4, app->m_RAM->m_Size - 4);
//					} else {
//						maxAddr = bx::uint32_min(pc + 8, app->m_RAM->m_Size - 4);
//						minAddr = maxAddr > numLinesVisible * 4 ? maxAddr - numLinesVisible * 4 : 0;
//					}

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
					uint32_t instr = *(uint32_t*)memVirtualToPhysical(app->m_RAM, addr);

					char disasm[256];
					riscv::disasmInstruction(instr, addr, disasm, 256);

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

				uint32_t nextInstr = *(uint32_t*)memVirtualToPhysical(app->m_RAM, pc);
				riscv::disasmGetInstrOperandValues(app->m_CPU, app->m_RAM, nextInstr, pc, str, 1024);

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
				, riscv::cpuGetRegister(app->m_CPU, 1)
				, riscv::cpuGetRegister(app->m_CPU, 2)
				, riscv::cpuGetRegister(app->m_CPU, 3)
				, riscv::cpuGetRegister(app->m_CPU, 4)
				, riscv::cpuGetRegister(app->m_CPU, 5)
				, riscv::cpuGetRegister(app->m_CPU, 6)
				, riscv::cpuGetRegister(app->m_CPU, 7)
				, riscv::cpuGetRegister(app->m_CPU, 8)
				, riscv::cpuGetRegister(app->m_CPU, 9)
				, riscv::cpuGetRegister(app->m_CPU, 10)
				, riscv::cpuGetRegister(app->m_CPU, 11)
				, riscv::cpuGetRegister(app->m_CPU, 12)
				, riscv::cpuGetRegister(app->m_CPU, 13)
				, riscv::cpuGetRegister(app->m_CPU, 14)
				, riscv::cpuGetRegister(app->m_CPU, 15)
				, riscv::cpuGetRegister(app->m_CPU, 16)
				, riscv::cpuGetRegister(app->m_CPU, 17)
				, riscv::cpuGetRegister(app->m_CPU, 18)
				, riscv::cpuGetRegister(app->m_CPU, 19)
				, riscv::cpuGetRegister(app->m_CPU, 20)
				, riscv::cpuGetRegister(app->m_CPU, 21)
				, riscv::cpuGetRegister(app->m_CPU, 22)
				, riscv::cpuGetRegister(app->m_CPU, 23)
				, riscv::cpuGetRegister(app->m_CPU, 24)
				, riscv::cpuGetRegister(app->m_CPU, 25)
				, riscv::cpuGetRegister(app->m_CPU, 26)
				, riscv::cpuGetRegister(app->m_CPU, 27)
				, riscv::cpuGetRegister(app->m_CPU, 28)
				, riscv::cpuGetRegister(app->m_CPU, 29)
				, riscv::cpuGetRegister(app->m_CPU, 30)
				, riscv::cpuGetRegister(app->m_CPU, 31));
			//if (ImGui::CollapsingHeader("Registers")) {
			//	ImGui::Text("zero: 00000000h");
			//	ImGui::Text("ra: %08Xh", riscv::cpuGetRegister(app->m_CPU, 1));
			//	ImGui::Text("sp: %08Xh", riscv::cpuGetRegister(app->m_CPU, 2));
			//	ImGui::Text("gp: %08Xh", riscv::cpuGetRegister(app->m_CPU, 3));
			//	ImGui::Text("tp: %08Xh", riscv::cpuGetRegister(app->m_CPU, 4));
			//	ImGui::Text("t0: %08Xh", riscv::cpuGetRegister(app->m_CPU, 5));
			//	ImGui::Text("t1: %08Xh", riscv::cpuGetRegister(app->m_CPU, 6));
			//	ImGui::Text("t2: %08Xh", riscv::cpuGetRegister(app->m_CPU, 7));
			//	ImGui::Text("s0: %08Xh", riscv::cpuGetRegister(app->m_CPU, 8));
			//	ImGui::Text("s1: %08Xh", riscv::cpuGetRegister(app->m_CPU, 9));
			//	ImGui::Text("a0: %08Xh", riscv::cpuGetRegister(app->m_CPU, 10));
			//	ImGui::Text("a1: %08Xh", riscv::cpuGetRegister(app->m_CPU, 11));
			//	ImGui::Text("a2: %08Xh", riscv::cpuGetRegister(app->m_CPU, 12));
			//	ImGui::Text("a3: %08Xh", riscv::cpuGetRegister(app->m_CPU, 13));
			//	ImGui::Text("a4: %08Xh", riscv::cpuGetRegister(app->m_CPU, 14));
			//	ImGui::Text("a5: %08Xh", riscv::cpuGetRegister(app->m_CPU, 15));
			//	ImGui::Text("a6: %08Xh", riscv::cpuGetRegister(app->m_CPU, 16));
			//	ImGui::Text("a7: %08Xh", riscv::cpuGetRegister(app->m_CPU, 17));
			//	ImGui::Text("s2: %08Xh", riscv::cpuGetRegister(app->m_CPU, 18));
			//	ImGui::Text("s3: %08Xh", riscv::cpuGetRegister(app->m_CPU, 19));
			//	ImGui::Text("s4: %08Xh", riscv::cpuGetRegister(app->m_CPU, 20));
			//	ImGui::Text("s5: %08Xh", riscv::cpuGetRegister(app->m_CPU, 21));
			//	ImGui::Text("s6: %08Xh", riscv::cpuGetRegister(app->m_CPU, 22));
			//	ImGui::Text("s7: %08Xh", riscv::cpuGetRegister(app->m_CPU, 23));
			//	ImGui::Text("s8: %08Xh", riscv::cpuGetRegister(app->m_CPU, 24));
			//	ImGui::Text("s9: %08Xh", riscv::cpuGetRegister(app->m_CPU, 25));
			//	ImGui::Text("s10: %08Xh", riscv::cpuGetRegister(app->m_CPU, 26));
			//	ImGui::Text("s11: %08Xh", riscv::cpuGetRegister(app->m_CPU, 27));
			//	ImGui::Text("t3: %08Xh", riscv::cpuGetRegister(app->m_CPU, 28));
			//	ImGui::Text("t4: %08Xh", riscv::cpuGetRegister(app->m_CPU, 29));
			//	ImGui::Text("t5: %08Xh", riscv::cpuGetRegister(app->m_CPU, 30));
			//	ImGui::Text("t6: %08Xh", riscv::cpuGetRegister(app->m_CPU, 31));
			//}
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

	const ImVec4 clear_color = ImColor(114, 144, 154);

	while (!glfwWindowShouldClose(app.m_GLFWWindow)) {
		glfwPollEvents();
		ImGui_ImplGlfw_NewFrame();

		doUI(&app);

		if (app.m_CPU && app.m_RAM) {
			if (app.m_NumCPUSteps != 0) {
				uint32_t ns = app.m_NumCPUSteps;
				bool breakpointReached = false;
				while (ns-- > 0) {
					riscv::cpuTick_SingleCycle(app.m_CPU, app.m_RAM);
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
