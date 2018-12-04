`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, rstn = 1;
   reg [31:0] iaddr;
   reg [31:0] idata_write;
   reg [127:0] imem_in;
   reg iSigMemRead, iSigMemWrite;

   // Output
   wire ohit;
   wire [31:0] omem_addr;
   wire [31:0] omem_write_data;
   wire [31:0] odata_read;

   integer i;
   
   // Instantiate the Unit Under Test (UUT)
   DataCache uut(clk,
                 rstn,
                 iaddr,
                 idata_write,
                 ohit,
                 omem_addr,
                 imem_in,
                 omem_write_data,
                 odata_read,
                 iSigMemRead,
                 iSigMemWrite);
              
   initial begin
   /// Initialize Inputs

   #10;
   rstn = 0;
   
   #10;
   iSigMemRead = 1;
   iSigMemWrite = 0;
   iaddr = 0;

   #90;
   imem_in = {32'hF00DBEEF, 32'hBAAAAAAD,
              32'hCAFEBABE, 32'hDEADBEEF};   
   #180;
   iaddr = 4;

   #50;
   iSigMemWrite = 1;
   iSigMemRead = 0;
   idata_write = 32'h8badf00d;
   iaddr = 8;

   #50;
   iSigMemWrite = 0;
   iSigMemRead = 1;

   #50;
   iSigMemWrite = 1;
   iSigMemRead = 0;
   iaddr = 36;
   idata_write = 32'hbaadf00d;

   #50;
   iSigMemWrite = 0;
   iSigMemRead = 1;

   end

   initial begin
      clk = 0;
      for (i = 0; i < 64; i = i + 1)
         #25 clk = ~clk;
   end

   initial begin
      $dumpfile("./vvp.out.vcd");
      $dumpvars;
   end

endmodule
