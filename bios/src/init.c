#include <stdint.h>
#include "libkernel/kernel.h" // kinit()/kpanic()
#include "libkernel/stdio.h" // kprintf()/kputs()/kmount()

extern int shell_main();

void _init()
{
	kinit();

	kputs("Mounting HDD partition #0 to '/'");
	if(kmount("/dev/sda1", "/", "auto", 0, 0)) {
		kputs("(x) Failed mount HDD partition #0");
	}

	kchdir("/");

	int res = shell_main();

	kshutdown();
	kpanic("HALT");
}
