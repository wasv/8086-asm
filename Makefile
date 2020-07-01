NASM=nasm
DJLINK=tools/djlink/djlink.exe

SRCS=$(wildcard *.asm)
OBJS=$(SRCS:.asm=.obj)

all: test.com

%.com: $(OBJS) | $(DJLINK)
	@echo " LINK $(*)"
	$(DJLINK) -m $(*).map -o $@ $^

tools/djlink/djlink.exe:
	@echo " MAKE djlink"
	$(MAKE) -s -C djlink

%.obj: %.asm
	@echo " NASM $(*)"
	$(NASM) -f obj -o $@ $<

clean:
	rm -f *.obj *.com *.COM *.map

.PHONY: clean all
.SECONDARY:
.SILENT:
