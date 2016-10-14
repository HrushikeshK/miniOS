#include "../drivers/screen.h"
#include "util.h"

void main() {
  clear_screen();
  // kprint("\nKernel loaded\n");
  // kprint("Hello world!\n");
  // kprint("Hello world\n");
  // kprint_at("X", 1, 6);
  // kprint_at("This Text spans multiple lines", 75, 10);
  // kprint_at("There is line\nbreak", 0, 20);
  // kprint_at("What happens when we run out of space?\n", 45, 24);
  

  // Fill up the screen
  int i = 0;
  char str[255];
  for (i = 0; i < 24; i++) {
    int_to_ascii(i, str);
    kprint_at(str, 0, i);
  }

  kprint_at("This text forces the kernel to scroll. Row 0 will disappear.\n", 60, 24);
  kprint("And with this text, the kernel will scroll again, and row 1 will disappear too!");

 }