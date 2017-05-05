
; Creating gdt to load later at the time of switch from 16bit to 32bit mode

gdt_start:
	; GDT starts with a null 8-byte
	dd 0x0
	dd 0x0

; GDT for code segment base = 0x00000000, limit = 0xfffff
gdt_code:
	dw 0xffff		; segment length, bits 0-15
	dw 0x0			; segment base, bits 16-31
	db 0x0			; segment base, bits 32-39
	db 10011010b	; flags (Access byte) 8 bits
	db 11001111b	; flags(4 bits) + segment length bits 48-51
	db 0x0 			; segment base bits 56-63

gdt_data:
	dw 0xffff		; segment length, bits 0-15
	dw 0x0			; segment base, bits 16-31
	db 0x0			; segment base, bits 32-39
	db 10010010b	; flags 8 bits
	db 11001111b	; flags(4 bits) + segment length bits 48-51
	db 0x0 			; segment base bits 56-63

gdt_end:

; GDT descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1	; size (16bit), always one bit less that true size
	dd gdt_start


CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start