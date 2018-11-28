`timescale 1ns / 1ps

module DataCache(clk,
                 rstn,
                 addr,
                 data_write,
                 dc_hit,
                 mem_addr,
                 mem_data,
                 mem_write_data,
                 data_read,
                 SigMemRead,
                 SigMemWrite);
   input clk, rstn;
   input [31:0] addr, data_write;
   input [127:0] mem_data;
   input SigMemRead, SigMemWrite;
   output reg dc_hit;
   output reg [31:0] mem_addr, mem_write_data, data_read;
   

   reg [154:0] content[3:0];

   reg [1:0] counter;

   always @(negedge rstn)
   begin
      mem_addr = 0;
      data_read = 0;
      content = {155'b0, 155'b0, 155'b0, 155'b0};
   end

   always @(posedge clk)
   begin
      if (SigMemWrite)
      begin
         // write to ram
         mem_write_data = data_write;
         mem_addr = addr;
         // update cache
         if (content[addr[5:4]][0] == 1'b1 &&
             content[addr[5:4]][154:129] == addr[31:6])
         begin
            case (addr[3:2])
               2'b00 : content[addr[5:4]][32:1] = data_write;
               2'b01 : content[addr[5:4]][64:33] = data_write;
               2'b10 : content[addr[5:4]][96:65] = data_write; 
               2'b11 : content[addr[5:4]][128:97] = data_write;
            endcase
            dc_hit = 1;
         end // if tag
         else 
            dc_hit = 0;
      end // if SigMemWrite
      
      if (SigMemRead) 
      begin
         if (content[addr[5:4]][0] == 1'b1 &&
            addr[31:6] == content[addr[5:4]][154:129]) // hit?
         begin 
            case (addr[3:2])
               2'b00 : data_read = content[addr[5:4]][32:1];
               2'b01 : data_read = content[addr[5:4]][64:33];
               2'b10 : data_read = content[addr[5:4]][96:65];
               2'b11 : data_read = content[addr[5:4]][128:97];
            endcase
            dc_hit = 1;
         end
         else
         begin // miss
            dc_hit = 0;
            if (counter == 3)
            begin
               content[addr[5:4]] = {addr[31:6],
                                     mem_data,
                                     1'b1};
               counter = 0;
               case (addr[3:2])
                  2'b00 : data_read = content[mem_data[5:4]][32:1];
                  2'b01 : data_read = content[mem_data[5:4]][64:33];
                  2'b10 : data_read = content[mem_data[5:4]][96:65];
                  2'b11 : data_read = content[mem_data[5:4]][128:97];
               endcase
               dc_hit = 1;
            end
            else
            begin
               counter = counter + 1;
            end			// if counter
         end			// if miss
      end // if SigMemRead
     end				// always


endmodule // main
