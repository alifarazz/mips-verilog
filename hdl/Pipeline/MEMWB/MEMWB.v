`timescale 1ns / 1ps

module MEMWB(i_ctlwb,
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

   input [1:0] i_ctlwb;
   input [31:0] iread_data_mem,
                ialu_result;
   input [4:0] ireg_write;

   output reg [1:0] o_ctlwb;
   output reg [31:0] oread_data_mem,
                oalu_result;
   output reg [4:0] oreg_write;

   input clk, hit, rstn;

   always @(negedge rstn) begin
      o_ctlwb = 0; 
      oread_data_mem = 0;
      oalu_result = 0;
      oreg_write = 0;
   end

   always @(negedge clk) begin
      if (hit) begin
         o_ctlwb = i_ctlwb; 
         oread_data_mem = iread_data_mem;
         oalu_result = ialu_result;
         oreg_write = ireg_write;
      end
   end
endmodule // main
