module InsFetch(
               iSIG_PCSrc,
               imem_in,
               iaddr4branch,
               obranch_adder,
               oins,
               clk,
               rstn);

   input iSIG_PCSrc;
   input [127:0] imem_in;
   input [31:0] iaddr4branch;

   output [31:0] oins, obranch_adder;

   input clk, rstn;

   wire [31:0] pcOut;
   wire [31:0] pc;

   wire cacheHit;


   PCReg pcReg(pcOut, pc, clk, rstn);
   AddrGenerator addrGenerator(.adr_branch(iaddr4branch), // addr from MEM
                               .Add_in(pcOut), // current pc
                               .Add_out(obranch_adder), // old pc + 4 
                               .Ins_address(pc), // new pc
                               .PCSrc(iSIG_PCSrc));
   InsCache insCache(.clk(clk),
                     .rstn(rstn), 
                     .iaddr(pcOut),  // current pc
                     .imem_in(imem_in), // data read from memory
                     .ohit(cacheHit), // cache hit status
                     .oins(oins)); // output instruction
endmodule // main
