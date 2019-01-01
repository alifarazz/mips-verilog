`timescale 1ns / 1ps

module ALUexec(clk,
               iA,
               iB,
               iALUctrl,
               res,
               zero);
                  
    input [31:0] iA, iB;
    input [2:0] iALUctrl;
    output reg zero;
    output reg [31:0] res;

    input clk;
    
    always @(posedge clk) begin
        zero = !(iA ^ iB);

        case(iALUctrl)
        3'b010: res = iA + iB;
        3'b110: res = iA - iB;
        3'b000: res = iA & iB;
        3'b001: res = iA | iB;
        3'b111: res = (iA < iB) ? 32'h1:32'h0;
        default: res = 32'hxxxxxxxx;
        endcase
    end
endmodule // main
