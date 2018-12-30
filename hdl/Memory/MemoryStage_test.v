`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, rstn = 1;
   reg iSig_branch;
   reg iSig_MemWrite, iSig_MemRead;
   reg iALUzero;
   reg [31:0] iALUresult;
   reg [31:0] iregfile_read_data2;

   reg [127:0] iread_from_ram;

   wire [31:0] oMemReadData, oALUresult;
   wire [31:0] oram_addr_wdata, oram_data_wdata;
   wire        oSig_PCSrc;
   wire ocacheHit;

   integer    i;

   // Instantiate the Unit Under Test (UUT)
   MemoryStage uut(
                   clk,
                   rstn,
                   iSig_branch,
                   iSig_MemWrite,
                   iSig_MemRead,
                   iALUzero,
                   iALUresult,
                   iregfile_read_data2,
                   iread_from_ram, // data read from ram incase of miss
                   oMemReadData,
                   oALUresult,
                   ocacheHit,
		   oram_addr_wdata,
		   oram_data_wdata,
                   oSig_PCSrc
                  );

   initial begin
      /// Initialize Inputs
      rstn = 0;
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
