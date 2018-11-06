`timescale 1ns / 1ps

module ALUCtrlUnit(funct,
                   ALUOp,
                   ALUctrl);
    input [5:0] funct;
    input [1:0] ALUOp;
    output reg [2:0] ALUctrl;
    
    always @(ALUOp or funct) begin
        if (ALUOp == 2'b00)
            ALUctrl = 3'b010;
        else if (ALUOp == 2'b01)
            ALUctrl = 3'b110;
        else if (ALUOp == 2'b10)
            case (funct)
                6'b100000: ALUctrl = 3'b010;
                6'b100010: ALUctrl = 3'b110;
                6'b100100: ALUctrl = 3'b000;
                6'b100101: ALUctrl = 3'b001;
                6'b101010: ALUctrl = 3'b111;
            endcase
        else
            ALUctrl = 3'bxxx;
    end
endmodule // main
