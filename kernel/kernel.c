#include "../drivers/screen.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

void main() {
  kprint("Protected Mode enabled\n");
  kprint("Kernel Loaded\n\n");
 // clear_screen();

  isr_install();
  /* Test Interrupts */
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
  

 }