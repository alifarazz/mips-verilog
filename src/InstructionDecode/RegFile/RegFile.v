`timescale 1ns / 1ps

module RegFile(rs,
                rt,
                rd,
                writedata,
                A,
                B,
                regwrite,
                clk);
   input [4:0] rs, rt, rd;
   input [31:0] writedata;
   input regwrite;
   input clk;
   
   output reg [31:0] A, B;
   
   reg [31:0] content[31:0];

   integer i;
   
initial begin
	for (i = 0; i < 31; i = i + 1)
      content[i] = 0;
end

   always @(posedge clk) begin
      A = content[rs];
      B = content[rt];
      if (regwrite) begin
         content[rd] = writedata;
      end
      content[0] = 0;
   end
    
endmodule // main
