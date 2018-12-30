`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] iB, iA;
   reg [2:0] iALUctrl;
   
   // Outputs
   wire [31:0] res;
   wire zero;
   
   // Instantiate the Unit Under Test (UUT)
    ALUexec uut(iA,
                iB,
                iALUctrl,
                res,
                zero);
   initial begin
   /// Initialize Inputs
    #10;
    iB = 32'hDEADBEEF;
    iA = 32'h0;
    #10;
    iALUctrl = 3'b010; // and
    #10;
    iALUctrl = 3'b110; // sub
    #10;
    iALUctrl = 3'b010; // add
    #10;
    iALUctrl = 3'b001; // or
    #10;
    iALUctrl = 3'b111; // slt
    #10;
   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
