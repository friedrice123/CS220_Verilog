module single_port_memory_mod(
    input clk,              // clock input
    input rst,              // reset input
    input [4:0] addr_a,       // address input (5-bit address for 32 words)
    // input mode,             // mode input (0 for scribble mode, 1 for interpret mode)
    input we,               // write enable input
    // input [4:0] addr_b,  
    input [31:0] data_in,   // input data
    output reg signed [31:0] data_out // output data
);

reg [31:0] mem [0:31];    // 32x32 memory array
reg [4:0] temp_addr;
integer i;

initial begin
    for(i = 0; i < 32; i = i + 1) begin
        mem[i] <= 0;
    end
    mem[1] <= 32'b0_10000001_10010000000000000000000;
    mem[7] <= 32'b1_01111111_10000000000000000000000;
    mem[10] <= 32'b0_10000001_00110000000000000000000;
end
always @(posedge clk, posedge rst) begin
    if (rst) begin        // reset memory and output to 0
        data_out <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
    end
    else if (we == 0) begin  // scribble mode
        mem[addr_a] <= data_in;
          // drive input data on output
    end
end
always @(posedge clk) begin 
    temp_addr <= addr_a;
end 
always @(mem[temp_addr]) begin 
    data_out <= mem[temp_addr];
end 

endmodule