`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg [31:0] adr_branch;
   reg PCSrc;
   reg [31:0] Add_in;

   // Outputs
   wire [31:0] Ins_address;
   wire [31:0] Add_out;

   // parameter size = 16;

   // Instantiate the Unit Under Test (UUT)
    AddrGenerator uut(adr_branch,
                Add_in,
                Add_out,
                Ins_address,
                PCSrc);

   initial begin
      /// Initialize Inputs
      #10;
      Add_in = 2;
      adr_branch = 10;
      PCSrc = 0;
      
      #10;
      Add_in = 2;
      adr_branch = 10;
      PCSrc = 0;
      
      
      #100;

      // $readmemb("pth", 2d_reg, start_addr, end_addr);
   end

   initial begin
      $dumpfile("./addrGenerator_test.vcd");
      $dumpvars;
   end

endmodule
