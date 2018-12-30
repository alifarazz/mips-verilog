
TARGET=SignExtend

ANALAYZER=gtkwave

SRCS = $(wildcard *.v)

.PHONY: default all clean run

default: $(TARGET)

all: defualt

$(TARGET):
	iverilog $(SRCS) -o $(TARGET).o
	vvp $(TARGET).o

run: 
	$(ANALAYZER) $(wildcard *.vcd)

clean:
	rm *.vcd
	rm *.o
