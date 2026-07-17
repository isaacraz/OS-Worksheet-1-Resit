all: rangesum

#links all the program files together to automate process 
rangesum: driver.o rangesum.o asm_io.o
	gcc -m32 -no-pie driver.o rangesum.o asm_io.o -o rangesum 

#assemble rangesum.asm file 
rangesum.o: rangesum.asm 
	nasm -f elf rangesum.asm -o rangesum.o

#assemble asm_io file
asm_io.o: asm_io.asm 
	nasm -f elf asm_io.asm -o asm_io.o

#compile the C driver
driver.o: driver.c 
	gcc -m32 -c driver.c -o driver.o

#Clean up - deletes old compiled .o files
clean:
	rm -f *.o rangesum 
