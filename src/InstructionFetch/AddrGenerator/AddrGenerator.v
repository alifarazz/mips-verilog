module AddrGenerator(adr_branch,
                    Add_in,
                    Add_out,
                    Ins_address,
                    PCSrc);
    input [31:0] adr_branch;
    input [31:0] Add_in;
    input PCSrc, hit;
    
    output [31:0] Ins_address;
    output [31:0] Add_out;
    
    wire [31:0] Add_out_temp;
    
    PCMux pcMux(Ins_address, Add_out_temp, adr_branch, PCSrc);
    PCAdder pcAdder(Add_out_temp, Add_in);
    
    assign Add_out = Add_out_temp;
    
endmodule // main
