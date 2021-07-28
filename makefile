bit:
	yasm -f elf64 -g dwarf2 -l bit.lst bit.asm
	ld -o bit bit.o

run:
	./bit
clean:
	rm -f *o *lst bit	 
