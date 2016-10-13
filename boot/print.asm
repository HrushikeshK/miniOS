print:
	pusha

start:
	mov al, byte[bx]
	cmp al, 0		; Check for end of character
	je done

	mov ah, 0x0e	; tty mode

	int 0x10

	inc bx
	jmp start

done:
	popa
	ret

print_nl:
	pusha

	mov ah, 0x0e
	mov al, 0x0a		; Newline
	int 0x10

	mov al, 0x0d		; carriage return
	int 0x10

	popa
	ret
