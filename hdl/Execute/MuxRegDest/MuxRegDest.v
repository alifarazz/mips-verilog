`timescale 1ns / 1ps

module MuxRegDest(clk,
                  rt,
                  rd,
                  RegDest,
                  rw);
                  
    input [4:0] rt, rd;
    input RegDest;
    output reg [4:0] rw;
    input clk;

    always @(posedge clk) begin
      rw = (RegDest) ? rd:rt;
    end
endmodule // main
