`timescale 1ns / 1ps

module instruction_memory (address,control,func,instruction);
  input [31:0] address;
  output reg [31:0] instruction;
  output reg [5:0] func,control;
  reg [31:0] memory_instr[31:0];

  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) begin
      memory_instr[i] = 32'b11111100000000000000000000000000;
    end
  end

  initial begin
	instruction = 32'b11111100000000000000000000000000;
  end

  initial begin
  memory_instr[0]= 32'b00100010001100010000000000000101;
	memory_instr[1]= 32'b00100010001100011111111111111111;
	memory_instr[2]= 32'b00100000000010010000000000000000;
	memory_instr[3]= 32'b00100000000010100000000000000000;
	memory_instr[4]= 32'b00000010001010011011100000100010;
	memory_instr[5]= 32'b00100010000100100000000000000000;
	memory_instr[6]= 32'b10001110010010110000000000000000;
	memory_instr[7]= 32'b10001110010011000000000000000001;
	memory_instr[8]= 32'b00000001100010111100000000101010;
	memory_instr[9]= 32'b00010011000000000000000000000010;
	memory_instr[10]=32'b10101110010011000000000000000000;
	memory_instr[11]=32'b10101110010010110000000000000001;
	memory_instr[12]=32'b00100010010100100000000000000001;
	memory_instr[13]=32'b00100001010010100000000000000001;
	memory_instr[14]=32'b00010101010101111111111111110111;
	memory_instr[15]=32'b00100001001010010000000000000001;
  memory_instr[16]=32'b00010101001100011111111111110010;
  end

  

  always @(address) begin
    if (address == -4) begin
      instruction = 32'b11111100000000000000000000000000;
    end else begin
      instruction = memory_instr[address>>2];
    end
	control = instruction[31:26];
    func = instruction[5:0];
  end

endmodule