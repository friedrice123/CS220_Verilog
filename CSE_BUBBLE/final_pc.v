`timescale 1ns / 1ps

module Program_counter (
    input clk,
    input [31:0] nextPC,
    output reg [31:0] PC
);

  initial begin
    PC = -4;
  end

  always @(posedge clk) begin
    PC = nextPC;
  end

endmodule
