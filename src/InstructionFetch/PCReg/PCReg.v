module PCReg(pcOut, pc, ihit,clk, rstn);
   input [31:0] pc;
   input	clk, rstn;
   input ihit;
   output reg [31:0] pcOut;

   always@(posedge clk)
     begin
      if (ihit)
	     pcOut = pc;
     end

   always@(negedge rstn)
     begin
	pcOut = 0;
     end

endmodule // main
