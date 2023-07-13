`include "fetch.v"

// module veda_tb;

// reg clk;
// reg [4:0] a1,a2;
// reg we,re;
// reg [31:0] data_in;
// wire [31:0] data_out;

// fetch uut (
//         .clk(clk),
//         .a1(a1),
//         .a2(a2),
//         .we(we),
//         .re(re),
//         .data_in(data_in),
//         .data_out(data_out)
//     );

//     initial begin
//         clk = 0;
//         forever begin
//             #5 clk = ~clk;
//         end
//     end

// initial begin
//     $dumpfile("fetch.vcd");
//     $dumpvars(0,veda_tb);
//     clk = 0;
//     re = 0;
//     we=0;
//     $display("%b",data_out);
//     #5;
//     we=1;
//     re =1;
//     a2= 2;
//     #20;
//     $display("%b",data_out);
//     #20;

//     $finish;
// end

// endmodule

module fetch_tb();
    reg clk,reset;
    wire [31:0] instruction;

    instruction_fetch uut(.clk(clk),.reset(reset),.instruction(instruction));

    initial begin
        $dumpfile("fetch.vcd");
        $dumpvars(0,fetch_tb);
        clk = 0;
        reset = 1;
        #20; reset=0;
        #80;
        $finish;
    end

    always #5 clk = ~clk;
endmodule