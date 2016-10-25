[bits 32]

%define VIDEO_MEMORY 0xb8000	; Location of VGA display
%define WHITE_ON_BLACK 0x0f		; color byte for each character

print_string_pm:
	pusha

	mov edi, VIDEO_MEMORY
	
print_string_pm_loop:
	mov al, [ebx]	; ebx is the address of character
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je print_string_pm_done

	mov word[edi], ax	; store char + attr in video memory
	add ebx, 1
	add edi, 2
	
	jmp print_string_pm_loop

print_string_pm_done:
	popa
	ret
	