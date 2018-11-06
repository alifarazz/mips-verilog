`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [4:0] rt, rd;
   reg RegDest;
   
   // Output
   wire [4:0] rw;
   
   // Instantiate the Unit Under Test (UUT)
   MuxRegDest uut(rt,
              rd,
              RegDest,
              rw);
              
   initial begin
   /// Initialize Inputs
    #10;
    rt = 5'h1F;
    rd = 5'h0F;
    RegDest = 1;
    #10;
    RegDest = 0;
    #10;
   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule

