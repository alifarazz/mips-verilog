`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [4:0] rs, rt, rd;
   reg [31:0] writedata;
   reg regwrite;
   reg clk;
   
   // Output
   wire [31:0] A, B;
   
   integer  i;
   // Instantiate the Unit Under Test (UUT)
   RegFile uut(rs,
               rt,
               rd,
               writedata,
               A,
               B,
               regwrite,
               clk);
   initial begin
      /// Initialize Inputs
      #50;
      rs = 0;
      rt = 1;
      rd = 4;
      writedata = 5;
      regwrite = 0;
      
      #50;
      rs = 0;
      rt = 1;
      rd = 4;
      regwrite = 1;
      writedata = 5;
      
      #50;
      rs = 4;
      rt = 1;
      rd = 4;
      regwrite = 0;
      writedata = 5;
      
      #50;
      regwrite = 0;
   end
   
initial begin
   clk = 0; 
	for (i = 0; i < 200; i = i + 1)
      #25 clk = ~clk;
end

   initial begin
      $dumpfile("./RegFile.vcd");
      $dumpvars;
   end

endmodule
