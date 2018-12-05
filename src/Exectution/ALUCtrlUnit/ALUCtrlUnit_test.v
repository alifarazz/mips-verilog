`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [5:0] ifunct;
   reg [1:0] iALUOp;    
   
   // Output
   wire [2:0] oALUctrl;
    
   
   // Instantiate the Unit Under Test (UUT)
   oALUctrlUnit uut (ifunct,
                    iALUOp,
                    oALUctrl);
              
   initial begin
   /// Initialize Inputs
    #10;
    ifunct = 6'b100000;
    iALUOp = 2'b10;
    #10;

   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
