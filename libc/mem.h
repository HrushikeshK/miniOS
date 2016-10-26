#ifndef MEM_H
#define MEM_H

#include <stdint.h>
#include <stddef.h>

void memory_copy(char* source, char* dest, int nbytes);
void memory_set(uint8_t *dest, uint8_t val, uint32_t len);

/* There is no 'free' implemented */
uint32_t kmalloc(uint32_t size, int align, uint32_t* physical_addr);

#endif
