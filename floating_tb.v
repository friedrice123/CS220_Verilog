`include "floating.v"
module adder_tb;
reg [31:0] operand_1,operand_2;
reg clk;
wire [31:0] Sum;
wire done;

adder DUT(.operand_1(operand_1),.operand_2(operand_2),.clk(clk),.Sum(Sum));
initial 
begin 
clk=1'b0;
operand_1=32'b00000000110000000000000000000000;
operand_2=32'b00000000110000000000000000000000;
#40
$display("%b\n",Sum);

operand_1=32'b00111111000110000000000000000000;
operand_2=32'b01000001010110100000000000000000;
#40
$display("%b\n",Sum);

$finish;
end
always #1 clk=!clk;
endmodule
