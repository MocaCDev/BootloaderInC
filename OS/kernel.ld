ENTRY(kmain)
SECTIONS
{
    . = 0x9000;
    .text : AT(0x9000)
    {
        *(__start*);
        *(.text*);
    }

    .data :
    {
        *(.bss*);
        *(.data*);
        *(.rodata*);
        *(COMMON*);
    }

    /* Should we remove this? */
    .sig : AT(0x9A01) {SHORT(0x00);}
}