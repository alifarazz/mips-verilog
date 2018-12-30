module WriteBack(
                  clk,
                  rstn,
                  iSig_regfile_write,
                  iSig_MemtoReg,
                  iread_from_ram,
                  ialu_result,
                  odata2write2regfile,
                  );

   input clk, rstn;
   input iSig_regfile_write, iSig_MemtoReg;
   input [31:0] iread_from_ram, ialu_result;

   output [31:0] odata2write2regfile;

   
   DataBranch dataBranch(.MemRead(iread_from_ram),
               .Addr(ialu_result),
               .SigMemToReg(iSig_MemtoReg),
               .Write2Reg(odata2write2regfile));

endmodule // main
