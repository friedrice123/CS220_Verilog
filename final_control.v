`timescale 1ns / 1ps

module Control (instruction, destination, jump_or_not, Branch, not_eq, read_memory, memory_to_register, Operation, write_memory, source, write_register);
    input [31:0] instruction;
    output reg destination, jump_or_not, Branch, not_eq, read_memory, memory_to_register, write_memory, source, write_register;
    output reg [1:0] Operation;
  initial begin
    destination = 0;
    jump_or_not = 0;
    Branch = 0;
    read_memory = 0;
    memory_to_register = 0;
    Operation = 2'b00;
    write_memory = 0;
    source = 0;
    write_register = 0;
  end

  always @(instruction) begin
    if (instruction[31:26] == 6'b000000) begin 
        destination = 1;
        source = 0;
        memory_to_register = 0;
        write_register = 1;
        read_memory = 0;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b10;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b001000) begin
        destination = 0;
        source = 1;
        memory_to_register = 0;
        write_register = 1;
        read_memory = 0;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b00;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b001100) begin
        destination = 0;
        source = 1;
        memory_to_register = 0;
        write_register = 1;
        read_memory = 0;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b11;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b000100) begin
        destination = 0;
        source = 0;
        memory_to_register = 0;
        write_register = 0;
        read_memory = 0;
        write_memory = 0;
        Branch = 1;
        not_eq = 0;
        Operation = 2'b01;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b000101) begin
        destination = 0;
        source = 0;
        memory_to_register = 0;
        write_register = 0;
        read_memory = 0;
        write_memory = 0;
        Branch = 1;
        not_eq = 1;
        Operation = 2'b01;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b100011) begin
        destination = 0;
        source = 1;
        memory_to_register = 1;
        write_register = 1;
        read_memory = 1;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b00;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b101011) begin
        destination = 0;
        source = 1;
        memory_to_register = 0;
        write_register = 0;
        read_memory = 0;
        write_memory = 1;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b00;
        jump_or_not = 0;
    end
    else if (instruction[31:26] == 6'b000010) begin
        destination = 0;
        source = 0;
        memory_to_register = 0;
        write_register = 0;
        read_memory = 0;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b01;
        jump_or_not = 1;
    end
    else begin
        destination = 0;
        source = 0;
        memory_to_register = 0;
        write_register = 0;
        read_memory = 0;
        write_memory = 0;
        Branch = 0;
        not_eq = 0;
        Operation = 2'b00;
        jump_or_not = 0;
    end
  end 

endmodule