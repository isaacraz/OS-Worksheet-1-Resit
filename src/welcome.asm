%include "asm_io.inc"

;creating the text messages
segment .data
    prompt_name db "Enter your name: ",0
    prompt_num db "Enter a number between 50 and 100: ",0
    welcome_msg db "Welcome, ",0
    error_msg db "Error, number is not between 50 and 100",0

segment .bss
    name resb 64   ;Reserves 64 bytes of space to hold user name


segment .text
    global asm_main

asm_main:
    enter 0,0
    pusha

    ;Prompt user to input name
    mov eax, prompt_name
    call print_string

    mov ebx, name   ;points EBX to start of the name in memory

read_loop:
    call read_char    ;read 1 keypress into AL register
    cmp al, 10        ;compare keypress to Enter key
    je finished_name      ;Jump if equal - If enter is pressed name is done
    mov [ebx], al   ;otherwise save character to memory 
    inc ebx    ;Move to next empty memory slot
    jmp read_loop   ; Unconditional jump - look for next letter

finished_name:
    mov byte [ebx], 0    

    ;User input
    mov eax, prompt_num
    call print_string
    call read_int  ;reads users number into EAX

    ;If statement 
    cmp eax, 50    ;compare to 50
    jle show_error   ;Jump if less or equal (and show error msg)

    cmp eax, 100
    jge show_error   ;jump if greater or equal

    mov ecx, eax   ;copy valid number to ECX to use as countdown

print_welcome_loop:
    mov eax, welcome_msg
    call print_string  ;prints "Welcome, "

    mov eax, name
    call print_string
    call print_nl
    ;prints users name

    ;countdown 
    dec ecx   ;Decrease ECX value by 1
    cmp ecx, 0   ;Compare countdown timer to 0
    jg print_welcome_loop  ;Jump if greater until reaching 0

    jmp end_program  ; once 0 is reached, jump to exit

;Error handling

show_error:
    mov eax, error_msg
    call print_string
    call print_nl

;Exit 

end_program:
    popa
    mov eax, 0
    leave
    ret 
    