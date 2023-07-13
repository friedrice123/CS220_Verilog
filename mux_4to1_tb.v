`include "mux_4to1.v"

`timescale 1ns / 1ns

module mux_4to1_tb();
    reg [31:0] a,b,c,d;
    reg [1:0] s1;
    wire [31:0] o;
    mux_4to1 G1 (.a(a),.b(b),.c(c),.d(d),.s1(s1),.o(o));
    initial begin
        $dumpfile("mux_4to1_tb.vcd");
        $dumpvars(0, mux_4to1_tb);

        a=32'b10101; b=32'b1001; c=32'b1010; d=32'b1111; s1=2'b00; #10;
        a=32'b11010; b=32'b10100; c=32'b1111; d=32'b111111; s1=2'b11; #10;
        a=32'b10; b=32'b1000; c=32'b1010; d=32'b101; s1=2'b10; #10;
        a=32'b111; b=32'b11; c=32'b1111; d=32'b100; s1=2'b01; #10;
    end
endmodule