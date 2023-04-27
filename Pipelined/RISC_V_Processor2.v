`timescale 1ns / 1ps


module RISC_V_Processor2(clk, reset,r1,r2,r3,r4,r5);
   input clk;
   input reset;
   output wire [63:0] r1,r2,r3,r4,r5;
  
wire [63:0] Init_PC_In;
wire [63:0] Init_PC_Out;
wire [63:0] MUX1_Input1;
wire [63:0] MUX1_Input2;
wire [31:0] Instruction_IF;
wire [31:0] Instruction_ID;
wire [63:0] PC_Out_ID;
// wire to_branch;
wire [6:0] opcode_ID;
wire [4:0] rd_ID;
wire [2:0] f3_ID;
wire [4:0] rs1_ID;
wire [4:0] rs2_ID;
wire [6:0] f7_ID;
wire [63:0] imm_data_ID;
wire [63:0] MUX5_Out;
wire [4:0] rd_WB;
wire [63:0] Read_Data_1_ID;
wire [63:0] Read_Data_2_ID;
wire RegWrite_WB;
wire [1:0] ALUOp_ID;
wire Branch_ID;
wire MemRead_ID;
wire MemtoReg_ID;
wire MemWrite_ID;
wire ALUSrc_ID;
wire RegWrite_ID;
wire Branch_EX;
wire MemRead_EX;
wire MemtoReg_EX;
wire MemWrite_EX;
wire ALUSrc_EX;
wire RegWrite_EX;
wire [63:0] Read_Data_1_EX;
wire [63:0] Read_Data_2_EX;
wire [63:0] PC_Out_EX;
wire [1:0] ALUOp_EX;
wire [63:0] imm_data_EX;
wire [3:0] Funct_EX;
wire [4:0] rs1_EX;
wire [4:0] rs2_EX;
wire [4:0] rd_EX;
wire [3:0] Operation_EX;
wire [63:0] shift_Left_out;
wire [63:0] Branch_Adder_Out_EX;
wire [63:0] MUX_out_EX;
wire [63:0] Result_EX;
wire Zero_EX;
wire pos_EX;
wire RegWrite_MEM;
wire MemtoReg_MEM;
wire MemWrite_MEM;
wire MemRead_MEM;
wire Branch_MEM;
wire Zero_MEM;
wire [63:0] Result_MEM;
wire [63:0] Branch_Adder_Out_MEM;
wire [63:0] Read_Data_2_MEM;
wire [4:0] rd_MEM;
wire pos_MEM;
wire to_branch_MEM;
wire blt_MEM;
wire bge_MEM;
wire bne_MEM;
wire beq_MEM;
wire [2:0] funct3_MEM;
wire [63:0] Read_Data_MEM;
wire MemtoReg_WB;
wire [63:0] Read_Data_WB;
wire [63:0]Result_WB;
wire [1:0] fwd_A, fwd_B;
wire [63:0] mux_a_out, mux_b_out;

Program_Counter p1(clk, reset, Init_PC_In, Init_PC_Out);

Adder a1(Init_PC_Out, 64'd4, MUX1_Input1);

MUX m1(MUX1_Input1,MUX1_Input2, to_branch_MEM,Init_PC_In);

Instruction_Memory i1(Init_PC_Out, Instruction_IF);

IFID i2(clk, reset, Init_PC_Out, Instruction_IF, Instruction_ID, PC_Out_ID);

Instruction i3(Instruction_ID, opcode_ID, rd_ID, f3_ID, rs1_ID, rs2_ID, f7_ID);

Imm_data_gen i4(Instruction_ID, imm_data_ID);   

RegisterFile RF(clk, reset, rs1_ID, rs2_ID, rd_WB, MUX5_Out, RegWrite_WB, Read_Data_1_ID, Read_Data_2_ID, r1, r2, r3, r4,r5);

Control_Unit c1(opcode_ID, ALUOp_ID, Branch_ID, MemRead_ID, MemtoReg_ID, MemWrite_ID, ALUSrc_ID, RegWrite_ID);

IDEX i5(clk, reset, {Instruction_ID[30], Instruction_ID[14:12]}, ALUOp_ID, MemtoReg_ID, RegWrite_ID, Branch_ID, MemWrite_ID, MemRead_ID, ALUSrc_ID, Read_Data_1_ID, Read_Data_2_ID, rd_ID, rs1_ID, rs2_ID, imm_data_ID, PC_Out_ID, PC_Out_EX, Funct_EX, ALUOp_EX, MemtoReg_EX, RegWrite_EX, Branch_EX, MemWrite_EX, MemRead_EX, ALUSrc_EX, Read_Data_1_EX, Read_Data_2_EX, rs1_EX, rs2_EX, rd_EX, imm_data_EX);

ALU_Control a2(ALUOp_EX, Funct_EX, Operation_EX);

Adder a3(PC_Out_EX, imm_data_EX << 1, Branch_Adder_Out_EX);

//triple mux for first alu input
MUX_3 first(Read_Data_1_EX, mux5_Out, Result_MEM, fwd_A, mux_a_out);

//triple mux for second alu input
MUX_3 second(Read_Data_2_EX, mux5_Out, Result_MEM, fwd_B, mux_b_out);

MUX m2(mux_b_out, imm_data_EX, ALUSrc_EX, MUX_out_EX);

ALU_64_bit a4(mux_a_out, MUX_out_EX, Operation_EX, Zero_EX, Result_EX, pos_EX);

Forwarding_Unit FU(rs1_EX, rs2_EX, rd_EX, rd_MEM, RegWrite_EX, MemtoReg_EX, RegWrite_MEM, fwd_A, fwd_B);  

EXMEM e1(clk, reset, rd_EX, Branch_EX, MemWrite_EX, MemRead_EX, MemtoReg_EX, RegWrite_EX, Branch_Adder_Out_EX, Result_EX, Zero_EX, Read_Data_2_EX, Read_Data_2_MEM, Branch_Adder_Out_MEM, rd_MEM, Branch_MEM, MemWrite_MEM, MemRead_MEM, MemtoReg_MEM, RegWrite_MEM, Result_MEM, Zero_MEM);

branch_module b1(Zero_MEM, pos_MEM, Branch_MEM, funct3_MEM, bne_MEM, beq_MEM, bge_MEM, blt_MEM, to_branch_MEM);

Data_Memory d1(clk, Result_MEM, Read_Data_2_MEM, MemWrite_MEM, MemRead_MEM, Read_Data_MEM, funct3_MEM);

MEMWB m0(clk, reset, Result_MEM, Read_Data_MEM, rd_MEM, MemtoReg_MEM, RegWrite_MEM, MemtoReg_WB, RegWrite_WB, Result_WB, Read_Data_WB, rd_WB);

MUX m5(Result_WB, Read_Data_WB, MemtoReg_WB, MUX5_Out);

always @(posedge clk) 
    begin
        $monitor("PC_In = ", Init_PC_In, ", PC_Out = ", Init_PC_Out, 
        ", Instruction = %b", Instruction_ID,", Opcode = %b", opcode_ID, 
        ", Funct3 = %b", f3_ID, ", rs1 = %d", rs1_ID,
        ", rs2 = %d", rs2_ID, ", rd = %d", rd_ID, ", funct7 = %b", f7_ID,
        ", ALUOp = %b", ALUOp_ID, ", imm_value = %d", imm_data_ID);
    end


endmodule