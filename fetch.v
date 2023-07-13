module fetch(
    input clk,              // clock input
    input [4:0] a1,       // address input (5-bit address for 32 words)
    input [4:0] a2,
    input  we,               // write enable input
    input re,
    input [31:0] data_in,
    output reg signed [31:0] data_out // output data
);

reg [31:0] mem [0:31];    // 32x32 memory array
integer i;

initial begin
    for(i = 0; i < 32; i = i + 1) begin
        mem[i] <= 0;
    end
    mem[1] <= 32'b0_10000001_10010000000000000000000;
    mem[2] <= 32'b1_01111111_10000000000000000000000;
    mem[3] <= 32'b0_10000001_00110000000000000000000;
    mem[4] <= 32'b0_10000001_00110000000000000000001;
    mem[5] <= 32'b0_10000001_00110000000000000000011;
    mem[6] <= 32'b0_10000001_00110000000000000000111;
end
always @(posedge clk) begin
    if (we) begin
        mem[a1] <= data_in;
    end

    if (re) begin
        data_out = mem[a2];
    end
end
endmodule
