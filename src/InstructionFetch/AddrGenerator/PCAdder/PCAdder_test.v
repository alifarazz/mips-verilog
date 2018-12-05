`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] old;

   // Outputs
   wire [31:0] newv;

   // parameter size = 16;

   // Instantiate the Unit Under Test (UUT)
   PCAdder uut(newv,
	       old
	      );

   initial begin
      /// Initialize Inputs
      #10;
      old = 4;
      #10;
      old = 5;
      #10;


      // $readmemb("pth", 2d_reg, start_addr, end_addr);
   end

   initial begin
      $dumpfile("./pcAdder_test.vcd");
      $dumpvars;
   end

endmodule
