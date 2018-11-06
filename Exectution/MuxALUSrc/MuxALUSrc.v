`timescale 1ns / 1ps

module MuxALUSrc(B,
                 imm32,
                 ALUSrc,
                 toAdder);
                  
    input [31:0] B, imm32;
    input ALUSrc;
    output [31:0] toAdder;
    assign toAdder = (ALUSrc) ? imm32:B;
endmodule // main
