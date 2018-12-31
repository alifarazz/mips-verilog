module Execute(
               clk,
               rstn,
               iSig_RegDst,
               iSig_ALUOp,
               iSig_ALUSrc,
               iadder_branch_result,
               iregfile_read_1,
               iregfile_read_2,
               iimm,
               iins2016,
               iins1511,
               o_adder_branch_result,
               oALU_zero,
               oALU_result,
               oreg_write_reg
               );

   input iSig_RegDst;
   input [1:0] iSig_ALUOp;
   input iSig_ALUSrc;
   input [31:0] iadder_branch_result;
   input [31:0] iregfile_read_1, iregfile_read_2;
   input [31:0] iimm;
   input [4:0] iins2016, iins1511;

   output [31:0] o_adder_branch_result;
   output oALU_zero;
   output [31:0] oALU_result;
   output [4:0] oreg_write_reg;

   input clk, rstn; // we dont use rstn

   wire [31:0] alu_operand_2;
   wire [2:0] alu_ctrl;
   wire [31:0] imm_shifted;
 
   MuxRegDest muxRegDest(.rt(iins2016),
                         .rd(iins1511),
                         .RegDest(iSig_RegDst),
                         .rw(oreg_write_reg));

   MuxALUSrc muxALUSrc(.B(iregfile_read_2),
                       .imm32(iimm),
                       .ALUSrc(iSig_ALUSrc),
                       .toAdder(alu_operand_2));

   ALUctrlUnit aLUctrlUnit(.ifunct(iimm[5:0]),
                         .iALUOp(iSig_ALUOp),
                         .oALUctrl(alu_ctrl));

   ALUexec aLUexec(.iA(iregfile_read_1),
                   .iB(alu_operand_2),
                   .iALUctrl(alu_ctrl),
                   .res(oALU_result),
                   .zero(oALU_zero));

   AdderShift adderShift(.in(iimm), .out(imm_shifted));

   AdderBranch  adderBranch(.pc(iadder_branch_result),
                            .imm32(imm_shifted),
                            .pcAddResult(o_adder_branch_result));
endmodule // main
