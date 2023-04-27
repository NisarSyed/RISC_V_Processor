module Data_Memory(
  input clk,
  input [63:0] Mem_Addr,
  input [63:0] Write_Data,
  input MemWrite,
  input MemRead,
  input [2:0] funct3,
  output reg [63:0] Read_Data,
  output reg [63:0] Index_0,
  output reg [63:0] Index_1,
  output reg [63:0] Index_2,
  output reg [63:0] Index_3,
  output reg [63:0] Index_4
  );
  
  reg [7:0] DataMemory [63:0];

	initial
	begin
		DataMemory[0] = 8'h02;
		DataMemory[1] = 8'h04;
		DataMemory[2] = 8'h08;
		DataMemory[3] = 8'h0c;
		DataMemory[4] = 8'h0e;
		DataMemory[5] = 8'h22;
		DataMemory[6] = 8'h44;
		DataMemory[7] = 8'h88;
		DataMemory[8] = 8'hcc;
		DataMemory[9] = 8'hee;
		DataMemory[10] = 8'haa;
		DataMemory[11] = 8'hbb;
		DataMemory[12] = 8'hcc;
		DataMemory[13] = 8'hdd;
		DataMemory[14] = 8'hee;
		DataMemory[15] = 8'h34;
		DataMemory[16] = 8'h45;
		DataMemory[17] = 8'h66;
		DataMemory[18] = 8'h02;
		DataMemory[19] = 8'h04;
		DataMemory[20] = 8'h00;
		DataMemory[21] = 8'h00;
		DataMemory[22] = 8'h01;
		DataMemory[23] = 8'h34;
		DataMemory[24] = 8'h24;
		DataMemory[25] = 8'h25;
		DataMemory[26] = 8'h26;
		DataMemory[27] = 8'h27;
		DataMemory[28] = 8'h28;
		DataMemory[29] = 8'h29;
		DataMemory[30] = 8'h30;
		DataMemory[31] = 8'h31;
		DataMemory[32] = 8'h32;
		DataMemory[33] = 8'h33;
		DataMemory[34] = 8'h34;
		DataMemory[35] = 8'h35;
		DataMemory[36] = 8'h36;
		DataMemory[37] = 8'h37;
		DataMemory[38] = 8'h38;
		DataMemory[39] = 8'h39;
		DataMemory[40] = 8'h40;
		DataMemory[41] = 8'h41;
		DataMemory[42] = 8'h42;
		DataMemory[43] = 8'h43;
		DataMemory[44] = 8'h44;
		DataMemory[45] = 8'h45;
		DataMemory[46] = 8'h46;
		DataMemory[47] = 8'h47;
		DataMemory[48] = 8'h48;
		DataMemory[49] = 8'h49;
		DataMemory[50] = 8'h50;
		DataMemory[51] = 8'h51;
		DataMemory[52] = 8'h52;
		DataMemory[53] = 8'h53;
		DataMemory[54] = 8'h54;
		DataMemory[55] = 8'h55;
		DataMemory[56] = 8'h56;
		DataMemory[57] = 8'h57;
		DataMemory[58] = 8'h58;
		DataMemory[59] = 8'h59;
		DataMemory[60] = 8'h60;
		DataMemory[61] = 8'h61;
		DataMemory[62] = 8'h62;
		DataMemory[63] = 8'h63;
	end
  always @(posedge clk) begin
    if (MemWrite) begin
      if (funct3 == 3'b010) begin
      DataMemory[Mem_Addr] = Write_Data[7:0];
      DataMemory[Mem_Addr+1] = Write_Data[15:8];
      DataMemory[Mem_Addr+2] = Write_Data[23:16];
      DataMemory[Mem_Addr+3] = Write_Data[31:24];  
      end
      else if (funct3 == 3'b011) begin
      DataMemory[Mem_Addr] = Write_Data[7:0];
      DataMemory[Mem_Addr+1] = Write_Data[15:8];
      DataMemory[Mem_Addr+2] = Write_Data[23:16];
      DataMemory[Mem_Addr+3] = Write_Data[31:24];
      DataMemory[Mem_Addr+4] = Write_Data[39:32];
      DataMemory[Mem_Addr+5] = Write_Data[47:40];
      DataMemory[Mem_Addr+6] = Write_Data[55:48];
      DataMemory[Mem_Addr+7] = Write_Data[63:56];  
      end
      
    end
  end
  always @(*) begin
    if (MemRead) begin
      if (funct3 == 3'b010) begin
        Read_Data = {32'd0, DataMemory[Mem_Addr + 3], DataMemory[Mem_Addr + 2], DataMemory[Mem_Addr + 1], DataMemory[Mem_Addr]};
      end
      else if (funct3 == 3'b011) begin
        Read_Data = {DataMemory[Mem_Addr + 7], DataMemory[Mem_Addr + 6], DataMemory[Mem_Addr + 5], DataMemory[Mem_Addr+4], DataMemory[Mem_Addr + 3], DataMemory[Mem_Addr + 2], DataMemory[Mem_Addr + 1], DataMemory[Mem_Addr]};
      end
    end
    Index_0 <= {32'b0,DataMemory[3],DataMemory[2],DataMemory[1],DataMemory[0]};
    Index_1 <= {32'b0,DataMemory[7],DataMemory[6],DataMemory[5],DataMemory[4]};
    Index_2 <= {32'b0,DataMemory[11],DataMemory[10],DataMemory[9],DataMemory[8]};
    Index_3 <= {32'b0,DataMemory[15],DataMemory[14],DataMemory[13],DataMemory[12]};
    Index_4 <= {32'b0,DataMemory[19],DataMemory[18],DataMemory[17],DataMemory[16]};
    
  end
endmodule