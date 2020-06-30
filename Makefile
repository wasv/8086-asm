all: gas nasm

gas: test.gas.bin
nasm: test.nasm.bin

test.gas.bin: test.s
	as -mtune=i8086 -o test.o test.s
	ld --oformat binary -o test.gas.bin test.o

test.nasm.bin: test.asm
	nasm -o test.nasm.bin test.asm

.PHONY: gas nasm all
