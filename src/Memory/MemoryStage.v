module MemoryStage(
                  clk,
                  rstn,
                  iSig_branch,
                  iSig_MemWrite,
                  iSig_MemRead,
                  iALUzero,
                  iALUresult,
                  iregfile_read_data2,
                  iread_from_ram, // data read from ram incase of miss
                  oMemReadData,
                  oALUresult,
                  oBranchAdder_result,
                  oSig_PCSrc
                  );

   input clk, rstn;
   input iSig_branch;
   input iSig_MemWrite, iSig_MemRead;
   input iALUzero;
   input [31:0] iALUresult;
   input [31:0] iregfile_read_data2;

   input [127:0] iread_from_ram;

   output [31:0] oMemReadData, oALUresult;
   output [31:0] oBranchAdder_result;
   output oSig_PCSrc;

   reg cachehit;

   DataCache(.clk(clk),
             .rstn(rstn),
             .iaddr(iALUresult),
             .idata_write(iregfile_read_data2), // 
             .ohit(cachehit),  // cache hit
             .omem_addr(omem_addr), // incase of miss, read from the same palce as you read from cache
             .imem_in(iread_from_ram), // data read from RAM in case of miss
             .omem_write_data(iregfile_read_data2), // data to write to ram
             .odata_read(oMemReadData),
             .iSigMemRead(iSig_MemRead),
             .iSigMemWrite(iSig_MemWrite));

   assign oSig_PCSrc = iSig_branch & iALUzero;
endmodule // main
