NASM=nasm
DJLINK=tools/djlink/djlink.exe
PCE_DOS=tools/pce/src/arch/dos/pce-dos

SRCS=$(wildcard *.asm)
OBJS=$(SRCS:.asm=.obj)

all: test.com

run: test.com | $(PCE_DOS)
	$(PCE_DOS) $^

%.com: $(OBJS) | $(DJLINK)
	@echo " LINK $(*)"
	$(DJLINK) -m $(*).map -o $@ $^

tools/djlink/djlink.exe:
	@echo " MAKE djlink"
	$(MAKE) -s -C djlink

%.obj: %.asm
	@echo " NASM $(*)"
	$(NASM) -f obj -o $@ $<

$(DJLINK): | tools/djlink
	@echo " MAKE djlink"
	$(MAKE) -C tools/djlink

$(PCE_DOS): | tools/pce
	@echo " MAKE pce"
	cd tools/pce; ./configure
	$(MAKE) -C tools/pce src/arch/dos/pce-dos

tools/%:
	@echo "Submodule $(*) is missing"
	git submodule update --init

clean:
	rm -f *.obj *.com *.COM *.map

.PHONY: clean all run
.SECONDARY:
.SILENT:
