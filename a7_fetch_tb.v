`include "a7_instruction_fetch.v"
module a7_fetch_tb();
    reg clk,reset;
    wire [31:0]PC;
    wire [31:0] instruction;

    instruction_fetch u1 (.clk(clk),.reset(reset),.PC(PC),.instruction(instruction));
    always #15 clk = ~clk;
    initial begin
        $dumpfile("a7_fetch_tb.vcd");
        $dumpvars(0,a7_fetch_tb);
        clk = 0;
        reset = 1;
        // PC=3;
        #10 reset = 0;
        #60
        $display("PC = %d\ninstruction = %d",PC,instruction); 
        $finish;
    end
endmodule