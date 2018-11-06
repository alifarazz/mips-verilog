`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] B, A;
   reg [2:0] ALUctrl;
   
   // Outputs
   wire [31:0] res;
   wire zero;
   
   // Instantiate the Unit Under Test (UUT)
    ALUexec uut(A,
                B,
                ALUctrl,
                res,
                zero);
   initial begin
   /// Initialize Inputs
    #10;
    B = 32'hDEADBEEF;
    A = 32'h0;
    #10;
    ALUctrl = 3'b010; // and
    #10;
    ALUctrl = 3'b110; // sub
    #10;
    ALUctrl = 3'b010; // add
    #10;
    ALUctrl = 3'b001; // or
    #10;
    ALUctrl = 3'b111; // slt
    #10;
   end


   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
