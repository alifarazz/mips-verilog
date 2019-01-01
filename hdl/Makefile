# change application name here (executable output name)
TARGET=out

ANALAYZER=gtkwave

InsFetch = InsFetch.v AddrGenerator/AddrGenerator.v AddrGenerator/PCAdder/PCAdder.v AddrGenerator/PCMux/PCMux.v InsCache/InsCache.v PCReg/PCReg.v
InsDecode = InsDecode.v ControlUnit/ControlUnit.v RegFile/RegFile.v SignExtend/SignExtend.v
Execute = Execute.v AdderBranch/AdderBranch.v AdderShift/AdderShift.v ALUCtrlUnit/ALUCtrlUnit.v ALUexec/ALUexec.v MuxALUSrc/MuxALUSrc.v MuxRegDest/MuxRegDest.v
Memory = MemoryStage.v DataCache/DataCache.v
WriteBack = WriteBack.v DataBranch/DataBranch.v 
Pipelines  = IFID/IFID.v IDEX/IDEX.v EXMEM/EXMEM.v MEMWB/MEMWB.v


InsFetchSRCS = $(patsubst %, InstructionFetch/%, $(InsFetch))
InsDecodeSRCS = $(patsubst %, InstructionDecode/%, $(InsDecode))
ExecuteSRCS = $(patsubst %, Execute/%, $(Execute))
MemorySRCS = $(patsubst %, Memory/%, $(Memory))
WriteBackSRCS = $(patsubst %, WriteBack/%, $(WriteBack))

PipelinesSRCS = $(patsubst %, Pipeline/%, $(Pipelines))


SRCS = $(wildcard *.v) $(InsFetchSRCS) $(PipelinesSRCS) $(InsDecodeSRCS) $(ExecuteSRCS) $(MemorySRCS) $(WriteBackSRCS)

.PHONY: default all $(TARGET) clean run session

default: $(TARGET)

all: default

$(TARGET):
	iverilog $(SRCS) -o $(TARGET).o
	vvp $(TARGET).o

run: $(TARGET)
	$(ANALAYZER) $(wildcard *.vcd)

session: $(TARGET)
	$(ANALAYZER) session.gtkw

clean:
	rm *.vcd
	rm *.o
