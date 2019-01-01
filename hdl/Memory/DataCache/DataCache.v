`timescale 1ns / 1ps

module DataCache(clk,
                 rstn,
                 iaddr,
                 idata_write,
                 ohit,
                 omem_addr,
                 imem_in,
                 omem_write_data,
                 odata_read,
                 iSigMemRead,
                 iSigMemWrite);
   input clk, rstn;
   input [31:0] iaddr;  // RW: address to read/write data from/to
   input [31:0] idata_write;  // W: data to write to iaddr address
   input [127:0] imem_in;  // R: data read from RAM in case of miss
   input iSigMemRead, iSigMemWrite;  // shoud I read/write?
   output reg ohit;  // R: data is available
   output reg [31:0] omem_addr;  // W: address to read/write 
                                 // data(omem_write_data) from/to RAM
   output reg [31:0] omem_write_data;  // W: data to write to RAM, in omem_addr
   output reg [31:0] odata_read;  // R: data read from RAM, using iaddr
   
   reg [154:0] content[3:0];
   reg [1:0] counter;

   integer i;

   always @(negedge rstn) begin
      omem_addr = 0;
      odata_read = 0;
      omem_write_data = 0;
      ohit = 1;
      counter = 0;
      for (i = 0; i < 4; i = i + 1) begin
         content[i] = 0;
      end
   end

   always @(posedge clk) begin
      if (iSigMemWrite) begin
        // write to ram
        omem_write_data = idata_write;
        omem_addr = iaddr;
        // update cache
         if (content[iaddr[5:4]][0] == 1'b1 &&
            content[iaddr[5:4]][154:129] == iaddr[31:6]) begin
            case (iaddr[3:2])
               2'b00 : content[iaddr[5:4]][32:1]   = idata_write;
               2'b01 : content[iaddr[5:4]][64:33]  = idata_write;
               2'b10 : content[iaddr[5:4]][96:65]  = idata_write; 
               2'b11 : content[iaddr[5:4]][128:97] = idata_write;
            endcase
         end
          // ohit = 1;
        // end else  // if tag
        //   ohit = 0;

      end // if iSigMemWrite
      // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      if (iSigMemRead) begin
         if (content[iaddr[5:4]][0] == 1'b1 &&
            iaddr[31:6] == content[iaddr[5:4]][154:129]) begin // hit? 
            case (iaddr[3:2])
               2'b00 : odata_read = content[iaddr[5:4]][32:1];
               2'b01 : odata_read = content[iaddr[5:4]][64:33];
               2'b10 : odata_read = content[iaddr[5:4]][96:65];
               2'b11 : odata_read = content[iaddr[5:4]][128:97];
            endcase
            ohit = 1;
         end else begin  // miss
            ohit = 0;
            if (counter == 3) begin
               content[iaddr[5:4]] = {iaddr[31:6],
                                      imem_in,
                                      1'b1};
               counter = 0;
               case (iaddr[3:2])
                  2'b00 : odata_read = imem_in[31:0];
                  2'b01 : odata_read = imem_in[63:32];
                  2'b10 : odata_read = imem_in[95:64];
                  2'b11 : odata_read = imem_in[127:96];
               endcase
               ohit = 1;
            end else begin
               counter = counter + 1;
            end  // if counter
         end  // if miss
      end  // if iSigMemRead
   end  // always


endmodule // main
