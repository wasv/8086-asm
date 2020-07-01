all: gas nasm dj

gas: test.gas.bin
nasm: test.nasm.bin
dj: test.dj.bin test.dj.com

test.o: test.s
	as -mtune=i8086 -o $@ $<

test.gas.bin: test.o
	ld --oformat binary -o $@ $<

test.nasm.bin: test.asm
	nasm -o $@ $<

test.dj.obj: test.asm
	nasm -f obj -o $@ $<

test.dj.bin: test.dj.obj
	../djlink -m test.dj.map -o $@ $<

test.dj.com: test.dj.obj
	../djlink -m test.dj.map -o $@ $<

clean:
	rm -f *.bin *.exe *.o *.obj *.com *.COM *.EXE *.map

.PHONY: clean gas nasm dj all
