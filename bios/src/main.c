#include <stdint.h>
#include "file_system.h"
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

void listCWD(struct FileSystem* fs)
{
	struct FileSystemDir* rootDir = fsOpenDir(fs, ".");
	if (rootDir) {
		struct FileSystemDirEnt* fsde;
		while ((fsde = fsReadDir(fs, rootDir)) != 0) {
			const uint8_t attrs = fsde->m_DirEntry.m_Attrs;
			char attrStr[6] = "-----";
			if (attrs & ATTR_ARCHIVE) {
				attrStr[0] = 'a';
			}
			if (attrs & ATTR_DIRECTORY) {
				attrStr[1] = 'd';
			}
			if (attrs & ATTR_HIDDEN) {
				attrStr[2] = 'h';
			}
			if (attrs & ATTR_READ_ONLY) {
				attrStr[3] = 'r';
			}
			if (attrs & ATTR_SYSTEM) {
				attrStr[4] = 's';
			}

			kprintf("%s %s %u\n", attrStr, fsde->m_FilenameLong, fsde->m_DirEntry.m_FileSize);
		}

		fsCloseDir(fs, rootDir);
	}
}

int main()
{
	extern struct FileSystem* g_FS;

	char input[256];

	while(1) {
		kprintf("> ");
		kgets(input);

		if(input[0] == '\0') {
			continue;
		} else if(!kstrcmp(input, "exit")) {
			break;
		} else if(!kstrcmp(input, "ls")) {
			if(g_FS) {
				listCWD(g_FS);
			} else {
				kprintf("No valid file system found.\n");
			}
		} else if(!kstrncmp(input, "cd ", 3)) {
			if(g_FS) {
				const char* folderName = kstrchr(input, ' ');
				if(!folderName) {
					kprintf("Invalid folder name.\n");
				} else {
					++folderName;
					kprintf("Entering folder \"%s\"...\n", folderName);
					if(fsChangeDir(g_FS, folderName)) {
						kprintf("Folder %s not found.\n", folderName);
					}
				}
			} else {
				kprintf("No valid file system found.\n");
			}
		} else {
			kprintf("Unknown command: %s\n", input);
		}
	}

	return 0;
}
