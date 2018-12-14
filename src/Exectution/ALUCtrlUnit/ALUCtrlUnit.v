`timescale 1ns / 1ps

module ALUctrlUnit(ifunct,
                   iALUOp,
                   oALUctrl);
    input [5:0] ifunct;
    input [1:0] iALUOp;
    output reg [2:0] oALUctrl;
    
    always @(iALUOp or ifunct) begin
        if (iALUOp == 2'b00)
            oALUctrl = 3'b010;
        else if (iALUOp == 2'b01)
            oALUctrl = 3'b110;
        else if (iALUOp == 2'b10)
            case (ifunct)
                6'b100000: oALUctrl = 3'b010;
                6'b100010: oALUctrl = 3'b110;
                6'b100100: oALUctrl = 3'b000;
                6'b100101: oALUctrl = 3'b001;
                6'b101010: oALUctrl = 3'b111;
            endcase
        else
            oALUctrl = 3'bxxx;
    end
endmodule // main
