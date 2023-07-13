`timescale 1ns / 1ps

module ALU_control (
    input [1:0] Operation,
    input [5:0] instruction,
    output reg [3:0] ctrl_alu
);
  always @(Operation, instruction) begin
    if (Operation == 2'b00) begin
      ctrl_alu = 4'b0010;
    end else if (Operation == 2'b01) begin
      ctrl_alu = 4'b0110;
    end else if (Operation == 2'b10) begin
      if (instruction[5:0] == 6'b100000) begin
        ctrl_alu = 4'b0010;
      end else if (instruction[5:0] == 6'b100001) begin
        ctrl_alu = 4'b0010;
      end else if (instruction[5:0] == 6'b100010) begin
        ctrl_alu = 4'b0110;
      end else if (instruction[5:0] == 6'b100011) begin
        ctrl_alu = 4'b0101;
      end else if (instruction[5:0] == 6'b100100) begin
        ctrl_alu = 4'b0000;
      end else if (instruction[5:0] == 6'b100101) begin
        ctrl_alu = 4'b0001;
      end else if (instruction[5:0] == 6'b100110) begin
        ctrl_alu = 4'b0011;
      end else if (instruction[5:0] == 6'b100111) begin
        ctrl_alu = 4'b1100;
      end else if (instruction[5:0] == 6'b101010) begin
        ctrl_alu = 4'b0111;
      end else if (instruction[5:0] == 6'b101011) begin
        ctrl_alu = 4'b0111;
      end else begin
        ctrl_alu = 4'b0000;
      end
    end else begin
      ctrl_alu = 4'b0000;
    end
  end

endmodule