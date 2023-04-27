`timescale 1ns / 1ps

module RISC_V_Processor(
  input clk,
  input reset,
  output wire [63:0] Index_0,
  output wire [63:0] Index_1,
  output wire [63:0] Index_2,
  output wire [63:0] Index_3,
  output wire [63:0] Index_4
  );
  
  wire [63:0] PC_Out;
  wire [63:0] PC_In;
  wire [63:0] PC_offset_4;
  wire [31:0] IMem_out;
  wire [6:0] opcode;
  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  wire [2:0] funct3;
  wire [6:0] funct7;
  wire [63:0] imm_data;
  wire [1:0] ALUOp;
  wire branch;
  wire MemRead;
  wire MemtoReg;
  wire MemWrite;
  wire ALUSrc;
  wire RegWrite;
  wire [63:0] write_data;
  wire [63:0] readdata1;
  wire [63:0] readdata2;
  wire [3:0] Operation;
  wire Zero;
  wire [63:0] Result;
  wire [63:0] mux_1_out;
  wire [63:0] DMem_Read;
  wire [63:0] shifted_imm_data;
  wire [63:0] PC_offset_branch;
  wire mux3_select;
  wire bge, blt, bne, beq;
  wire Pos;
  wire to_branch;
  
  Program_Counter PC(clk, reset, PC_In, PC_Out);
  Adder add1(PC_Out, 64'd4, PC_offset_4);
  Instruction_Memory IM(PC_Out, IMem_out);
  InsParser IP(IMem_out, opcode, rd, funct3, rs1, rs2, funct7);
  ImmGen IDE(IMem_out, imm_data);
  Control_Unit CU(opcode, ALUOp, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
  registerFile RF(clk, reset, rs1, rs2, rd, write_data, RegWrite, readdata1, readdata2);
  ALU_Control ctrl(ALUOp,{IMem_out[30],IMem_out[14:12]},Operation);
  Mux mux1(readdata2,	 imm_data, ALUSrc, mux_1_out);
  ALU_64_bit ALU(readdata1, mux_1_out, Operation, Zero, Result, Pos);
  Data_Memory DM(clk, Result, readdata2, MemWrite, MemRead, funct3, DMem_Read, Index_0, Index_1, Index_2, Index_3, Index_4);
  Mux mux2(Result,DMem_Read,  MemtoReg, write_data);
  Adder add4(PC_Out, imm_data << 1, PC_offset_branch);
  Branch BR(Zero, Pos, Branch, funct3, bne, beq, bge, blt, to_branch);
  Mux mux3(PC_offset_4, PC_offset_branch, to_branch, PC_In);  
  
  always @(posedge clk) 
    begin
        $monitor("PC_In = ", PC_In, ", PC_Out = ", PC_Out, 
        ", Instruction = %b", IMem_out,", Opcode = %b", opcode, 
        ", Funct3 = %b", funct3, ", rs1 = %d", rs1,
        ", rs2 = %d", rs2, ", rd = %d", rd, ", funct7 = %b", funct7,
        ", ALUOp = %b", ALUOp, ", imm_value = %d", imm_data,
         ", Operation = %b", Operation);
    end
  
endmodule