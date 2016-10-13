[bits 16]
disk_load:
	pusha
	; reading from disk requires setting specific values in all registers
	; so we weill overwrite our input parametrs from 'dx'. Let's save it
	; to the stack for later use.

	push dx
	

load_again:
	mov ah, 0x02	; ah <- int 0x13 function. 0x02 = 'read'
	mov al, dh		; al <- number of sectors to read
	mov cl, 0x02		; cl <- sector
					; 0x01 is our boot sector, 0x02 is the first available sector
	mov ch, 0x00	; ch <- cylinder
	; dl <- driver number. Caller sets it as a paramter and gets it form BIOS
	; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
	mov dh, 0x00	; dh <- head number

	; [es:bx] <- pointer to buffer where the data will be stored
	; caller sets it for us, and it is actually the standard location for int 13h
	int 0x13 		; BIOS interrupt

	jc disk_error

	pop dx

	cmp al, dh		; BIOS also sets 'al' to the number of sectors read. Compare it.
	jne sectors_error

	popa
	ret


disk_error:
	mov bx, DISK_ERROR
	call print
	call print_nl
	mov dh, ah		; ah = error code, dl = disk drive that dropped the error
	call print_hex	
	jmp disk_loop



sectors_error:
	mov bx, SECTORS_ERROR
	call print

disk_loop:
	jmp $


DISK_ERROR db "Disk read error", 0
SECTORS_ERROR db "Incorrect number of sectors read", 0