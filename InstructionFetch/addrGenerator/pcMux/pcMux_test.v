`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] a, b;
   reg	      sel;

   // Outputs
   wire [31:0] res;

   // parameter size = 16;

   // Instantiate the Unit Under Test (UUT)
   PcMux uut(res,
	       a,
	       b,
	       sel
	      );

   initial begin
      /// Initialize Inputs
      #10;
      a = 1;
      b = 2;
      sel = 0;

      #10;
      a = 1;
      b = 2;
      sel = 1;

      #10;


      // $readmemb("pth", 2d_reg, start_addr, end_addr);
   end

   initial begin
      $dumpfile("./pcMux_test.vcd");
      $dumpvars;
   end

endmodule
