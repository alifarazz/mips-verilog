`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, resetn=1;
   reg [31:0] iaddr;
   reg [127:0] imem_in;
   
   // Outputs
   wire [31:0] oins;
   wire        ohit;
   
   integer     i;
   
   // Instantiate the Unit Under Test (UUT)
   insCache uut(clk,
		resetn,
		iaddr,
		imem_in,
		ohit,
		oins
		);

   initial begin
      /// Initialize Inputs
      #10;
      resetn = 0;
      #10;
      iaddr = 7;
      #90;
      imem_in = {32'hDEADBEEF ,32'hABABABAB 
		 ,32'hCDCDCDCD, 32'hEFEFEFEF};
      #190;
      iaddr = 0;
      
      
   end

   initial begin
      clk = 0;
      for (i = 0; i < 20; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./insCache.vcd");
      $dumpvars;
   end

endmodule
