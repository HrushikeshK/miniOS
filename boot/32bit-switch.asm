[bits 16]

switch_to_pm:
	cli 	; 1. Disable interrupts
	lgdt[gdt_descriptor]	; Load gdt
	
	mov bx, LOAD_GDT
	call print
	call print_nl

	mov bx, MSG_PROT_MODE
	call print
	call print_nl
	
	mov eax, cr0 		
	or eax, 0x1		; Set bit 0 to 1
	mov cr0, eax
	
	jmp CODE_SEG:init_pm 	; 4. Far jump using a different segment

[bits 32]

init_pm:
	mov ax, DATA_SEG 	; 5. Update segment registers
	mov ds, ax		
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000	; 6. update the stack right at the top of the free space
	mov esp, ebp

	call BEGIN_PM  ; 7. Call a well-known label with useful code

	





