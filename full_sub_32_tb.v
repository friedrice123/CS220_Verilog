`include "full_sub_32.v"

`timescale 1ns / 1ns

module full_sub_32_tb();
    reg [31:0] x,y;
    reg bin;
    wire [31:0] d;
    wire bout;

    full_sub_32 G3 (.x(x), .y(y), .bin(bin), .bout(bout), .d(d));

    initial begin
        $dumpfile("full_sub_32_tb.vcd");
        $dumpvars(0,full_sub_32_tb);

        x=59;y=11;bin=0;#100;
        $display("%d %d %d %d\n",x,y,d);
        #100;
        x=11;y=59;bin=0;#100;
        $display("%d %d %d %d\n",x,y,d);
        
    end

endmodule