`timescale 1ns / 1ps

module DataBranch(MemRead,
                  Addr,
                  SigMemToReg,
                  Write2Reg);
   input SigMemToReg;
   input [31:0] MemRead, Addr;
   output [31:0] Write2Reg;
   
   assign Write2Reg = (SigMemToReg) ? MemRead : Addr; 
endmodule // main
