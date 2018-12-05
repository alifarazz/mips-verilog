`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, rstn=1;
   reg [31:0] iaddr;
   reg [127:0] imem_in;
   
   // Outputs
   wire [31:0] oins;
   wire        ohit;
   
   integer     i;
   
   // Instantiate the Unit Under Test (UUT)
   InsCache uut(clk,
                rstn,
                iaddr,
                imem_in,
                ohit,
                oins);

   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      
      #10;

      iaddr = 7;
      
      #90;
      imem_in = {32'hDEADBEEF ,32'hABABABAB,
                 32'hCDCDCDCD, 32'hEFEFEFEF};
      #180;
      iaddr = 0;

      #50;
      iaddr = 4;

      #50;
      iaddr = 8;

      #50;
      iaddr = 12;

      #50;
      iaddr = 16;
      
   end

   initial begin
      clk = 0;
      for (i = 0; i < 64; i = i + 1)
   #25 clk = ~clk;
   end


   initial begin
      $dumpfile("./insCache.vcd");
      $dumpvars;
   end

endmodule
