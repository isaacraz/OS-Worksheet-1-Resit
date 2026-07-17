%include "asm_io.inc"

segment .data
    integer1 dd 15 
    integer2 dd 6

segment .bss
    result resd 1

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;CALCULATIONS

    mov eax, [integer1]    ;copy 15 into eax register
    add eax, [integer2]    ;add 6 to eax register (now 21)
    mov [result], eax      ;Copy result (21) from EAX into "result" memory slot

    ;OUTPUT

    call print_int    ;prints value inside EAX (21)
    call print_nl     ;print new line

    ;EXIT

    popa   ;reset register values
    mov eax, 0   ;Add 0 to EAX to signal successful finish
    leave
    ret

