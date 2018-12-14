`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [1:0] i_ctlwb;
   reg [31:0] iread_data_mem,
                ialu_result;
   reg [4:0] ireg_write;

   wire [1:0] o_ctlwb;
   wire [31:0] oread_data_mem,
                oalu_result;
   wire [4:0] oreg_write;

   reg clk, hit, rstn;
      
   integer i;
   // Instantiate the Unit Under Test (UUT)

MEMWB uut(i_ctlwb,
            iread_data_mem,
            ialu_result,
            ireg_write,

            o_ctlwb,
            oread_data_mem,
            oalu_result,
            oreg_write,

            clk,
            rstn,
            hit   
   );


   initial begin
      /// Initialize Inputs

   end

   initial begin
      clk = 0;
      for (i = 0; i < 20; i = i + 1)
   #25 clk = ~clk;
   end

   initial begin
      $dumpfile("./PipelineReg.vcd");
      $dumpvars;
   end

endmodule
