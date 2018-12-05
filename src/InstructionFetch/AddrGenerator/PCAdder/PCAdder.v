module PCAdder(newv, old);
   input [31:0] old;
   output [31:0] newv;

   assign newv = old + 4;

endmodule // main
