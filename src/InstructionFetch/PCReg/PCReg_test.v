`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] pc;
   reg	      clk, rstn;
   
   // Outputs
   wire [31:0] pcOut;

   integer i;
   // parameter size = 16;

   // Instantiate the Unit Under Test (UUT)
   PCReg uut(pcOut,
	     pc,
	     clk,
	     rstn
	      );

   initial begin
      /// Initialize Inputs
      #10 rstn = 1;
      rstn = 0;
      pc = 0;

      #100;
      pc = 4;

      // $readmemb("pth", 2d_reg, start_addr, end_addr);
   end

   initial begin
      clk = 0;
      for (i = 0; i < 2000; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./pcReg_test.vcd");
      $dumpvars;
   end

endmodule
