`include "full_adder_32.v"

`timescale 1ns / 1ns

module full_adder_32_tb();
    reg [31:0] x,y;
    wire [31:0] s;

    full_adder_32 G3 (.x(x), .y(y), .s(s));

    initial begin
        $dumpfile("full_adder_32_tb.vcd");
        $dumpvars(0,full_adder_32_tb);

        x=532;y=675;#100;
        $display("%d %d %d\n",x,y,s);
        #100;
        x=162;y=2871;#100;
        $display("%d %d %d\n",x,y,s);
        
    end

endmodule