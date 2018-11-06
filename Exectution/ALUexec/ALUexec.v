`timescale 1ns / 1ps

module ALUexec(A,
               B,
               ALUctrl,
               res,
               zero);
                  
    input [31:0] A, B;
    input [2:0] ALUctrl;
    output zero;
    output reg [31:0] res;
    
    assign zero = !(A ^ B);
    
    always @(A or B or ALUctrl) begin
        case(ALUctrl)
        3'b010: res = A + B;
        3'b110: res = A - B;
        3'b000: res = A & B;
        3'b001: res = A | B;
        3'b111: res = (A < B) ? 32'h1:32'h0;
        default: res = 32'hxxxxxxxx;
        endcase
    end
endmodule // main
