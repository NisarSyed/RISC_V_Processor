module Mux(
  input [63:0] A,
  input [63:0] B,
  input select,
  output [63:0] out
  );
  
  assign out = select ? B : A;
endmodule