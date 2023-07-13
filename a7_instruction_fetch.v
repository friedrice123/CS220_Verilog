`include "a7_instruction_memory.v"
module instruction_fetch (
    input clk,
    input reset,
    output reg [31:0] PC,
    output [31:0] instruction
);
    instruction_memory u1 (.address(PC), .instruction(instruction));
    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
        end
        else begin
            PC <= PC + 1;
        end
    end
    

endmodule