`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg iSIG_PCSrc;
   reg [127:0] imem_in;
   reg [31:0] iaddr4branch;
   reg icacheHit;

   // Outputs
   wire [31:0] oins, obranch_adder;

   reg clk, rstn = 1;
   integer    i;

   // Instantiate the Unit Under Test (UUT)
InsFetch uut(
               iSIG_PCSrc,
               imem_in,
               iaddr4branch,
               icacheHit,
               obranch_adder,
               oins,
               clk,
               rstn);

   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      #10;
      icacheHit = 1;
      iSIG_PCSrc = 1;
      iaddr4branch = 0;
      imem_in = 90;
      #250;
      icacheHit = 1;
      iSIG_PCSrc = 2;
      iaddr4branch = 0;
      imem_in = 80;
      #250;
      icacheHit = 0;
      iSIG_PCSrc = 1;
      iaddr4branch = 0;
      imem_in = 88;
   end

   initial begin
      clk = 0;
      for (i = 0; i < 2000; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
