`timescale 1ns / 1ps

module CPUMIPS(clk,
               rstn,
               iram_data_data,
               iram_data_ins,
               oram_addr_ins,
               oram_addr_data,
               );

   input clk, rstn;
   input [127:0] iram_data_ins, iram_data_data;
   output [31:0] oram_addr_data, oram_addr_ins;


   // fetch
   wire [31:0] fetch_Adder_PC_output;
   wire [31:0] fetch_instruction;

   // pipeline IFID
   wire IFID_SIG_hit;

   // decode
   wire [31:0] decode_instruction;
   wire [1:0] decode_SIGS_WB; 
   wire [2:0] decode_SIGS_MEM;
   wire [3:0] decode_SIGS_EXEC;
   wire [31:0] decode_regfile_data1, decode_regfile_data2;
   wire [31:0] decode_imm;
   wire [4:0] decode_ins2016, decode_ins1511;

   wire [31:0] deocde_npc;

   // pipeline IDEX
   wire IDEX_SIG_hit;

   // execution
   wire [31:0] exec_npc;
   wire [31:0] exec_regfile_read1, exec_regfile_read2;
   wire [31:0] exec_imm32;
   wire [4:0] exec_ins2016, exec_ins1511;
   wire [3:0] exec_SIGS_EXEC;

   wire [1:0] exec_SIGS_WB; 
   wire [2:0] exec_SIGS_MEM;
   wire [31:0] exec_pc_adder_result;
   wire exec_ALUzero;
   wire [31:0] exec_ALU_result;
   wire [4:0] exec_mux_regdest;

   // pipeline EXMEM
   wire EXMEM_SIG_hit;

   // memory Stage
   wire [1:0] memstg_SIGS_WB;
   wire [2:0] memstg_SIGS_MEM;
   wire memstg_ALUzero;
   wire [31:0] memstg_ALU_result;
   wire [31:0] memstg_addrs_output;
   wire [31:0] memstg_regfile_read2;
   wire [4:0] memstg_mux_regdest;
   wire memstg_SIG_PCSrc;

   wire [31:0] memstg_MemReadData;

   // pipeline EXMEM
   wire MEMWB_SIG_hit;

   // write-back
   wire [1:0] wb_SIGS_WB;
   wire [31:0] wb_ram_data, wb_ALU_result;
   wire [31:0] wb_muxouput;
   wire [4:0] wb_regwrite;

   // for pipeline stalls
   wire stall, inscache_miss, datacache_miss;

   assign stall = inscache_miss | datacache_miss;
   assign IFID_SIG_hit = stall;
   assign IDEX_SIG_hit = stall;
   assign EXMEM_SIG_hit = stall;
   assign MEMWB_SIG_hit =  stall;
   assign fetch_pcreg_hit = stall;


   InsFetch insFetchStage(
               .iSIG_PCSrc(memstg_SIG_PCSrc),  // 1 to choose addr from WB
               .imem_in(iram_data_ins),  // data read from ram
               .iaddr4branch(memstg_addrs_output),  // address from wb stage
               .iupdatepc(fetch_pcreg_hit),
               .obranch_adder(fetch_Adder_PC_output),  // adder's output of branch
               .oins(fetch_instruction),  // fetched instruction
               .ocacheHit(inscache_miss),
               .clk(clk),
               .rstn(rstn));

   IFID pipl_ifid(
               .Adder_in(fetch_Adder_PC_output),
               .Instruction_in(fetch_instruction),
               .Adder_out(decode_npc),  // FIX-ME
               .Instruction_out(decode_instruction),
               .hit(IFID_SIG_hit),
               .clk(clk),
               .rstn(rstn));

   InsDecode insDecodeStage(
               .clk(clk),
               .rstn(rstn),
               .iins(decode_instruction),
               .iSig_RegWrite(wb_SIGS_WB[0]),
               .iWriteReg(wb_regwrite),
               .iWriteData2Reg(wb_muxouput),
               .oSig_WB(decode_SIGS_WB),
               .oSig_MEM(decode_SIGS_MEM),
               .oSig_EX(decode_SIGS_EXEC),
               .oRegFileRead1(decode_regfile_data1),
               .oRegFileRead2(decode_regfile_data2),
               .oSignExtended(decode_imm),
               .oins2016(decode_ins2016),
               .oins1511(decode_ins1511)
               );

   IDEX pipl_idex(
               .i_ctlwb(decode_SIGS_WB),
               .i_ctlmem(decode_SIGS_MEM),
               .i_ctlexec(decode_SIGS_EXEC),
               .inpc(decode_npc),
               .iread_dat_1(decode_regfile_data1),
               .iread_dat_2(decode_regfile_data2),
               .isgn_extended(decode_imm),
               .iins_20_16(decode_ins2016),
               .iins_15_11(decode_ins1511),
               .o_ctlwb(exec_SIGS_WB),
               .o_ctlmem(exec_SIGS_MEM),
               .o_ctlexec(exec_SIGS_EXEC),
               .onpc(exec_npc),
               .oread_dat_1(exec_regfile_read1),
               .oread_dat_2(exec_regfile_read2),
               .osgn_extended(exec_imm32),
               .oins_20_16(exec_ins2016),
               .oins_15_11,(exec_ins1511)
               .clk(clk),
               .rstn(rstn),
               .hit(IDEX_SIG_hit)
               );

   Execute executeStage(
               .clk(clk),
               .rstn(rstn),
               .iSig_RegDst(exec_SIGS_EXEC[0]),
               .iSig_ALUOp(exec_SIGS_EXEC[3:2]),
               .iSig_ALUSrc(exec_SIGS_EXEC[1]),
               .iadder_branch_result(exec_npc),
               .iregfile_read_1(exec_regfile_read1),
               .iregfile_read_2(exec_regfile_read2),
               .iimm(exec_imm32),
               .iins2016(exec_ins2016),
               .iins1511(exec_ins1511),
               .o_adder_branch_result(exec_pc_adder_result),
               .oALU_zero(exec_ALUzero),
               .oALU_result(exec_ALU_result),
               .oregfile_read_2(exec_regfile_read2),
               .oreg_write_reg(exec_mux_regdest)
               );

   EXMEM pipl_exmem(
               .i_ctlwb(exec_SIGS_WB),
               .i_ctlmem(exec_SIGS_MEM),
               .iadder_output(exec_pc_adder_result),
               .ialu_zero(exec_ALUzero),
               .ialu_output(exec_ALU_result),
               .iread_dat_2(exec_regfile_read2),
               .imux_out(exec_mux_regdest),
               .o_ctlwb(memstg_SIGS_WB),
               .o_ctlmem(memstg_SIGS_MEM),
               .oadder_output(memstg_addrs_output),
               .oalu_zero(memstg_ALUzero),
               .oalu_output(memstg_ALU_result),
               .oread_dat_2(memstg_regfile_read2),
               .omux_out(memstg_mux_regdest),
               .clk(clk),
               .rstn(rstn),
               .hit(EXMEM_SIG_hit)  
               );

   MemoryStage memoryStage(
               .clk(clk),
               .rstn(rstn),
               .iSig_branch(memstg_SIGS_MEM[0]),
               .iSig_MemWrite(memstg_SIGS_MEM[1]),
               .iSig_MemRead(memstg_SIGS_MEM[2]),
               .iALUzero(memstg_ALUzero),
               .iALUresult(memstg_ALU_result),
               .iregfile_read_data2(memstg_regfile_read2),
               .iread_from_ram(iram_data_data), // data read from ram incase of miss
               .oMemReadData(memstg_MemReadData),
               .oALUresult(memstg_ALU_result),
               .oBranchAdder_result(memstg_addrs_output),
               .ocacheHit(datacache_miss),
               .oSig_PCSrc(memstg_SIG_PCSrc)
               );

   MEMWB pipl_memwb(
               .i_ctlwb(wb),
               .iread_data_mem(memstg_MemReadData),
               .ialu_result(memstg_ALU_result),
               .ireg_write(memstg_mux_regdest),
               .o_ctlwb(wb_SIGS_WB),
               .oread_data_mem(wb_ram_data), // ;_;
               .oalu_result(wb_ALU_result),
               .oreg_write(wb_regwrite),
               .clk(clk),
               .rstn(rstn),
               .hit(MEMWB_SIG_hit) 
               );

   WriteBack writeBackStage(
               .clk(clk),
               .rstn(rstn),
               .iSig_regfile_write(wb_SIGS_WB[0]),
               .iSig_MemtoReg(wb_SIGS_WB[1]),
               .iread_from_ram(wb_ram_data),
               .ialu_result(wb_ALU_result),
               .odata2write2regfile(wb_muxouput),
               );

endmodule // main
 
