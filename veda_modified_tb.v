`include "veda_modified.v"

module veda_tb;

reg clk;
reg rst;
reg mode;
reg we;
reg [4:0] addr_a;
reg [4:0] addr_b;
reg [31:0] data_in;
wire [31:0] data_out;

veda v(
    .clk(clk),
    .rst(rst),
    .mode(mode),
    .we(we),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    $dumpfile("veda_new.vcd");
    $dumpvars(0,veda_tb);
    clk = 0;
    rst = 1;
    mode = 0;
    we = 0;
    addr_a = 1;
    addr_b = 2;
    data_in = 0;
    #20; rst=0;
    #20;
    addr_a=3;
    addr_b=4;
    data_in=10;
    we=1;mode=0;#20;
    data_in=11;
    we=1;mode=0;#20;
    data_in=10;
    we=0;mode=1;#20;
    data_in=11;
    we=0;mode=1;#20;
    // data_in=10;
    // we=1;mode=0;#20;
    // data_in=11;
    // we=1;mode=0;#20;
    // data_in=10;
    // we=1;mode=1;#20;
    // data_in=11;
    // we=1;mode=1;#20;
    $finish;
end

always #5 clk = ~clk;

endmodule

        
