`timescale 1ns / 1ps
`include "final_top.v"
module top_tb;

  reg clk;
  integer i;
  
  top uut (.clk(clk));

  initial begin
    // Initialize data memory
    for (i = 0; i < 32; i = i + 1) begin
      uut.mem.memory_data[i] = 32'b0;
    end
    uut.mem.memory_data[0] = 76;
    uut.mem.memory_data[1] = 4;
    uut.mem.memory_data[2] = 35;
    uut.mem.memory_data[3] = 2;
    uut.mem.memory_data[4] = 18;
    // initialize Register File
    for (i = 0; i < 32; i = i + 1) begin
      uut.reg1.RegData[i] = 32'b0;
    end
    clk = 0;
  end

  always @(clk) begin

    $display("Sorted Array : %d %d %d %d %d", uut.mem.memory_data[0], uut.mem.memory_data[1],uut.mem.memory_data[2],uut.mem.memory_data[3],uut.mem.memory_data[4]);
  end
  
  initial begin
    #9000 $finish;
  end

  always #20 clk = ~clk;

endmodule