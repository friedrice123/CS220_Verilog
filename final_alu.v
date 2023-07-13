`timescale 1ns / 1ps

module ALU (data1, read2, instruction, source, ctrl_alu, zero, ALUresult);
input[31:0] data1, read2, instruction;
input source;
input [ 3:0] ctrl_alu;
output reg zero;
output reg [31:0] ALUresult;

  reg [31:0] data2;

  always @(source, read2, instruction) begin
    if (source == 0) begin
      data2 = read2;
    end else begin
      if (instruction[15] == 1'b0) begin
        data2 = {16'b0, instruction[15:0]};
      end else begin
        data2 = {{16{1'b1}}, instruction[15:0]};
      end
    end
  end
 always @(data1, data2, ctrl_alu) begin
  if (ctrl_alu == 4'b0000) begin
    ALUresult = data1 & data2;  // AND
  end else if (ctrl_alu == 4'b0001) begin
    ALUresult = data1 | data2;  // OR
  end else if (ctrl_alu == 4'b0010) begin
    ALUresult = data1 + data2;  // ADD
  end else if (ctrl_alu == 4'b0110) begin
    ALUresult = data1 - data2;  // SUB
  end else if (ctrl_alu == 4'b0111) begin
    ALUresult = (data1 < data2) ? 1 : 0;  // SLT
  end else if (ctrl_alu == 4'b1100) begin
    ALUresult = data1 | ~data2;  // NOR
  end 
    if (ALUresult == 0) begin
      zero = 1;
    end else begin
      zero = 0;
    end
  end
endmodule