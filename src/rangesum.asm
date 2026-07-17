%include "asm_io.inc"

segment .data
    prompt_start db "Enter start of range 0-99: ", 0
    prompt_end db "Enter end of range 0-99: ", 0
    error_msg db "Error: Invalid range", 0
    result_msg db "The sum of all numbers in the range is: ",0

segment .bss
    myarray resd 100
    start_idx resd 1
    end_idx resd 1

segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;fill the array
    mov ecx, 0
    mov ebx, myarray

fill_loop:
    mov eax, ecx 
    add eax, 1
    mov [ebx + ecx*4], eax
    inc ecx 
    cmp ecx, 100
    jl fill_loop

    ;retrieve start of range 
    mov eax, prompt_start 
    call print_string 
    call read_int 
    mov [start_idx], eax 

    ;retrieve end of range 
    mov eax, prompt_end 
    call print_string 
    call read_int 
    mov[end_idx], eax 

    ;check range is acceptable 

    ;check if start of range is lower than 0 and give error 
    mov eax, [start_idx]
    cmp eax, 0
    jl show_error 

    ;check if end is over 99 and give error 
    mov eax, [end_idx]
    cmp eax, 99
    jg show_error

    ;check if start of range is higher than the end of range and give error 
    mov eax, [start_idx]
    cmp eax, [end_idx]
    jg show_error 

    ;loop to calculate sum of the range 
    mov ecx, [start_idx]      ;start counter at start of the range provided by user
    mov eax, 0     ;EAX will hold the total 
    mov ebx, myarray   ;EBX points to the array 

sumofrange_loop:
    add eax, [ebx + ecx*4]   ;Add value of current location in array to the total stored in eax 

    inc ecx ;increment counter 
    cmp ecx, [end_idx]   ;compare current position in the range with the end of the range value user has given 
    jle sumofrange_loop   ; jump if less or equal to - keep looping until end range is reached 

    ;printing 
    mov edx, eax   ;stores total as eax will be overrwiten 

    mov eax, result_msg 
    call print_string  ;prints results message 

    mov eax, edx      ;move total back to eax so can print 
    call print_int 
    call print_nl 
    jmp endprogram   ;jump over error section to the exit 

show_error: 
    mov eax, error_msg 
    call print_string
    call print_nl 

endprogram: 
    popa 
    mov eax, 0
    leave 
    ret