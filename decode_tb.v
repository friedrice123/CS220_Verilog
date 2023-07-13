`include "processor.v"
module tb();
    reg [31:0] instruction;
    decode uut(.instruction(instruction));
    initial begin
        instruction=32'b000000_00000000000000000000_100000;
        #100;
        instruction=32'b010100_00000000000000000000_100000;
        #100;
        instruction=32'b000001_00000000000000000000_100000;
    end
endmodule