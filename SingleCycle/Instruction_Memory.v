module Instruction_Memory(
  input [63:0] Inst_Address,
  output [31:0] Instruction
  );
  
  reg [7:0] Inst_Mem [119:0] ;
  initial begin
    // addi x10, x0, 0
    Inst_Mem[0]  = 8'b00010011;
    Inst_Mem[1]  = 8'b00000101;
    Inst_Mem[2]  = 8'b00000000;
    Inst_Mem[3]  = 8'b00000000;

    // addi x11, x0, 20
    Inst_Mem[4]  = 8'b10010011;
    Inst_Mem[5]  = 8'b00000101;
    Inst_Mem[6]  = 8'b01000000;
    Inst_Mem[7]  = 8'b00000001;
    
    // addi x9, x0, 2
    Inst_Mem[8]  = 8'b10010011;
    Inst_Mem[9]  = 8'b00000100;
    Inst_Mem[10] = 8'b00100000;
    Inst_Mem[11] = 8'b00000000;

    // sw x9, 0(x10)
    Inst_Mem[12] = 8'b00100011;
    Inst_Mem[13] = 8'b00100000;
    Inst_Mem[14] = 8'b10010101;
    Inst_Mem[15] = 8'b00000000;

    // addi x9, x0, 5
    Inst_Mem[16] = 8'b10010011;
    Inst_Mem[17] = 8'b00000100;
    Inst_Mem[18] = 8'b01010000;
    Inst_Mem[19] = 8'b00000000;

    // sw x9, 4(x10)
    Inst_Mem[20] = 8'b00100011;
    Inst_Mem[21] = 8'b00100010;
    Inst_Mem[22] = 8'b10010101;
    Inst_Mem[23] = 8'b00000000;

    // addi x9, x0, 3 
    Inst_Mem[24] = 8'b10010011;
    Inst_Mem[25] = 8'b00000100;
    Inst_Mem[26] = 8'b00110000;
    Inst_Mem[27] = 8'b00000000;

    // sw x9, 4(x10)
    Inst_Mem[28] = 8'b00100011;
    Inst_Mem[29] = 8'b00100100;
    Inst_Mem[30] = 8'b10010101;
    Inst_Mem[31] = 8'b00000000;

    // addi x9, x0, 7 
    Inst_Mem[32] = 8'b10010011;
    Inst_Mem[33] = 8'b00000100;
    Inst_Mem[34] = 8'b01110000;
    Inst_Mem[35] = 8'b00000000;

    // sw x9, 12(x10)
    Inst_Mem[36] = 8'b00100011;
    Inst_Mem[37] = 8'b00100110;
    Inst_Mem[38] = 8'b10010101;
    Inst_Mem[39] = 8'b00000000;

    // addi x9, x0, 4
    Inst_Mem[40] = 8'b10010011;
    Inst_Mem[41] = 8'b00000100;
    Inst_Mem[42] = 8'b01000000;
    Inst_Mem[43] = 8'b00000000;

    // sw x9, 16(x10)
    Inst_Mem[44] = 8'b00100011;
    Inst_Mem[45] = 8'b00101000;
    Inst_Mem[46] = 8'b10010101;
    Inst_Mem[47] = 8'b00000000;

    

    // addi x1 x0 4
    Inst_Mem[48] = 8'b10010011;
    Inst_Mem[49] = 8'b00000000;
    Inst_Mem[50] = 8'b01000000;
    Inst_Mem[51] = 8'b00000000;

    // blt x1 x11 4
    Inst_Mem[52] = 8'b01100011;
    Inst_Mem[53] = 8'b11000010;
    Inst_Mem[54] = 8'b10100000;
    Inst_Mem[55] = 8'b00000000;

    // add x3 x1 x10
    Inst_Mem[56] = 8'b10110011;
    Inst_Mem[57] = 8'b10000001;
    Inst_Mem[58] = 8'b10100000;
    Inst_Mem[59] = 8'b00000000;

    // lw x4 0(x3)
    Inst_Mem[60] = 8'b00000011;
    Inst_Mem[61] = 8'b10100010;
    Inst_Mem[62] = 8'b00000001;
    Inst_Mem[63] = 8'b00000000;

    // addi x5 x1 -4
    Inst_Mem[64] = 8'b10010011;
    Inst_Mem[65] = 8'b10000010;
    Inst_Mem[66] = 8'b11000000;
    Inst_Mem[67] = 8'b11111111;

    // add x6 x5 x10
    Inst_Mem[68] = 8'b00110011;
    Inst_Mem[69] = 8'b10000011;
    Inst_Mem[70] = 8'b10100010;
    Inst_Mem[71] = 8'b00000000;

    // lw x7 0(x6)
    Inst_Mem[72] = 8'b10000011;
    Inst_Mem[73] = 8'b00100011;
    Inst_Mem[74] = 8'b00000011;
    Inst_Mem[75] = 8'b00000000;
    
    // bge x0 x5 32
    Inst_Mem[76] = 8'b01100011;
    Inst_Mem[77] = 8'b01010000;
    Inst_Mem[78] = 8'b01010000;
    Inst_Mem[79] = 8'b00000010;

    // bge x4 x7 28
    Inst_Mem[80] = 8'b01100011;
    Inst_Mem[81] = 8'b01011110;
    Inst_Mem[82] = 8'b01110010;
    Inst_Mem[83] = 8'b00000000;

    // sw x7 4(x6)
    Inst_Mem[84] = 8'b00100011;
    Inst_Mem[85] = 8'b00100010;
    Inst_Mem[86] = 8'b01110011;
    Inst_Mem[87] = 8'b00000000;

    // addi x5 x5 -4
    Inst_Mem[88] = 8'b10010011;
    Inst_Mem[89] = 8'b10000010;
    Inst_Mem[90] = 8'b11000010;
    Inst_Mem[91] = 8'b11111111;

    // add x6 x5 x10
    Inst_Mem[92] = 8'b00110011;
    Inst_Mem[93] = 8'b10000011;
    Inst_Mem[94] = 8'b10100010;
    Inst_Mem[95] = 8'b00000000;

    // lw x7 0(x6)
    Inst_Mem[96] = 8'b10000011;
    Inst_Mem[97] = 8'b00100011;
    Inst_Mem[98] = 8'b00000011;
    Inst_Mem[99] = 8'b00000000;

    // bge x0 x5 8
    Inst_Mem[100] = 8'b01100011;
    Inst_Mem[101] = 8'b01010100;
    Inst_Mem[102] = 8'b01010000;
    Inst_Mem[103] = 8'b00000000;

    // blt x4 x7 -20
    Inst_Mem[104] = 8'b11100011;
    Inst_Mem[105] = 8'b01000110;
    Inst_Mem[106] = 8'b01110010;
    Inst_Mem[107] = 8'b11111110;

    // sw x4 4(x6)
    Inst_Mem[108] = 8'b00100011;
    Inst_Mem[109] = 8'b00100010;
    Inst_Mem[110] = 8'b01000011;
    Inst_Mem[111] = 8'b00000000;

    // addi x1 x1 4
    Inst_Mem[112] = 8'b10010011;
    Inst_Mem[113] = 8'b10000000;
    Inst_Mem[114] = 8'b01000000;
    Inst_Mem[115] = 8'b00000000;

    // blt x1 x11 -60
    Inst_Mem[116] = 8'b11100011;
    Inst_Mem[117] = 8'b11000010;
    Inst_Mem[118] = 8'b10110000;
    Inst_Mem[119] = 8'b11111100;
  end
  
  assign Instruction[31:0] = {Inst_Mem[Inst_Address+2'b11], Inst_Mem[Inst_Address+2'b10], Inst_Mem[Inst_Address+1'b1], Inst_Mem[Inst_Address]};
  
endmodule