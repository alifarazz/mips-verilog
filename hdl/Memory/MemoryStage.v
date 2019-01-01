module MemoryStage(
                   clk,
                   rstn,
                   iSIGS_WB,
                   iSig_MemWrite,
                   iSig_branch,
                   iSig_MemRead,
                   iALUzero,
                   iALUresult,
                   iregfile_read_data2,
                   iread_from_ram, // data read from ram incase of miss
                   oMemReadData,
                   oALUresult,
                   ocacheHit,
                   oram_addr_wdata, // address of data to write to memory
                   oram_data_wdata, // the data to write to oram_addr_wdata of memory
                   oSig_PCSrc,
                   oSIGS_WB
                  );

   input clk, rstn;
   input iSig_branch;
   input iSig_MemWrite, iSig_MemRead;
   input iALUzero;
   input [31:0] iALUresult;
   input [31:0] iregfile_read_data2;

   input [127:0] iread_from_ram;

   input [1:0] iSIGS_WB;

   output [31:0] oMemReadData;
   output [31:0] oram_addr_wdata, oram_data_wdata;
   output reg [31:0] oALUresult;
   output reg [1:0] oSIGS_WB;

   output oSig_PCSrc;
   output ocacheHit;

   always @(posedge clk) begin
      oALUresult = iALUresult;
      oSIGS_WB = iSIGS_WB;
   end

   DataCache dcache(
            .clk(clk),
            .rstn(rstn),
            .iaddr(iALUresult),
            .idata_write(iregfile_read_data2), // 
            .ohit(ocacheHit),  // cache hit
            .omem_addr(oram_addr_wdata), // incase of miss, read from the same palce as you read from cache
            .imem_in(iread_from_ram), // data read from RAM in case of miss
            .omem_write_data(oram_data_wdata), // data to write to ram
            .odata_read(oMemReadData),
            .iSigMemRead(iSig_MemRead),
            .iSigMemWrite(iSig_MemWrite));

   assign oSig_PCSrc = iSig_branch & iALUzero;
endmodule // main
