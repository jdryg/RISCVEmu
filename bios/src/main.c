#include <stdint.h>
#include "libkernel/malloc.h"
#include "libkernel/printf.h"
#include "libkernel/string.h"

#define KEY_LEFT_ARROW 1
#define KEY_RIGHT_ARROW 4
#define KEY_HOME 2
#define KEY_END 3
#define KEY_DELETE 127
#define KEY_BACKSPACE 8
#define KEY_ESCAPE 27
#define KEY_TAB '\t'

#define CONSOLE_COMMAND 0xFF
#define CONSOLE_CMD_DEL_PREV 0

char kgetchar()
{
	char c;
	while(!sys_read(0, &c, 1));
	return c;
}

char* kgets(char* s)
{
    char* ch = s;
    char k;

    /* until we read a newline */
    while ((k = kgetchar()) != '\n') {
        if (k == -1) {
            /* EOF at start of line or errors other than EOF return NULL */
            if (ch == s /*|| !feof(stdin)*/) {
				return 0;
			}
            break;
		}
		
		switch(k) {
		case KEY_LEFT_ARROW:
			continue;
		case KEY_RIGHT_ARROW:
			continue;
		case KEY_HOME:
			continue;
		case KEY_END:
			continue;
		case KEY_DELETE:
			continue;
		case KEY_BACKSPACE:
			// Send delete char command to console.
			if(ch > s) {
				--ch;

				uint8_t consoleCmd[3] = {
					CONSOLE_COMMAND,
					CONSOLE_CMD_DEL_PREV,
					1
				};
				sys_write(1, &consoleCmd[0], 3);
			}
			continue;
		case KEY_ESCAPE:
			continue;
		default:
			// Echo
			// TODO: Q: Should this be handle by the console itself?
			sys_write(1, &k, 1);
			break;		
		}

        /* character is stored at address, and pointer is incremented */
        *ch++ = k;
    }

    /* Null-terminating character added */
	*ch = '\0';
	
	k = '\n';
	sys_write(1, &k, 1);
	
    /* return original pointer */
    return s;
}

int main()
{
	char input[256];

	while(1) {
		kprintf("> ");
		kgets(input);

		if(input[0] == '\0') {
			continue;
		} else if(!kstrcmp(input, "exit")) {
			break;
		} else {
			kprintf("Unknown command: %s\n", input);
		}
	}

	return 0;
}
