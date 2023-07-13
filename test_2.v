`include "CAdder.v" 
module test;
reg [31:0] a,b;
wire [31:0]sum;
float_addition uut (.a(a),.b(b),.sum(sum));
initial begin
    a=32'b00111111001010001111010111000011;
    b=32'b10111110110101110000101000111101;
    #100;
    $display("%b",sum);
    #100;
    $finish;
end
endmodule