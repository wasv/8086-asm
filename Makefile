DJLINK=tools/djlink/djlink.exe

SRCS=$(wildcard *.asm)
OBJS=$(SRCS:.asm=.obj)

all: test.com
%.obj: %.asm
	nasm -f obj -o $@ $<

%.com: $(OBJS) | $(DJLINK)
	$(DJLINK) -m $(*).map -o $@ $^

tools/djlink/djlink.exe:
	$(MAKE) -s -C djlink

clean:
	rm -f *.obj *.com *.COM *.map

.PHONY: clean all
.SECONDARY:
