#include "timer.h"
#include "isr.h"
#include "ports.h"
#include "../libc/function.h"

uint32_t tick = 0;

static void timer_callback(registers_t regs) 
{
	tick++;
	UNUSED(regs);
}

void init_timer(uint32_t freq) 
{
	/* Install the function we just wrote */
	register_interrupt_handler(IRQ0, timer_callback);

	/* Get the PIT value: hardwaqre clock at 1193180Hz */
	uint32_t divisor = 1193180 / freq;
	uint8_t low = (uint8_t)(divisor & 0xFF);
	uint8_t high = (uint8_t)((divisor >> 8) & 0xFF);
	/* Send the command */
	port_byte_out(0x43, 0x36); /* Command Port */
	port_byte_out(0x40, low);  /* Channel 0 data port (read/write) */
	port_byte_out(0x40, high);
}
