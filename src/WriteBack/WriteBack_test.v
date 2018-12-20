`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, resetn=1;
   reg iSig_regfile_write, iSig_MemtoReg;
   reg [31:0] iread_from_ram, ialu_result;

   wire [31:0] odata2write2regfile;

   integer    i;

   // Instantiate the Unit Under Test (UUT)
   WriteBack uut(
                  clk,
                  rstn,
                  iSig_regfile_write,
                  iSig_MemtoReg,
                  iread_from_ram,
                  ialu_result,
                  odata2write2regfile,
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
