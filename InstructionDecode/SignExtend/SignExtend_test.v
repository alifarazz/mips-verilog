`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [15:0] in;
   
   // Output
   wire [31:0] out;
   
   // Instantiate the Unit Under Test (UUT)
   SignExtend uut(in,
                  out);
              
   initial begin
   /// Initialize Inputs
    #10;
    in = 16'hBEEF;
    #10;
    in = 16'hDEAD;
    #10;
    in = 16'h7FFF;
    #10;        
   end


   initial begin
      $dumpfile("./SignExtend.vcd");
      $dumpvars;
   end

endmodule
