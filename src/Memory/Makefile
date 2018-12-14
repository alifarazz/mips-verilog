# change application name here (executable output name)
TARGET=out

ANALAYZER=gtkwave

SRCS = $(wildcard *.v) "AdderBranch/AdderBranch.v" "AdderShift/AdderShift.v" "ALUCtrlUnit/ALUCtrlUnit.v" "ALUexec/ALUexec.v" "MuxALUSrc/MuxALUSrc.v" "MuxRegDest/MuxRegDest.v"

.PHONY: default all $(TARGET) clean run

default: $(TARGET)

all: default

$(TARGET):
	printf "%s" $(SRCS)
	iverilog $(SRCS) -o $(TARGET).o
	vvp $(TARGET).o


run: $(TARGET)
	$(ANALAYZER) $(wildcard *.vcd)


clean:
	rm *.vcd
	rm *.o
