`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, rstn=1;
   reg [127:0] ram_data;
   
   // Outputs
   wire [31:0] ram_addr;

   integer    i;

   // Instantiate the Unit Under Test (UUT)
   CPUMIPS uut_cpu(
         clk,
         rstn,
         ram_addr,
         ram_data
         );

   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      #10;
      ram_data = 123;

      // #1;
   end

   initial begin
      clk = 0;
      for (i = 0; i < 200; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
