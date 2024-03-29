use16
global enter_rmode

made_it_msg: db 0xA, "Made It To Real Mode :D", 0x0

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
    mov ax, 0x0
    mov ds, ax
    mov ss, ax

    ; 5 - enable interrupts
    sti

%endmacro

use32
enter_rmode:
    mov ax, [0xC000]
    cmp ax, 0x02
    jne .load

    ; Cannot go to realmode, 32-bit only GDT.
    ret
.load:
    ; This is not done
    ; Add in functionality for arguments
    ; make argument take in a integer that
    ; deciphers which real-mode function to call.
    ; Also add functionality for user to create there own
    ; real-mode function that can be called via a specific
    ; int-value.
    call x86_EnterRealMode

    jmp word 0x0:.test
use16
.test:

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