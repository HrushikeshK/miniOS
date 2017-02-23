[ORG 0x7c00]

KERNEL_OFFSET equ 0x1000
	
	mov [BOOT_DRIVE], dl	; BIOS stores our boot drive in dl

	; These instructions are executed in 16 bit mode
	mov bp, 0x9000		; set stack
	mov sp, bp

	; Change display to text mode
	mov ax, 3
	int 0x10

	mov bx, MSG_REAL_MODE
	call print
	call print_nl

	call load_kernel 	; load kernel
	call switch_to_pm
	jmp $

	%include "boot/print.asm"
	%include "boot/print_hex.asm"
	%include "boot/32bit-switch.asm"
	%include "boot/32bit-print.asm"
	%include "boot/gdt.asm"
	%include "boot/disk_load.asm"

[bits 16]
load_kernel:
	mov bx, MSG_LOAD_KERNEL
	call print
	call print_nl

	mov bx, KERNEL_OFFSET
	mov dh, 31		; Our future kernel will be larger, make this big
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret


[bits 32]
; Beginning of protected mode
BEGIN_PM:
	call KERNEL_OFFSET		; jump to position where our kernel is loaded

	jmp $	

	BOOT_DRIVE db 0
	MSG_LOAD_KERNEL db "Loading kernel into memory", 0
	MSG_REAL_MODE db "Started in 16-bit real mode", 0
	MSG_PROT_MODE db "Switching to 32-bit protected mode", 0
	HELLO db "HELLO", 0
	LOAD_GDT db "GDT loaded", 0

	TIMES 510 - ($ - $$) db 0
	dw 0xAA55