TARGET = bios

ASM_SRCS += ./entry.S

C_SRCS += ./shell.c
C_SRCS += ./init.c
C_SRCS += ./syscall.c
C_SRCS += ./exception_handler.c
C_SRCS += ./cmd_line.c

HEADERS += ./exception_handler.h
HEADERS += ./syscall.h
HEADERS += ./cmd_line.h

C_SRCS += ./devices/uart.c
C_SRCS += ./devices/ram.c
C_SRCS += ./devices/hdd.c
HEADERS += ./devices/hal.h
HEADERS += ./devices/hdd.h
HEADERS += ./devices/ram.h
HEADERS += ./devices/uart.h

C_SRCS += ./libkernel/kernel.c
C_SRCS += ./libkernel/memory.c
C_SRCS += ./libkernel/printf.c
C_SRCS += ./libkernel/malloc.c
C_SRCS += ./libkernel/string.c
C_SRCS += ./libkernel/ctype.c
C_SRCS += ./libkernel/fs.c
C_SRCS += ./libkernel/task.c
C_SRCS += ./libkernel/internal/file_system.c
C_SRCS += ./libkernel/internal/elf.c
C_SRCS += ./libkernel/internal/page_table.c
HEADERS += ./libkernel/kernel.h
HEADERS += ./libkernel/memory.h
HEADERS += ./libkernel/stdio.h
HEADERS += ./libkernel/malloc.h
HEADERS += ./libkernel/string.h
HEADERS += ./libkernel/ctype.h
HEADERS += ./libkernel/task.h
HEADERS += ./libkernel/internal/file_system.h
HEADERs += ./libkernel/internal/elf.h
HEADERS += ./libkernel/internal/page_table.h

LINKER_SCRIPT := ./link.lds

INCLUDES += -I.

ASM_OBJS := $(patsubst %.S,%.o,$(ASM_SRCS))
C_OBJS := $(patsubst %.c,%.o,$(C_SRCS))

CC := riscv32-unknown-elf-gcc
CFLAGS := -O2 -march=rv32i -fno-common -fno-jump-tables $(INCLUDES) $(C_DEFINES)
LDFLAGS := -T $(LINKER_SCRIPT) -nostdlib -nostartfiles -lgcc

$(TARGET): $(ASM_OBJS) $(C_OBJS) $(LINKER_SCRIPT)
	$(CC) $(CFLAGS) $(ASM_OBJS) $(C_OBJS) -o $@ $(LDFLAGS)

$(ASM_OBJS): %.o: %.S $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

$(C_OBJS): %.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

default: $(TARGET)

all: default

clean:
	rm -f $(TARGET) *.o ./*.o ./libkernel/*.o ./libkernel/internal/*.o ./devices/*.o

.PHONY: clean all default