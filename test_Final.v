`include "floating_point_addition.v" 
module test;
reg clk;
wire led;
fpga_check uut (.clk(clk),.led_correct(led_correct),.led_incorrect(led_incorrect));
initial begin
    #100;
    clk=0;
    #100;
    $display("%b %b",led_correct,led_incorrect);
    #100;
    $finish;
end
always #5 clk = ~clk;
// reg clk;
// reg rst;
// // reg mode;
// reg we;
// reg [4:0] addr_a;
// // reg [4:0] addr_b;
// reg [31:0] data_in;
// wire [31:0] data_out;

// single_port_memory_mod spm(
//     .clk(clk),
//     .rst(rst),
//     .we(we),
//     .addr_a(addr_a),
//     .data_in(data_in),
//     .data_out(data_out)
// );

// initial begin
//     // $dumpfile("veda_fp.vcd");
//     // $dumpvars(0,single_port_memory_tb);
//     clk = 0;
//     rst = 1;
//     we = 0;
//     addr_a = 1;
//     data_in = 0;
//     #20; rst=0;
//     #20;
//     addr_a=2;
//     data_in=129;#20;
//     $display("%b",data_out);
//     // data_in=10;
//     // we=1;mode=0;#20;
//     // data_in=11;
//     // we=1;mode=0;#20;
//     // data_in=10;
//     // we=1;mode=1;#20;
//     // data_in=11;
//     // we=1;mode=1;#20;
//     $finish;
// end

// always #5 clk = ~clk;
endmodule