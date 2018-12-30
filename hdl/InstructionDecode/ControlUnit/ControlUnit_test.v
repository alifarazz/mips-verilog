`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [5:0] opcode;
   
   // Output
   wire RegDst,
           MemRead,
           MemtoReg,
           MemWrite,
           ALUSrc,
           Branch,
           RegWrite;
   wire [1:0]  ALUOp;
   // Instantiate the Unit Under Test (UUT)
  ControlUnit uut(opcode,
               RegDst,
               Branch,
               MemRead,
               MemtoReg,
               ALUOp,
               MemWrite,
               ALUSrc,
               RegWrite);
 initial begin
      /// Initialize Inputs
      #10;
      opcode = 0;
      #50;
       opcode = 6'b100011;
      #50;
       opcode = 6'b101011;
      #50;
       opcode = 6'b000100;
       #50;

   end
   
   initial begin
      $dumpfile("./RegFile.vcd");
      $dumpvars;
   end

endmodule
