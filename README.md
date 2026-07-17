# OS-Worksheet-1-Resit
Resit for worksheet 1 for Isaac Razzak / 22032321


Operating Systems Worksheet 1 Documentation

Task 1: 

Objective for task 1 is to write a program that initializes variables in memory, performs basic register arithmetic and outputs result

Operating Systems Worksheet 1 Documentation

Task 1: 

Memory allocation: 
 <img width="282" height="194" alt="image" src="https://github.com/user-attachments/assets/7040f3c0-3c02-4a62-880a-1d4218a67425" />


What this does: Divides memory into 2 distinct segments. .data holds initialized variables and .bss at the moment is just a blank space, which will later hold the final result. Assembly language doesn’t have typical high level language variable types such as int, so I have to use dd (define double-word), and resd (reserve double word), to manually allocate 32bits of memory for each item. A double word is a group of bits that fits inside of 2 registers. 

Register arithmetic:
<img width="940" height="164" alt="image" src="https://github.com/user-attachments/assets/47c59e0d-8a29-444a-aa54-8347d5c79897" />

Assembly cannot be used to perform arithmetic operations directly between different memory addresses. So, first the data needs to be moved to the register.
 
Here the value of integer1 is added to the EAX accumulator register, then integer2 is added to it and the result is stored in the result memory slot I reserved earlier. 
The brackets are necessary as otherwise the CPU tries to add the memory addresses themselves, which is an error I encountered trying to program this. 

Pusha and popa: 
 
<img width="381" height="97" alt="image" src="https://github.com/user-attachments/assets/5812e3ef-300f-4129-ae7c-0becdad032a4" />
 
<img width="834" height="126" alt="image" src="https://github.com/user-attachments/assets/5c8f3883-108c-4bd5-8c38-f60f839a6caa" />

Pusha saves the current values of CPU registers and saves them to the stack. Popa restores those values back.  This is done as the driver.c file which launches the program needs to also use the CPU registers. If a snapshot of the values was not saved and restored, there would be a problem.




Task 2: 

Defining strings for user prompts: 
<img width="560" height="226" alt="image" src="https://github.com/user-attachments/assets/71517fe4-01fc-4bcb-ba37-cea6f75786f4" />

 
The text I use for prompting the user to enter a number and for the output must be stored in memory.
Db (define byte) places the ASCII characters from the strings into the .data segment.
, 0 at the end of each line is a null terminator. This needs to be included as the program will carry on reading until it hits a 0 (only in binary). 

Reading user input: 
<img width="842" height="151" alt="image" src="https://github.com/user-attachments/assets/a2571323-f0ce-42b3-adae-87617b435e50" />

 

This section of code prints the prompt, waits for user input, and then moves the inputted number from the EAX register to the integer1 memory location that was reserved earlier. 
Once the first number is inputted, it Is placed in te EAX register. Then, the second number needs to be added to that. Because the second number needs to be inputted right after, it will overwrite the first number in the EAX register. The solution is to immediately save number 1 to integer1 before moving onto asking for number 2.

Printing: 
 <img width="545" height="453" alt="image" src="https://github.com/user-attachments/assets/d0be0700-747c-49aa-a02d-457dfeabdfd0" />

To print things out we have to alternate between loading a string into the EAX register by calling print_string, and then load the number into the register by calling print_int. 
It is not necessary to save things to a variable as they are being printed and then we are moving on. 

Conditions: 
<img width="864" height="239" alt="image" src="https://github.com/user-attachments/assets/06b2e985-5b34-4628-a912-1595bb34b2bd" />

 
This checks the user input in the eax register is valid. It checks the boundaries are correct ( not below 50 or over 100). Assembly does not have if/else statements, so this is a substitute for that. If no jumps occur, then the input is valid, and the program moves on. 

Arrays: 
 <img width="742" height="81" alt="image" src="https://github.com/user-attachments/assets/2e2bcdfb-2686-480f-93de-56ce40e80f04" />
<img width="940" height="78" alt="image" src="https://github.com/user-attachments/assets/ea3db6b6-3389-40be-b10e-2795a2a6e936" />

 
ECX is the counter register. It holds the loop counter (0-99). The memory location is calculated by multiplying the counter by 4, as the array has been reserved as 32 bit double-words. Each integer takes up 4 bytes of memory, so it is multipled by 4 and then jump is performed to bring us to the next block.


Task 3:
Building the program with a makefile

 <img width="564" height="264" alt="image" src="https://github.com/user-attachments/assets/464af2cc-ff21-4aef-89a7-93cda85c0b30" />


Here the raw data of the text is processed into an object file. 
 <img width="819" height="60" alt="image" src="https://github.com/user-attachments/assets/4909cbb1-9752-46e2-b25c-7926cbbeca24" />

This uses GCC to link everything into an executable 

<img width="638" height="97" alt="image" src="https://github.com/user-attachments/assets/c1aaf164-290a-4913-9f92-4f9c083f1c29" />
 
A clean function is helpful as it stops the old files from being saved and cluttering the folder and potentially causing errors . Without this it is possible the compiler could end up accessing older versions we don’t want it to. 
