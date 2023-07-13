module single_port_memory(
    input clk,              // clock input
    input rst,              // reset input
    input mode,             // mode input (0 for scribble mode, 1 for interpret mode)
    input we,               // write enable input
    input [4:0] addr,       // address input (5-bit address for 32 words)
    input [31:0] data_in,   // input data
    output reg [31:0] data_out // output data
);

reg [31:0] mem [0:31];    // 32x32 memory array
integer i;
always @(posedge clk, posedge rst) begin
    if (rst) begin        // reset memory and output to 0
        data_out <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
    end
    else if (we && mode == 0) begin  // scribble mode
        mem[addr] <= data_in;
        data_out <= data_in;  // drive input data on output
    end
    else if (we==0 && mode==1) begin             // interpret mode
        data_out <= mem[addr];  // provide output based on memory content at given address
    end
    else if (we && mode==1) begin
        mem[addr] <= data_in;             // interpret mode
        data_out <= mem[addr];  // provide output based on memory content at given address
    end
end

endmodule
