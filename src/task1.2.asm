%include "asm_io.inc"


segment .data

    ;db means define byte
    msg1 db "enter a number: ",0
    msg2 db "The sum of ", 0
    msg3 db " and ", 0
    msg4 db " is: ", 0

segment .bss
    integer1 resd 1    ;reserve 1 doubleword for first input
    integer2 resd 1    ;reseerve 1 for 2nd input
    result resd 1      ; reserve 1 for sum

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;ask for first number
    mov eax, msg1    ;load address of msg1 to eax
    call print_string   ;Prints "enter a number"
    call read_int      ;stores user input to eax
    mov [integer1], eax   ;move user input to integer1 memory location

    ;ask for second number
    mov eax, msg1
    call print_string
    call read_int
    mov [integer2], eax

    ;calculations
    mov eax, [integer1]  ;moves first number back to eax
    add eax, [integer2]  ;adds 2nd number to current value in eax
    mov [result], eax    ;save sum to result

    ;printing 
    mov eax, msg2
    call print_string   ;prints "The sum of "

    mov eax, [integer1]
    call print_int  ; prints first number
    
    mov eax, msg3
    call print_string    ; prints " and "

    mov eax, [integer2]
    call print_int    ;prints 2nd number

    mov eax, msg4
    call print_string  ; Prints " is: "

    mov eax, [result]
    call print_int   ;prints final total sum

    call print_nl   ; print new line


    ;exit
    popa
    mov eax, 0
    leave
    ret