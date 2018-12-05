`timescale 1ns / 1ps

module ControlUnit(opcode,
               RegDst,
               Branch,
               MemRead,
               MemtoReg,
               ALUOp,
               MemWrite,
               ALUSrc,
               RegWrite);
   input [5:0] opcode;
   output reg RegDst,
              MemRead,
              MemtoReg,
              MemWrite,
              ALUSrc,
              Branch,
              RegWrite;
   output reg [1:0] ALUOp;

   always @(*) begin
      if(opcode == 6'h00) begin // r-type
         ALUOp[1] = 1; RegWrite = 1 ;RegDst = 1;
         ALUOp[0] = 0; Branch = 0; MemWrite = 0;
         MemRead = 0; MemtoReg = 0; ALUSrc = 0;
      end 
      else if(opcode == 6'b100011) begin // lw
         RegDst = 0; MemWrite = 0; Branch = 0;
         ALUOp = 0;
         ALUSrc = 1; MemtoReg = 1; RegWrite = 1;
         MemRead = 1;
      end
      else if(opcode == 6'b101011) begin // sw
         MemtoReg = 1'bx; RegDst = 1'bx;
         ALUSrc = 1; MemWrite = 1;
         RegWrite = 0; MemRead = 0; Branch = 0;
         ALUOp = 0;
      end
      else if(opcode == 6'b000100) begin // beq
         MemtoReg = 1'bx; RegDst = 1'bx;
         RegWrite = 0; MemRead = 0; MemWrite = 0;
         ALUOp[1] = 0; ALUSrc = 0;
         Branch = 1; ALUOp[0] = 1;
      end
   end


endmodule // main
