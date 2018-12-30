`timescale 1ns / 1ps

module IDEX(i_ctlwb,
            i_ctlmem,
            i_ctlexec,
            inpc,
            iread_dat_1,
            iread_dat_2,
            isgn_extended,
            iins_20_16,
            iins_15_11,
            o_ctlwb,
            o_ctlmem,
            o_ctlexec,
            onpc,
            oread_dat_1,
            oread_dat_2,
            osgn_extended,
            oins_20_16,
            oins_15_11,
            clk,
            rstn,
            hit   
   );

   input [1:0] i_ctlwb;
   input [2:0] i_ctlmem;
   input [3:0] i_ctlexec;
   input [31:0] inpc,
                iread_dat_1,
                iread_dat_2,
                isgn_extended;
   input [4:0] iins_20_16,
               iins_15_11;

   output reg [1:0] o_ctlwb;
   output reg [2:0] o_ctlmem;
   output reg [3:0] o_ctlexec;
   output reg [31:0] onpc, 
                     oread_dat_1,
                     oread_dat_2,
                     osgn_extended;
   output reg [4:0] oins_20_16,
                    oins_15_11;

   input clk, hit, rstn;

   always @(negedge rstn) begin
      o_ctlwb = 0;
      o_ctlmem = 0;
      o_ctlexec = 0;
      onpc = 0;
      oread_dat_1 = 0;
      oread_dat_2 = 0;
      osgn_extended = 0;
      oins_20_16 = 0; 
      oins_15_11 = 0;
   end

   always @(negedge clk) begin
      if (hit) begin
         o_ctlwb = i_ctlwb;
         o_ctlmem = i_ctlmem;
         o_ctlexec = i_ctlexec;
         onpc = inpc;
         oread_dat_1 = iread_dat_1;
         oread_dat_2 = iread_dat_2;
         osgn_extended = isgn_extended;
         oins_20_16 = iins_20_16; 
         oins_15_11 = iins_15_11;
      end
   end
endmodule // main
