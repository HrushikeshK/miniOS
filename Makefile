
C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)

# create source file names into object filenames
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

CC = gcc
GDB = gdb
# -g: Use debugging symbols in gcc
CFLAGS = -g -m32 -ffreestanding -Wall -Wextra -fno-exceptions

all : os-image.bin

# assemble the kernel_entry
%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm -f bin $< -o $@

# generic rule for building 'somefile.o' from 'somefile.c'
# $< is the first dependency and $@ is the target file
%.o : %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ 

# $^ is substituted with all of the target's dependency files
kernel/kernel.bin : boot/kernel_entry.o ${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 --oformat binary $^

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

os-image.bin : boot/boot.bin kernel/kernel.bin
	cat $^ > os-image.bin

run : all
	qemu-system-x86_64 -fda os-image.bin

clean: 
	rm *.bin kernel/*.o boot/*.bin boot/*.o kernel/*.bin drivers/*.o \
	*.elf cpu/*.o libc/*.o || :
	