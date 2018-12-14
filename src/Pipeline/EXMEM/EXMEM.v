`timescale 1ns / 1ps

module EXMEM(i_ctlwb,
            i_ctlmem,
            iadder_output,
            ialu_zero,
            ialu_output,
            iread_dat_2,
            imux_out,

            o_ctlwb,
            o_ctlmem,
            oadder_output,
            oalu_zero,
            oalu_output,
            oread_dat_2,
            omux_out,

            clk,
            rstn,
            hit   
   );

   input [1:0] i_ctlwb;
   input [2:0] i_ctlmem;
   input ialu_zero;
   input [31:0] iadder_output,
                ialu_output,
                iread_dat_2,
                isgn_extended;
   input [4:0] imux_out;

   output reg [1:0] o_ctlwb;
   output reg [2:0] o_ctlmem;
   output reg oalu_zero;
   output reg [31:0] oadder_output,
                oalu_output,
                oread_dat_2,
                osgn_extended;
   output reg [4:0] omux_out;

   input clk, hit, rstn;

   always @(negedge rstn) begin
      o_ctlwb = 0;
      o_ctlmem = 0;
      oalu_zero = 0;
      oadder_output = 0;
      oalu_output = 0;
      oread_dat_2 = 0;
      osgn_extended = 0;
      omux_out = 0;
   end

   always @(negedge clk) begin
      if (hit) begin
         o_ctlwb = i_ctlmem;
         o_ctlmem = i_ctlmem;
         oalu_zero = ialu_zero;
         oadder_output = iadder_output;
         oalu_output = ialu_output;
         oread_dat_2 = iread_dat_2;
         osgn_extended = isgn_extended;
         omux_out = imux_out;
      end
   end
endmodule // main
