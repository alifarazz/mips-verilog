`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg iSIG_PCSrc;
   reg [127:0] imem_in;
   reg [31:0] iaddr4branch;
   reg icacheHit;

   // Outputs
   wire [31:0] oins, obranch_adder;
   wire ocacheHit;

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
               ocacheHit,
               clk,
               rstn);

   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      #10;
      icacheHit = 1 & ocacheHit;
      iSIG_PCSrc = 1;
      iaddr4branch = 32'h00000100;
      imem_in = {32'hDEADBEEF ,32'hABABABAB,
                 32'hCDCDCDCD, 32'hEFEFEFEF};

      #200;
      iaddr4branch = 32'h00000000;

      #50;
      icacheHit = 1 & ocacheHit;
      iSIG_PCSrc = 0;
      // iaddr4branch = 32'h00000008;
      imem_in = {32'hDEADBEEF ,32'hABABABAB,
                 32'hCDCDCDCD, 32'hEFEFEFEF};
      #250;
      icacheHit = 0;
      iSIG_PCSrc = 1;
      iaddr4branch = 32'h00000000;
      imem_in = {32'hDEADBEEF, 32'h12345678, 32'hAAAAAAAA, 32'hBADA881E};
   end

   initial begin
      clk = 0;
      for (i = 0; i < 30; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
