`timescale 1ns / 1ps

module AdderBranch(clk,
                    pc,
                   imm32,
                   pcAddResult);
   input clk;
   input [31:0] pc, imm32;
   output reg [31:0] pcAddResult;
   
   always @(posedge clk) begin
      pcAddResult = pc + imm32;
   end
   
endmodule // main
