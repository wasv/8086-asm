DJLINK=tools/djlink/djlink.exe

all: gas nasm dj

gas: test.gas.bin
nasm: test.nasm.bin
dj: test.dj.bin test.dj.com

%.gas.o: %.s
	as -mtune=i8086 -o $@ $<

%.gas.bin: %.gas.o
	ld --oformat binary -o $@ $<

%.nasm.bin: %.asm
	nasm -o $@ $<

%.dj.obj: %.asm
	nasm -f obj -o $@ $<

%.dj.bin: %.dj.obj $(DJLINK)
	$(DJLINK) -m test.dj.map -o $@ $<

%.dj.com: %.dj.obj $(DJLINK)
	$(DJLINK) -m test.dj.map -o $@ $<

tools/djlink/djlink.exe:
	$(MAKE) -s -C djlink

clean:
	rm -f *.bin *.exe *.o *.obj *.com *.COM *.EXE *.map

.PHONY: clean gas nasm dj all
.SECONDARY:
