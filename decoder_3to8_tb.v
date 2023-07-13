`include "decoder_3to8.v"

`timescale 1ns / 1ns

module decoder_3to8_tb();
    reg a,b,c;
    wire y0,y1,y2,y3,y4,y5,y6,y7;
    decoder_3to8 G5 (.a(a), .b(b), .c(c), .y0(y0), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5), .y6(y6), .y7(y7));
    initial begin
        $dumpfile("decoder_3to8_tb.vcd");
        $dumpvars(0, decoder_3to8_tb);

        a=0;b=0;c=0;#10;
        a=0;b=0;c=1;#10;
        a=0;b=1;c=0;#10;
        a=0;b=1;c=1;#10;
        a=1;b=0;c=0;#10;
        a=1;b=0;c=1;#10;
        a=1;b=1;c=0;#10;
        a=1;b=1;c=1;#10;
    end
endmodule