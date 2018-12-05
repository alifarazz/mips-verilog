`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg SigMemToReg;
   reg [31:0] MemRead, Addr;


   // Outputs
   wire [31:0] Write2Reg;

   // Instantiate the Unit Under Test (UUT)
   DataBranch uut(MemRead,
                  Addr,
                  SigMemToReg,
                  Write2Reg);

   initial begin
   /// Initialize Inputs
   #10;
   MemRead = 32'hdeadbeef;
   Addr = 32'h8badf00d;
   SigMemToReg = 1;

   #10;
   SigMemToReg = 0;

   #50;

   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
