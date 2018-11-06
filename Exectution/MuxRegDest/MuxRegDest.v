`timescale 1ns / 1ps

module MuxRegDest(rt,
                  rd,
                  RegDest,
                  rw);
                  
    input [4:0] rt, rd;
    input RegDest;
    output [4:0] rw;
    assign rw = (RegDest) ? rd:rt;
endmodule // main
