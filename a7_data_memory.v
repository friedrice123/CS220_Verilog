module data_memory(
    input clk,
    input reset,
    input [4:0] read1,
    input [4:0] read2,
    input [4:0] write,
    input we,
    input re,
    input [31:0] data_in,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);


reg [31:0] memory [0:15];

initial begin
    // if(reset) begin
        memory[0]= 32'b000000_00000_00000_00000_00000_001111;
        memory[1]= 32'b000000_00000_00000_00000_00000_000111;
        memory[2]= 32'b000000_00000_00000_00000_00000_000011;
        memory[3]= 32'b000000_00000_00000_00000_00000_000001;
        memory[4]= 32'b000000_00000_00000_00000_00000_000000;
        memory[5]= 32'b000000_00000_00000_00000_00000_000000;
        memory[6]= 32'b000000_00000_00000_00000_00000_000000;
        memory[7]= 32'b000000_00000_00000_00000_00000_000000;
        memory[8]= 32'b000000_00000_00000_00000_00000_000000;
        memory[9]= 32'b000000_00000_00000_00000_00000_000000;
        memory[10]=32'b000000_00000_00000_00000_00000_000000;
        memory[11]=32'b000000_00000_00000_00000_00000_000000;
        memory[12]=32'b000000_00000_00000_00000_00000_000000;
        memory[13]=32'b000000_00000_00000_00000_00000_000000;
        memory[14]=32'b000000_00000_00000_00000_00000_000000;
        memory[15]=32'b000000_00000_00000_00000_00000_000000;
    // end
end
always @(posedge clk) begin
    if (we) begin
        memory[write] = data_in;
    end

    if (re) begin
        data_out1 = memory[read1];
        data_out2 = memory[read2];
    end
    else begin
        data_out1 = 0;
        data_out2 = 0;
    end
end
endmodule
