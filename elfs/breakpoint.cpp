#include <stdio.h>

int main()
{
	printf("Breakpoint test\n");
	printf("If you have a debugger attached, it should stop at the following line.\n");

	asm volatile ("ebreak");

	printf("Test completed.\n");

	return 0;
}