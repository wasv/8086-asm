NASM=nasm
DJLINK=tools/djlink/djlink.exe
PCE_DOS=tools/pce/src/arch/dos/pce-dos

BINDIR=out

SRCS=$(shell find src/ -name "*.asm")
OBJS=$(patsubst %.asm,$(BINDIR)/%.obj,$(SRCS))

ifndef V
    .SILENT:
endif

all: $(BINDIR)/test.com

pce: $(PCE_DOS)
djlink: $(DJLINK)

run: $(BINDIR)/test.com | $(PCE_DOS)
	$(PCE_DOS) $^

$(BINDIR)/%.com: $(OBJS) | $(DJLINK)
	@mkdir -p $(@D)
	@echo " LINK $(*)"
	$(DJLINK) -m $(@D)/$(*).map -o $@ $^

$(BINDIR)/%.obj: %.asm
	@mkdir -p $(@D)
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
	@echo " SUBM $(*)"
	git submodule update --init

clean:
	rm -rf out
	git submodule foreach "git clean -fqdx"

.PHONY: clean all run pce djlink
.SECONDARY:
