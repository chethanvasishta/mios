	mov ax, 0x07C0 	; Start of the bootloader in X86
	mov ds, ax	; DS should be initialized for variables to be referenced with this offset

	mov si, msg
	call bios_print

hang:
	jmp hang

bios_print:		; prints a string pointed to by [DS:SI]
ploop:	lodsb		; load string byte, loads a string byte from [DS:SI] to AL
	or al, al
	jz doneprint	; done printing
	mov ah, 0x0E	; type of display; 0E = teletype, single character print
	int 0x10	; display
	jmp ploop
doneprint:
	ret

;strings
msg db 'Chethan Bootloader'	
	times 510-($-$$) db 0 ;Fill the obj file with 0 upto 510 bytes from here, $ = start of current instruction, $$ = Beginning of file
	db 0x55	; Bootloader Magic Footers
	db 0xAA
