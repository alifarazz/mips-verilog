# change application name here (executable output name)
SUBDIRS=pcAdder pcMux

TARGET=addrGenerator

ANALAYZER=gtkwave

SRCS = $(wildcard *.v)
DEPS =  "pcAdder/pcAdder.v" "pcMux/pcMux.v"

# compiler, assembler, linker flags
# FLAGS=

# source files

# object files
# CCOBJS  = $(patsubst %.c, %_c.o, $(CCSRCS))
# ASMOBJS = $(patsubst %.asm, %_asm.o, $(ASMSRCS))
# OBJS = $(CCOBJS) $(ASMOBJS)

.PHONY: default all clean $(SUBDIRS) run

default: $(TARGET)

all: default

$(SUBDIRS):
	$(MAKE) --directory=$@

$(TARGET):
	iverilog $(SRCS) $(DEPS) -o $(TARGET).o
	vvp $(TARGET).o

run:
	$(ANALAYZER) $(wildcard *.vcd)


clean:
	for d in $(SUBDIRS);			\
	do					\
	  $(MAKE) clean --directory=$$d;	\
	done
	rm *.vcd
	rm *.o
