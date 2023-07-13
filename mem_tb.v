`include "mem.v"

module single_port_memory_tb;

reg clk;
reg rst;
reg mode;
reg we;
reg [4:0] addr;
reg [31:0] data_in;
wire [31:0] data_out;

single_port_memory spm(
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    $dumpfile("mem.vcd");
    $dumpvars(0,single_port_memory_tb);
    clk = 0;
    rst = 1;
    mode = 0;
    we = 0;
    addr = 5'b00000;
    data_in = 0;
    #20; rst=0;
    #20;
    addr=5;
    data_in=10;
    we=1;mode=0;#20;
    data_in=11;
    we=1;mode=0;#20;
    // data_in=10;
    // we=0;mode=1;#20;
    // data_in=11;
    // we=0;mode=1;#20;
    // data_in=10;
    // we=1;mode=0;#20;
    // data_in=11;
    // we=1;mode=0;#20;
    data_in=10;
    we=1;mode=1;#20;
    data_in=11;
    we=1;mode=1;#20;
    $finish;
end

always #5 clk = ~clk;

endmodule
