#include <stdint.h>
//#include <stdio.h>
//#include <string.h>
//#include <unistd.h>
//#include <malloc.h>

//uint32_t readLine(char* input, uint32_t len)
//{
//    char* dst = input;
//    char c;
//
//    uint32_t numRead = sys_read(STDIN_FILENO, &c, 1);
//    while(!numRead || (numRead && c != '\n')) {
//        if(numRead && c != 0) {
//            *dst++ = c;
//
//            // echo
//            sys_write(STDOUT_FILENO, &c, 1);
//
//            if(dst - input == len - 1) {
//                break;
//            }
//        }
//
//        numRead = sys_read(STDIN_FILENO, &c, 1);
//    }
//
//    *dst = '\0';
//
//    c = '\n';
//    sys_write(STDOUT_FILENO, &c, 1);
//
//    return (uint32_t)(dst - input);
//}

int main()
{
//	printf("Allocating 64 integers...\n");
//	int* ptr = (int*)malloc(sizeof(int) * 64);
//	printf("ptr = %p\n", ptr);
//
//	printf("Assigning values...\n");
//	for(uint32_t i = 0;i < 64;++i) {
//		*ptr++ = i;
//	}
//	printf("Freeing...\n");
//	free(ptr);

//    char input[256] = {0};
//
//    const char* prompt = "> ";
//
//    while(1) {
//        write(STDOUT_FILENO, prompt, strlen(prompt));
//        uint32_t inputLen = readLine(input, 256);
//
//        if(input[0] == '\0') {
//            continue;
//        } else if(!strcmp(input, "exit")) {
//            break;
//        } else {
//            write(STDOUT_FILENO, "Unknown command: ", 17);
//            write(STDOUT_FILENO, input, inputLen);
//            write(STDOUT_FILENO, "\n", 1);
//        }
//    }

	return 0;
}
