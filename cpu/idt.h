#ifndef IDT_H
#define IDT_H

#include <stdint.h>

/* segment selectors */
#define KERNEL_CS 0x08

/* How every interrupt handler (gate) is defined */
typedef struct {
	uint16_t low_offset;		/* lower 16 bits of handler function address */
	uint16_t sel;			/* Kernel segment selector */
	uint8_t always0;		
	/* First Byte
	 * Bit 7	:	"Interrupt is presesnt"
	 * Bit 6-5	: 	Privilege level of caller (0=kernel.. 3=user)
	 * Bit 4	:	Set to 0 for interrupt gates
	 * Bits 3-0	: 	bits 1110 = decimal 14 = "32 bit interrupt gate" 
	 */
	uint8_t flags;
	uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;

/* A pointer to the array of the interrupt handlers
 * Assembly instruction 'lidt' will read it 
 */
typedef struct {
	uint16_t limit;
	uint32_t base;
} __attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;


/* Functions implemented idt.c */
void set_idt_gate(int n, uint32_t handler);
void set_idt();

#endif
