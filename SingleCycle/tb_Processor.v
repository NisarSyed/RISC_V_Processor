`timescale 1ns / 1ps

module tb_Processor();
  reg clk;
  reg reset;
  wire [63:0] Index_0;
  wire [63:0] Index_1;
  wire [63:0] Index_2;
  wire [63:0] Index_3;
  wire [63:0] Index_4;
  
  
  RISC_V_Processor r1(clk, reset, Index_0,Index_1,Index_2,Index_3,Index_4);
  
  initial begin
      reset = 1'b1; clk = 1'b0;
      #10 reset = 1'b0;
      #4000 reset = 1'b1;
      $finish;
  end
  
  always begin
    #5 clk = ~clk;
  end
  	
endmodule