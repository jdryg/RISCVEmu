#include "elf/parser.h"
#include "riscv/cpu.h"
#include "debug.h"
#include "memory.h"
#include "syscall.h"

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

#define UI_WIN_SETUP  0x00000001
#define UI_WIN_DEBUG  0x00000002

struct App
{
	GLFWwindow* m_GLFWWindow;
	riscv::CPU* m_CPU;
	Memory* m_RAM;

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

	return INIT_ERR_SUCCESS;
}

void shutdownEmulator(App* app)
{
	free(app->m_CPU);
	app->m_CPU = nullptr;

	memDestroy(app->m_RAM);
	app->m_RAM = nullptr;
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
			if (ImGui::Button("Go to PC")) {
				app->m_ScrollToPC = true;
			}
			ImGui::SameLine();
			if (app->m_Run) {
				if (ImGui::Button("Stop")) {
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

			ImGui::SetNextWindowContentSize(ImVec2(0.0f, numWords * lineHeight));
			if (ImGui::ListBoxHeader("##disasm", ImVec2(-1, -1))) {
				const float scrollY = app->m_ScrollToPC ? (pc / 4) * lineHeight : ImGui::GetScrollY();
				const uint32_t scrollAddr = 4 * (uint32_t)bx::ffloor(scrollY / lineHeight);

				ImGui::SetCursorPosY(scrollY);

				const float winHeight = ImGui::GetWindowHeight();
				const uint32_t numLinesVisible = (uint32_t)bx::fceil(winHeight / lineHeight);

				const uint32_t minAddr = scrollAddr;
				const uint32_t maxAddr = bx::uint32_min(scrollAddr + numLinesVisible * 4, app->m_RAM->m_Size - 4);

				for (uint32_t addr = minAddr; addr <= maxAddr; addr += 4) {
					uint32_t ir = *(uint32_t*)memVirtualToPhysical(app->m_RAM, addr);
					char disasm[256];
					riscv::disasmInstruction(ir, addr, disasm, 256);
					ImGui::Selectable(disasm, addr == pc);

					if (app->m_ScrollToPC && addr == pc) {
						ImGui::SetScrollHere();
						app->m_ScrollToPC = false;
					}
				}

				ImGui::ListBoxFooter();
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

void doUI(App* app)
{
	doMainMenu(app);

	if (app->m_WinVis & UI_WIN_SETUP) {
		doWin_Setup(app);
	}
	if (app->m_WinVis & UI_WIN_DEBUG) {
		doWin_Debugger(app);
	}
}

void glfw_errorCallback(int error, const char* description)
{
	RISCV_CHECK(false, "GLFW Error %d: %s", error, description);
	printf("GLFW Error %d: %s\n", error, description);
}

int main()
{
	App app(UI_WIN_SETUP | UI_WIN_DEBUG);

	// Setup window
	glfwSetErrorCallback(glfw_errorCallback);
	if (!glfwInit()) {
		return -1;
	}

	app.m_GLFWWindow = glfwCreateWindow(800, 600, "RISC-V Emulator (RV32I)", nullptr, nullptr);
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
				while (ns-- > 0) {
					riscv::cpuTick_SingleCycle(app.m_CPU, app.m_RAM);
				}

				app.m_NumCPUSteps = app.m_Run ? app.m_NumCPUSteps : 0;
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
