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
  A = 0;
  B = 0;
	for (i = 0; i < 32; i = i + 1)
      content[i] = i;
end

   always @(posedge clk) begin
      if (regwrite) begin
         if (rd != 0)
            content[rd] = writedata;
         A = content[rs];
         B = content[rt];
      end else begin
         A = content[rs];
         B = content[rt];
      end
   end
    
endmodule // main
