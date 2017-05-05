#include <stdint.h>
#include "kernel.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../libc/string.h"
#include "../libc/mem.h"

void kernel_main() 
{
	kprint("Protected Mode enabled\n");
	kprint("Running in kernel space\n");

	isr_install();
	irq_install();

	kprint("\nType something, it will go through the kernel\n"
		"Type END to halt the CPU\n> ");

}

void user_input(char *input) 
{
	if (strcmp(input, "END") == 0) {
		kprint("Stopping the CPU. BYE!\n");
		asm volatile("hlt");
	} else if (strcmp(input, "PAGE") == 0) {
		uint32_t phys_addr;
		uint32_t page = kmalloc(1000, 1, &phys_addr);
		char page_str[16] = "";
		hex_to_ascii(page, page_str);
		char phys_str[16] = "";
		hex_to_ascii(phys_addr, phys_str);
		kprint("Page: ");
		kprint(page_str);
		kprint(", physical address: ");
		kprint(phys_str);
		kprint("\n");
	} else if(strcmp(input, "clear") == 0) {
		clear_screen();		
	} else if(strcmp(input,"int 0") == 0) {
		asm volatile("int $0");
	} else if(strcmp(input, "help") == 0) {
		kprint("These are the commands that work so far:\n\n");
		kprint(" PAGE: Simulation of malloc (1000 bytes)\n");
		kprint(" clear: Clear screen\n");
		kprint(" int 0: Interrupt 0\n");
		kprint(" help: Display this\n");
		kprint(" END: Simulate shutdown\n");
	} else {
		kprint("Command not found: ");
		kprint(input);
		kprint("\n");
	}
	kprint("\n> ");
}
