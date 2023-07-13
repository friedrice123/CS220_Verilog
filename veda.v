module veda_memory(clk,rst,mode,write_enab,address,data_in,data_out);
    input clk,rst;
    input mode;
    input write_enab;
    input [4:0] address;
    input [31:0] data_in;
    output reg[31:0] data_out;

    reg [31:0] mem [31:0];

    always @ (posedge clk or posedge rst) begin
        if (mode == 0) begin
        mem[address] <= data_in;
        end else begin
        data_out <= mem[address];
        end
    end
endmodule