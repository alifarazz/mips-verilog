module InsFetch(Adder_out,
                Instruction_out,
                addrFromMemory,
                PCSrc,
                clk,
                rstn,
                );
 AddrGenerator(adr_branch,
                    Add_in,
                    Add_out,
                    Ins_address,
                    PCSrc);
 insCache(clk,
		rstn,
		iaddr,
		imem_in,
		ohit,
		oins);
 InsMem(addr, data);
 PcReg(pcOut, pc, clk, rstn);
 PipelineReg(Adder_in,
                   Instruction_in,
                   Adder_out,
                   Instruction_out,
                   hit,
                   clk,
                   rstn);
                   
    

endmodule // main
