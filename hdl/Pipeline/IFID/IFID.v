`timescale 1ns / 1ps

module IFID(Adder_in,
                   Instruction_in,
                   Adder_out,
                   Instruction_out,
                   hit,
                   clk,
                   rstn);
   input [31:0] Adder_in;
   input [31:0] Instruction_in;
   input hit, clk, rstn;
   
   output reg [31:0] Adder_out;
   output reg [31:0] Instruction_out;
   
   always @(negedge rstn) begin
       Instruction_out = 0;
       Adder_out = 0;
   end

   always @(negedge clk) begin
       if (hit) begin
           Adder_out = Adder_in;
           Instruction_out = Instruction_in;
       end
   end

endmodule // main
