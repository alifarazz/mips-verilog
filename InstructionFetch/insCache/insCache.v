`timescale 1ns / 1ps

module insCache(clk,
		rstn,
		iaddr,
		imem_in,
		ohit,
		oins);
   input clk, rstn;
   input [31:0] iaddr;
   input [127:0] imem_in;
   output reg [31:0] oins;
   output reg	     ohit;

   reg [154:0] content[3:0];

   // wire [3:0] tag[25:0];
   // wire [3:0] valid;
   // wire [3:0] set[127:0];

   reg [1:0] counter;

   integer    i;

   always @(negedge rstn)
     begin
	counter = 0;
	ohit = 0;
	oins = 0;
	for (i = 0; i < 4; i = i + 1)
	  begin
	     content[i] = 0;
	  end
     end

   always @(posedge clk)
     begin
	if (content[iaddr[5:4]][0] == 1'b1 &&
	    iaddr[31:6] == content[iaddr[5:4]][154:129])
	  begin // hit?
	     case (iaddr[3:2])
	       2'b00 : oins = content[iaddr[5:4]][32:1];
	       2'b01 : oins = content[iaddr[5:4]][64:33];
	       2'b10 : oins = content[iaddr[5:4]][96:65];
	       2'b11 : oins = content[iaddr[5:4]][128:97];
	     endcase
	     ohit = 1;
	  end
	else
	  begin // miss
	     ohit = 0;
	     if (counter == 3)
	       begin
		  content[iaddr[5:4]] = {imem_in[31:6],
					 imem_in[127:96],
					 imem_in[95:64],
					 imem_in[63:32],
					 imem_in[31:0],
					 1'b1};
		  counter = 0;
		  case (iaddr[3:2])
		    2'b00 : oins = content[iaddr[5:4]][32:1];
		    2'b01 : oins = content[iaddr[5:4]][64:33];
		    2'b10 : oins = content[iaddr[5:4]][96:65];
		    2'b11 : oins = content[iaddr[5:4]][128:97];
		  endcase
		  ohit = 1;
	       end
	     else
	       begin
		  counter = counter + 1;
	       end			// if counter
	  end			// if miss
     end				// always


endmodule // main
