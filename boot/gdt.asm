g_GDT:      ; NULL descriptor
            dq 0

            ; 32-bit code segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10011010b                ; access (present, ring 0, code segment, executable, direction 0, readable)
            db 11001111b                ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            db 0                        ; base high

            ; 32-bit data segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10010010b                ; access (present, ring 0, data segment, executable, direction 0, writable)
            db 11001111b                ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            db 0                        ; base high

            ; 16-bit code segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10011010b                ; access (present, ring 0, code segment, executable, direction 0, readable)
            db 00001111b                ; granularity (1b pages, 16-bit pmode) + limit (bits 16-19)
            db 0                        ; base high

            ; 16-bit data segment
            dw 0FFFFh                   ; limit (bits 0-15) = 0xFFFFF
            dw 0                        ; base (bits 0-15) = 0x0
            db 0                        ; base (bits 16-23)
            db 10010010b                ; access (present, ring 0, data segment, executable, direction 0, writable)
            db 00001111b                ; granularity (1b pages, 16-bit pmode) + limit (bits 16-19)
            db 0                        ; base high

def_GDTDesc:
    dw def_GDTDesc - g_GDT - 1
    dd g_GDT

g_GDT32_16_address:     equ 0xA500
g_GDT32_16_desc_addr:   equ 0xAA00

g_GDT32_16:      
            ; NULL descriptor
            .n              dq 0

            ; 32-bit code segment
            .code32_limit          dw 0                        ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            .code32_base           dw 0                        ; base (bits 0-15) = 0x0
            .code32_base2          db 0                        ; base (bits 16-23)
            .code32_access         db 0                        ; access (present, ring 0, code segment, executable, direction 0, readable)
            .code32_gran           db 0                        ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            .code32_base_high      db 0                        ; base high

            ; 32-bit data segment
            .data32_limit          dw 0                        ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
            .data32_base           dw 0                        ; base (bits 0-15) = 0x0
            .data32_base2          db 0                        ; base (bits 16-23)
            .data32_access         db 0                        ; access (present, ring 0, data segment, executable, direction 0, writable)
            .data32_gran           db 0                        ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
            .data32_base_high      db 0                        ; base high

            ; 16-bit code segment
            .code16_limit                  dw 0                        ; limit (bits 0-15) = 0xFFFFF
            .code16_base                   dw 0                        ; base (bits 0-15) = 0x0
            .code16_base2                  db 0                        ; base (bits 16-23)
            .code16_access                 db 0                        ; access (present, ring 0, code segment, executable, direction 0, readable)
            .code16_gran                   db 0                        ; granularity (1b pages, 16-bit pmode) + limit (bits 16-19)
            .code16_base_high              db 0                        ; base high

            ; 16-bit data segment
            .data16_limit                  dw 0                        ; limit (bits 0-15) = 0xFFFFF
            .data16_base                   dw 0                        ; base (bits 0-15) = 0x0
            .data16_base2                  db 0                        ; base (bits 16-23)
            .data16_access                 db 0                        ; access (present, ring 0, data segment, executable, direction 0, writable)
            .data16_gran                   db 0                ; granularity (1b pages, 16-bit pmode) + limit (bits 16-19)
            .data16_base_high              db 0                        ; base high

g_GDTDesc:
    .size dw 0x0
    .addr dd 0x0

;g_GDT32:      
;            ; NULL descriptor
;            dq 0
;
;            ; 32-bit code segment
;            dw 0                        ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
;            dw 0                        ; base (bits 0-15) = 0x0
;            db 0                        ; base (bits 16-23)
;            db 0                        ; access (present, ring 0, code segment, executable, direction 0, readable)
;            db 0                        ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
;            db 0                        ; base high
;
;            ; 32-bit data segment
;            dw 0                        ; limit (bits 0-15) = 0xFFFFF for full 32-bit range
;            dw 0                        ; base (bits 0-15) = 0x0
;            db 0                        ; base (bits 16-23)
;            db 0                        ; access (present, ring 0, data segment, executable, direction 0, writable)
;            db 0                        ; granularity (4k pages, 32-bit pmode) + limit (bits 16-19)
;            db 0                        ; base high