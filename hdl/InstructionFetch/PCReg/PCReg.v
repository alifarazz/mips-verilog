module PCReg(
        pcOut,
        pc,
        ihit,
        clk,
        rstn);
   input [31:0] pc;
   input clk, rstn;
   input ihit;
   output reg [31:0] pcOut;

   reg counter ;

   always@(negedge rstn)
     begin
         pcOut = 0;
         counter = 1;        
     end

   always@(posedge clk)
     begin
      if (ihit)
         if (counter)
            pcOut = pc;
         else
            counter = counter + 1;
      else
         counter = 0;
     end


endmodule // main
