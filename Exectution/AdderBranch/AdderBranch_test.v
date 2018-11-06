`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] pc, imm32;   
   // Output
   wire [31:0] pcAddResult;
   
   integer  i;
   // Instantiate the Unit Under Test (UUT)
   AdderBranch uut (pc,
                    pcAddResult,
                    imm32);
           
   initial begin
      /// Initialize Inputs
      #50;
      pc = 10;
      imm32 = 10;
      
      
      #50;
      pc = 10;
      imm32 = 20;
      #50;
      
   end

   initial begin
      $dumpfile("./AdderBranch.vcd");
      $dumpvars;
   end

endmodule
