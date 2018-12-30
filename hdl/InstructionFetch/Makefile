# change application name here (executable output name)
TARGET=out

ANALAYZER=gtkwave

SRCS = $(wildcard *.v) "AddrGenerator/AddrGenerator.v" "AddrGenerator/PCAdder/PCAdder.v" "AddrGenerator/PCMux/PCMux.v" "InsCache/InsCache.v" "PCReg/PCReg.v"

.PHONY: default all $(TARGET) clean run

default: $(TARGET)

all: default

$(TARGET):
	iverilog $(SRCS) -o $(TARGET).o
	vvp $(TARGET).o


run: $(TARGET)
	$(ANALAYZER) $(wildcard *.vcd)


clean:
	rm *.vcd
	rm *.o
