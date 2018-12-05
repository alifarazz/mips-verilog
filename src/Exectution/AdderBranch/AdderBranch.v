`timescale 1ns / 1ps

module AdderBranch(pc,
                   imm32,
                   pcAddResult);
   input [31:0] pc, imm32;
   output [31:0] pcAddResult;
   
   assign pcAddResult = pc + imm32;
   
endmodule // main
