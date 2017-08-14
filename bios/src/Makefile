TARGET = bios

ASM_SRCS += ./entry.S

C_SRCS += ./main.c
C_SRCS += ./init.c
C_SRCS += ./syscall.c
C_SRCS += ./uart.c
C_SRCS += ./ram.c
C_SRCS += ./exception_handler.c

LINKER_SCRIPT := ./link.lds

INCLUDES += -I.

ASM_OBJS := $(patsubst %.S,%.o,$(ASM_SRCS))
C_OBJS := $(patsubst %.c,%.o,$(C_SRCS))

CC := riscv32-unknown-elf-gcc
CFLAGS := -O2 -march=rv32i -fno-common -fno-jump-tables $(INCLUDES) $(C_DEFINES)
LDFLAGS := -T $(LINKER_SCRIPT) -nostdlib -nostartfiles -lc -lgcc

$(TARGET): $(ASM_OBJS) $(C_OBJS) $(LINKER_SCRIPT)
	$(CC) $(CFLAGS) $(C_OBJS) -o $@ $(LDFLAGS)

$(ASM_OBJS): %.o: %.S $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

$(C_OBJS): %.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c -o $@ $<

default: $(TARGET)

all: default

clean:
	rm -f $(TARGET) *.o ./*.o

.PHONY: clean all default