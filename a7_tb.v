`include "a7_controller.v"
module a7_tb();
    reg clk,reset;
    wire [31:0] result,data_out1,data_out2;

    top uut(.clk(clk),.reset(reset),.result(result));
    always #15 clk = ~clk;
    initial begin
        $dumpfile("a7_tb.vcd");
        $dumpvars(0,a7_tb);
        clk = 0;
        reset = 1;
        #60 reset = 0;
        #200;
        // $display("result = %d",result); 
        $finish;
    end
endmodule