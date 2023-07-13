`timescale 1ns / 1ps
`include "final_next_pc.v"
`include "final_pc.v"
`include "final_veda_memory.v"
`include "final_instruction_memory.v"
`include "final_register_file.v"
`include "final_alu.v"
`include "final_control.v"
`include "final_control_unit.v"

module top ( clk );
    input clk;
    wire Result_zero, dstRegister, Jumpcontrol, Branchcontrol, Branchnotequal, readmemory, memorytoregister, writememory, Src_ALU, writeRegister;
    wire [1:0] final_op;
    wire [3:0] controlALU;
    wire [ 5:0] control_mem, function_memory;
    wire [31:0] in, out, instruction_memory,register_data,read_data1, read_data2, final_result;

  Program_counter t1 (
      .clk   (clk),
      .nextPC(in),
      .PC    (out)
  );

  instruction_memory t2 (
      .address    (out),
      .control    (control_mem),
      .func       (function_memory),
      .instruction(instruction_memory)
  );


  Register reg1 (
      .clk        (clk),
      .instruction(instruction_memory),
      .WriteEnable(writeRegister),
      .destination(dstRegister),
      .WriteData  (register_data),
      .ReadData1  (read_data1),
      .ReadData2  (read_data2)
  );


  ALU t4 (
      .data1      (read_data1),
      .read2      (read_data2),
      .instruction(instruction_memory),
      .source     (Src_ALU),
      .ctrl_alu (controlALU),
      .zero       (Result_zero),
      .ALUresult  (final_result)
  );


  ALU_control t5 (
      .Operation      (final_op),
      .instruction(function_memory),
      .ctrl_alu (controlALU)
  );

  Control t6 (
      .instruction(instruction_memory),
      .destination     (dstRegister),
      .jump_or_not       (Jumpcontrol),
      .Branch     (Branchcontrol),
      .not_eq        (Branchnotequal),
      .read_memory    (readmemory),
      .memory_to_register   (memorytoregister),
      .Operation      (final_op),
      .write_memory   (writememory),
      .source     (Src_ALU),
      .write_register   (writeRegister)
  );


  data_memory mem (
      .clk      (clk),
      .address  (final_result),
      .writeData(read_data2),
      .result   (final_result),
      .write_memory (writememory),
      .read_memory  (readmemory),
      .memory_to_register (memorytoregister),
      .readData (register_data)
  );


  Next_pc t8 (
      .PC         (out),
      .instruction(instruction_memory),
      .jump_or_not       (Jumpcontrol),
      .Branch     (Branchcontrol),
      .not_eq        (Branchnotequal),
      .zero       (Result_zero),
      .nextPC     (in)
  );

endmodule
