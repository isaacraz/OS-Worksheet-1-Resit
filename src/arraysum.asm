%include "asm_io.inc"

segment .data
    msg db "The sum of the array is: ", 0


segment .bss
    myarray resd 100 ;creating an array of 100 integers

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;Fill loop
    mov ecx, 0   ;sets counter to 0
    mov ebx, myarray   ;puts starting memory address of array into EBX

fill_loop:
    mov eax, ecx    ;copy current counter value to eax 
    add eax, 1    ;increment by 1 as ecx is using 0-based indexing

    mov [ebx + ecx*4], eax    ;moves value stored in eax into the array
    ;ecx*4 jumps 4 bytes ahead - size of doubleword (integer) (4 bytes of space)

    inc ecx   ; increment counter 
    cmp ecx, 100  ;compare counter to 100
    jl fill_loop   ;jump if less than 100

    mov ecx, 0   ;reset counter to 0
    mov eax, 0   ;reset eax to 0

sum_loop:
    add eax, [ebx +ecx*4]  ;add number in current array slot into EAX 

    inc ecx   ; add 1 to counter
    cmp ecx, 100 ; compare to 100 to see if we reached 100 items
    jl sum_loop  ; jump if less than 100

    ;once all are done
    mov edx, eax  ;stores sum in eax in edx as will be changing eax in next line

    mov eax, msg
    call print_string   ; prints "The sum of array is: "

    mov eax, edx    ; Move sum back to eax
    call print_int  ;prints the sum
    call print_nl  ;print new line 

    ;exit 
    popa
    mov eax, 0
    leave
    ret 