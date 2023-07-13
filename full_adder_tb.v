`include "full_adder.v"

`timescale 1ns / 1ns

module full_adder_tb();
    reg x,y,cin;
    wire cout,s;
    full_adder G1 (.x(x),.y(y),.cin(cin),.cout(cout),.s(s));
    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);

        x=0; y=0; cin=0; #10;
        x=0; y=1; cin=0; #10;
        x=1; y=0; cin=0; #10;
        x=1; y=1; cin=0; #10;
        x=0; y=0; cin=1; #10;
        x=0; y=1; cin=1; #10;
        x=1; y=0; cin=1; #10;
        x=1; y=1; cin=1; #10;
    end
endmodule