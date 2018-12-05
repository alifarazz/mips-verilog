`timescale 1ns / 1ps

module main_test;

   // Inputs
   reg clk, resetn=1;
   reg mode;
   reg [7:0] first_op, second_op;
   reg [1:0] operation;
   reg [15:0] init_time;


   // Outputs
   wire [6:0] seg_out0,
	      seg_out1,
	      seg_out2,
	      seg_out3,
	      seg_out4;



   integer    i;
   parameter calc = 0, clock = 1;
   parameter addition = 0,
     subtration = 1,
     multiplicaion = 2,
     division = 3;



   // Instantiate the Unit Under Test (UUT)
   main uut(clk,
	    resetn,
	    mode,
	    init_time,
	    first_op,
	    second_op,
	    operation,
	    seg_out0,
	    seg_out1,
	    seg_out2,
	    seg_out3,
	    seg_out4
	    );

   reg [memory_width] 2d_reg [memory_depth];

   initial begin
      /// Initialize Inputs
      resetn = 0;
      init_time = {4'd2, 4'd2, 4'd5, 4'd4};
      mode = clock;
      $readmemb("pth", 2d_reg, start_addr, end_addr); // read file contents binary
      $readmemb("pth", 2d_reg, start_addr, end_addr); // read file contents hex
      

      first_op = 7;
      second_op = 8;
      operation = multiplicaion;
      // operation = addition;

      #25000;//      #1;
      mode = calc;

      // #1;
   end

   initial begin
      clk = 0;
      for (i = 0; i < 2000; i = i + 1)
	#25 clk = ~clk;
   end


   initial begin
      $dumpfile("./main_test.vcd");
      $dumpvars;
   end

endmodule
