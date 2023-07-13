`timescale 1ns / 1ps

module Register (
    input clk,
    input [31:0] instruction, 
    input WriteEnable,
    input destination,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
);
  wire [4:0] dest_for_imm,dest_for_reg;
  assign dest_for_imm = instruction[20:16];
  assign dest_for_reg = instruction[15:11];

  reg [31:0] RegData[31:0];
  integer i;

  initial begin
    for (i = 0; i < 32; i = i + 1) begin
      RegData[i] = 32'b0;
    end
  end
  
  assign ReadData1 = RegData[instruction[25:21]];
  assign ReadData2 = RegData[instruction[20:16]];

  always @(posedge clk) begin
    if (WriteEnable == 1'b1 ) begin
        if(destination==1'b0)RegData[dest_for_imm] = WriteData; //immediate
		    else RegData[dest_for_reg] = WriteData; //register
    end
  end

endmodule
