#include "ports.h"

/*
 * Read a byte from the specified port
 */

unsigned char port_byte_in(unsigned short port) 
{
	/*
	 * Inline assembler syntax
	 * Uses AT&T style
	 * Extra % is used as escape character by c compiler
	 * "=a" (result); set '=' the the C variable '(result)' to the value of e<a>x
	 * "d" (port); map the c variable (port) into e<d>x register
	 * Inputs and outputs are separated by colons
	 */

	unsigned char result;
	__asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
	return result;
}


void port_byte_out(unsigned short port, unsigned char data) 
{
	/* Both registers are mapped to C variables and nothing is returned,
	 * Thus o equals '=' in the asm syntax.
	 * However we see a comma since there are two variables in the input area
	 * and none in the 'return' area
	 */

	__asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}


unsigned short port_word_in(unsigned short port)
{
	unsigned short result;

	__asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
	return result;
}


void port_word_out(unsigned short port, unsigned short data) 
{
	__asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}

