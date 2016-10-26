[bits 32]
[extern kernel_main]
global _start

_start:
	call kernel_main
	jmp $
