`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [5:0] funct;
   reg [1:0] ALUOp;    
   
   // Output
   wire [2:0] ALUctrl;
    
   
   // Instantiate the Unit Under Test (UUT)
   ALUCtrlUnit uut (funct,
                    ALUOp,
                    ALUctrl);
              
   initial begin
   /// Initialize Inputs
    #10;
    funct = 6'b100000;
    ALUOp = 2'b10;
    #10;

   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
