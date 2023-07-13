`timescale 1ns / 1ps

module data_memory (clk,address,writeData,result,write_memory,read_memory,memory_to_register,readData);
    input clk;
    input [31:0] address,writeData,result;
    input write_memory,read_memory,memory_to_register;
    output reg [31:0] readData;
    reg [31:0] memory_data[31:0]; 

  initial begin
    memory_data[0]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[1]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[2]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[3]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[4]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[5]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[6]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[7]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[8]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[9]= 32'b000000_00000_00000_00000_00000_000000;
	memory_data[10]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[11]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[12]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[13]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[14]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[15]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[16]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[17]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[18]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[19]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[20]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[21]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[22]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[23]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[24]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[25]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[26]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[27]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[28]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[29]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[30]=32'b000000_00000_00000_00000_00000_000000;
	memory_data[31]=32'b000000_00000_00000_00000_00000_000000;
  end

  always @(posedge clk) begin
    if (write_memory) begin
      memory_data[address] = writeData;
    end
  end

  always @(address,read_memory,memory_to_register,result) begin
    if (read_memory) begin
      if (memory_to_register) readData = memory_data[address];
	  else readData = result;  
    end 
	else readData = result;
  end

endmodule
