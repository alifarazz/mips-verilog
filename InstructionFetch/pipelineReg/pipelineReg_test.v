`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] Adder_in;
   reg [31:0] Instruction_in;
   reg hit, clk, rstn = 1;
   
   // Outputs
   wire [31:0] Adder_out;
   wire [31:0] Instruction_out;
   
   
   integer i;
   // Instantiate the Unit Under Test (UUT)
    PipelineReg uut(Adder_in,
                   Instruction_in,
                   Adder_out,
                   Instruction_out,
                   hit,
                   clk,
                   rstn);
   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      #10;
      Adder_in = 2;
      Instruction_in = 3;
      hit = 1;
      #10;
      Adder_in = 200;
      Instruction_in = 300;
      hit = 0;
      #10;
      
   end

   initial begin
      clk = 0;
      for (i = 0; i < 20; i = i + 1)
	#2 clk = ~clk;
   end

   initial begin
      $dumpfile("./PipelineReg.vcd");
      $dumpvars;
   end

endmodule
