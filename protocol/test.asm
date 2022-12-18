use16

;
; =======================
;       16-bit code
; =======================
; TODO: Update name of file.
;

global print_str

print_str:
    push ebp
    mov ebp, esp

    mov si, [ebp + 8]

    pop ebp
	mov ah, 0x0e
.print:
	mov al, [si]
	cmp al, 0x0
	je .end_print
	int 0x10
	
	add si, 1

	jmp .print

.end_print:
	ret

global test_this_is
this_is:
    .a db 0x0
    .b db 0x0

use16
test_this_is:
    mov ah, 0x0E
    mov al, 'D'
    int 0x10

    push ebp
    mov ebp, esp

    mov si, [ebp + 8]

    pop ebp

    mov [this_is], si

    mov ah, [this_is.a]
    cmp ah, 0xAB
    je .u
    jne .m
.u:
    mov ah, 0x0E
    mov al, 'S'
    int 0x10

    ret
.m:
    mov ah, 0x0E
    mov al, 'E'
    int 0x10

    hlt
    ret

global do_something
do_something:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]

    pop ebp

    cmp eax, 0x10
    jne .f
    je .s
.f:
    mov ah, 0x0E
    mov al, 'F'
    int 0x10
    ret
.s:
    mov ah, 0x0E
    mov al, 'S'
    int 0x10
    ret

global enter_rmode

%macro x86_EnterRealMode 0
    [bits 32]
    jmp word 18h:.pmode16         ; 1 - jump to 16-bit protected mode segment

.pmode16:
    [bits 16]
    ; 2 - disable protected mode bit in cr0
    mov eax, cr0
    and al, ~1
    mov cr0, eax

    ; 3 - jump to real mode
    jmp word 00h:.rmode

.rmode:
    ; 4 - setup segments
    mov ax, 0
    mov ds, ax
    mov ss, ax

    ; 5 - enable interrupts
    sti

%endmacro

enter_rmode:
    call x86_EnterRealMode

    mov ah, 0x0E
    mov al, 'H'
    int 0x10

    jmp word 0x0:.test

use16
.test:
    mov ah, 0x0E
    mov al, 'D'
    int 0x10

    cli
    mov eax, cr0
	or eax, 0x01
	mov cr0, eax

    jmp word 0x8:.init_segments

use32
.init_segments:
    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ret

global load_gdt

use16
load_gdt:

    mov ah, 0x00
    mov al, 0x08
    int 0x10
    
    in al, 0x92
	or al, 0x02
	out 0x92, al

	cli
	lgdt[g_GDTDesc]
	mov eax, cr0
	or eax, 0x01
	mov cr0, eax

    jmp 0x08:init_pm

;
; =======================
;       32-bit code
; =======================
;
use32
init_pm:

    mov ax, 0x10
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov al, 'S'

    mov byte [0xB8000], al
    mov byte [0xB8002], 'E'
    mov byte [0xB8004], 'X'

    jmp 0x8:0x8500

%include "boot/gdt.asm"