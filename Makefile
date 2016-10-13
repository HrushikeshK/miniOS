
C_SOURCES = $(wildcard kernel/*.c)
BIN_DIR = bin
OBJ_DIR = obj

# create source file names into object filenames
OBJ1 = ${C_SOURCES:.c=.o}
# notdir removes prifixed directories
OBJ = $(notdir $(OBJ1))		

all : os-image.bin

# $^ is substituted with all of the target's dependency files
bin/kernel.bin : obj/kernel_entry.o $(OBJ_DIR)/${OBJ}
	ld -m elf_i386 -o $@ -Ttext 0x1000 --oformat binary $^

# generic rule for building 'somefile.o' from 'somefile.c'
# $< is the first dependency and $@ is the target file
$(OBJ_DIR)/%.o : kernel/%.c
	gcc -ffreestanding -c $< -m32 -o $@

# assemble the kernel_entry
$(OBJ_DIR)/%.o : boot/%.asm
	nasm $< -f elf -o $@

$(BIN_DIR)/%.bin : boot/%.asm
	nasm -f bin $< -o $@

os-image.bin : bin/boot.bin bin/kernel.bin
	cat $^ > os-image.bin

run : all
	qemu-system-x86_64 os-image.bin

clean: 
	rm *.bin kernel/*.o boot/*.bin boot/*.o bin/*.bin obj/*.o || :
	