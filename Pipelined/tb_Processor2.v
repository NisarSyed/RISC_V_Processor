`timescale 1ns / 1ps

module tb_Processor2();
reg clk;
reg reset;
wire [63:0] r1, r2,r3,r4,r5;

RISC_V_Processor2 pro(clk, reset,r1,r2,r3,r4,r5);

  initial 
    begin
      reset = 1'b1; clk = 1'b0;
      #10 reset = 1'b0;
      #4000 reset = 1'b1;
      $finish;
  	end
  
  always 
    begin
    #5 clk = ~clk;
  	end
endmodule