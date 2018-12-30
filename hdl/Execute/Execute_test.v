`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, resetn=1;
   reg iSig_RegDst;
   reg [1:0] iSig_ALUOp;
   reg iSig_ALUSrc;
   reg [31:0] iadder_branch_result;
   reg [31:0] iregfile_read_1, iregfile_read_2;
   reg [31:0] iimm;
   reg [4:0] iins2016, iins1511;

   wire [31:0] o_adder_branch_result;
   wire oALU_zero;
   wire [31:0] oALU_result, oregfile_read_2;
   wire [4:0] oreg_write_reg;


   integer    i;

   // Instantiate the Unit Under Test (UUT)
   Execute uut(
         clk,
         rstn,
         iSig_RegDst,
         iSig_ALUOp,
         iSig_ALUSrc,
         iadder_branch_result,
         iregfile_read_1,
         iregfile_read_2,
         iimm,
         iins2016,
         iins1511,
         o_adder_branch_result,
         oALU_zero,
         oALU_result,
         oregfile_read_2,
         oreg_write_reg
         );

   initial begin
      /// Initialize Inputs
      resetn = 0;
      #10;

      // #1;
   end

   initial begin
      clk = 0;
      for (i = 0; i < 2000; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
