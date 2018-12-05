`timescale 1ns / 1ps

module main_test;

   // Inputs
   
   reg [31:0] B, imm32;
   reg ALUSrc;
   
   // Outputs
   wire [31:0] toAdder;
   
   // Instantiate the Unit Under Test (UUT)
    MuxALUSrc uut(B,
                  imm32,
                  ALUSrc,
                  toAdder);
              
   initial begin
   /// Initialize Inputs
    #10;
    B = 32'h0000BEEF;
    imm32 = 32'hFFFFDEAD;
    ALUSrc = 0;
    #10;
    ALUSrc = 1;
    #10;        
   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
