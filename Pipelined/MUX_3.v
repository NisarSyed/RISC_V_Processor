`timescale 1ns / 1ps

module MUX_3( 
    input [63:0] a, b, c,
    input [1:0] sel,
    output reg [63:0] data_out   
    );

always@(*)
    begin
        case (sel)
            2'b00: data_out = a;
            2'b01: data_out = b;
            2'b10: data_out = c; 
        endcase
    end
endmodule