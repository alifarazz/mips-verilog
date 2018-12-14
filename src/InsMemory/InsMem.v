module InsMem(addr, data);
   input [31:0] addr;
   output [31:0] data;

   reg [31:0] content [127:0]; // 512 byte

initial
   $readmemb("MemContent.b", content, 0, 2);

   assign data = content[addr >> 2];

endmodule // main
