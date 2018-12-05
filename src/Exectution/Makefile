# change application name here (executable output name)
SUBDIRS=pcReg insCache addrGenerator

TARGET=pcReg

ANALAYZER=gtkwave

SRCS = $(wildcard *.v)

# compiler, assembler, linker flags
# FLAGS=

# source files

# object files
# CCOBJS  = $(patsubst %.c, %_c.o, $(CCSRCS))
# ASMOBJS = $(patsubst %.asm, %_asm.o, $(ASMSRCS))
# OBJS = $(CCOBJS) $(ASMOBJS)

.PHONY: default all clean $(SUBDIRS) run

default: $(SUBDIRS)

all: default

$(SUBDIRS):
	$(MAKE) --directory=$@

$(TARGET): $(SUBDIRS)
	iverilog $(SRCS) -o $(TARGET).o
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
