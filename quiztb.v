`include "quiz.v"
module tb();
    reg [3:0] A ;
    reg CLK ;
    wire [3:0] B , C ;
    code1 u(.a(A),.clk(CLK),.b(B),.c(C));
    always #5 CLK = ~CLK;
    initial 
        begin
        CLK = 0;
        A = 4;#10;
        A =5;#10;
        $display("C=%d , B=%d",C,B);
        end
endmodule
