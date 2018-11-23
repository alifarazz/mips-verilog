module PcReg(pcOut, pc, clk, rstn);
   input [31:0] pc;
   input	clk, rstn;
   output reg [31:0] pcOut;

   always@(posedge clk)
     begin
	pcOut = pc;
     end

   always@(negedge rstn)
     begin
	pcOut = 0;
     end

endmodule // main
