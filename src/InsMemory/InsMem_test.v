`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] addr;

   // Outputs
   wire [31:0] data;

   // parameter size = 16;

   // Instantiate the Unit Under Test (UUT)
   InsMem uut(addr,
	      data
	      );

   initial begin
      /// Initialize Inputs
      #10;
      addr = 32'h00000000;
      #10;
      addr = 32'h00000004;
      #10;


      // $readmemb("pth", 2d_reg, start_addr, end_addr);
   end

   initial begin
      $dumpfile("./insMem_test.vcd");
      $dumpvars;
   end

endmodule
