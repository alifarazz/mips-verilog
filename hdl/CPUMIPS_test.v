`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, rstn = 1;
   reg [127:0] ii_miss_data,
               id_miss_data;

   // Outputs
   wire [31:0] oi_addr,
               od_addr,
               od_write_data;
   wire od_SIG_write;

   integer    i;

   // Instantiate the Unit Under Test (UUT)
   CPUMIPS uut(clk,
               rstn,
               ii_miss_data,
               id_miss_data,
               oi_addr,
               od_addr,
               od_write_data,
               od_SIG_write
               );

   initial begin
      /// Initialize Inputs
      #10;
      rstn = 0;
      #10;
      ii_miss_data = {
                      32'h00210820,  // add $1, $1, $1
                      32'h00000020,  // nop
                      32'h00000020,  // nop

                      32'h00430820   // add $1, $2, $3
                      // 32'h0043082a   // slt $1, $2, $3
                      // 32'h0042082a   // slt $1, $2, $2
                      };

      // ii_miss_data = {
      //                 32'h00210820,  // add $1, $1, $1
      //                 32'h00000020,  // nop
      //                 32'h00000020,  // nop
      //                 // 32'hac620008   // sw $2, 8($3)
      //                 // 32'h8c610008   // lw $1,8($3)
      //                 32'h10000002  // beq $0, $0, 2
      //                 }; 
      id_miss_data = {32'hDEADBEEF, 32'hDEADBEEF, 32'hDEADBEEF, 32'hDEADBEEF};

      // #1;
   end

   initial begin
      clk = 0;
      for (i = 0; i < 250; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
