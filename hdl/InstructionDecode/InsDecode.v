module InsDecode(
               clk,
               rstn,
               iins,
               iSig_RegWrite,
               iWriteReg,
               iWriteData2Reg,
               i_temp_npc,
               oSig_WB,
               oSig_MEM,
               oSig_EX,
               oRegFileRead1,
               oRegFileRead2,
               oSignExtended,
               oins2016,
               oins1511,
               o_temp_npc
               );

   input [31:0] iins;
   input iSig_RegWrite;
   input [4:0] iWriteReg;
   input [31:0] iWriteData2Reg;
   input [31:0] i_temp_npc;
   
   output [1:0] oSig_WB;
   output [2:0] oSig_MEM;
   output [3:0] oSig_EX;
   output [31:0] oRegFileRead1, oRegFileRead2;
   output [31:0] oSignExtended;

   output reg [4:0] oins2016, oins1511;
   output reg [31:0] o_temp_npc;

   input clk, rstn; // we dont use rstn

   always @(posedge clk) begin
      o_temp_npc = i_temp_npc;
      oins2016 = iins[20:16];
      oins1511 = iins[15:11];
   end

   ControlUnit controlUnit(.opcode(iins[31:26]),
                           .RegDst(oSig_EX[0]),
                           .Branch(oSig_MEM[0]),
                           .MemRead(oSig_MEM[2]),
                           .MemtoReg(oSig_WB[1]),
                           .ALUOp(oSig_EX[3:2]),
                           .MemWrite(oSig_MEM[1]),
                           .ALUSrc(oSig_EX[1]),
                           .RegWrite(oSig_WB[0]));
   RegFile regFile(.rs(iins[25:21]),
                   .rt(iins[20:16]),
                   .rd(iWriteReg),
                   .writedata(iWriteData2Reg),
                   .A(oRegFileRead1),
                   .B(oRegFileRead2),
                   .regwrite(iSig_RegWrite),
                   .clk(clk));

   SignExtend signExtend(.in(iins[15:0]),
                        .out(oSignExtended));



endmodule // main
