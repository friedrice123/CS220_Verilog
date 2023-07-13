`include "full_subtractor.v"

`timescale 1ns / 1ns

module full_subtractor_tb();
    reg x,y,bin;
    wire bout,d;
    full_subtractor G1 (.x(x),.y(y),.bin(bin),.bout(bout),.d(d));
    initial begin
        $dumpfile("full_subtractor_tb.vcd");
        $dumpvars(0, full_subtractor_tb);

        x=0; y=0; bin=0; #10;
        x=0; y=1; bin=0; #10;
        x=1; y=0; bin=0; #10;
        x=1; y=1; bin=0; #10;
        x=0; y=0; bin=1; #10;
        x=0; y=1; bin=1; #10;
        x=1; y=0; bin=1; #10;
        x=1; y=1; bin=1; #10;
    end
endmodule