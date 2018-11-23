`timescale 1ns / 1ps

module SignExtend(in,
                  out);
                  
    input [15:0] in;
    output [31:0] out;
    wire [15:0] sgn = (in[15]) ? 16'hFFFF:16'h0000;
    assign out = {sgn , in};
endmodule // main
