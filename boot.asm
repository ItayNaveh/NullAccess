[org 0x7C00]
[bits 16]

mov ah, 0x02 ; sub interrup num for reading
mov al, 17 ; how many sectors to read (kernel.bin size / 512)
mov ch, 0 ; cylinder 0 (the start)
mov dh, 0 ; head 0 (the start)
mov cl, 2 ; start reading from the second sector (the first sector is the boot sector) (yes sectors are 1 based)

xor bx, bx
mov es, bx
mov bx, 0x7E00 ; where to read to (0x7E00 is general usable memory)
; dl = disk number to read from, bios puts cur disk number in dl

int 0x13 ; perform the read

jnc read_success

; read failed, halt and catch fire
jmp $

read_success:
	; Enter Protected Mode
	cli
	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp CODE_SEG:pmStart

; just some boiler plate
gdt_start:
gdt_null:
	dd 0x0
	dd 0x0
gdt_code:
	dw 0xFFFF
	dw 0x0000
	db 0x00

	db 10011010b

	db 11001111b
	db 0x00
gdt_data:
	; dw 0xFFFFF
	dw 0xFFFF
	
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

[bits 32]
pmStart:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	jmp 0x7E00 ; jmp to C code

times 510 - ($ - $$) db 0
dw 0xAA55
