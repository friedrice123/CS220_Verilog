`include "a7_instruction_fetch.v"
`include "a7_alu.v"
`include "a7_data_memory.v"
module top(clk,reset,result);
    input clk,reset;
    wire [31:0] nextPC;
    wire [31:0] nextPC1;
    reg [31:0] nextPC2;
    wire [31:0] instruction;
    output [31:0] result;
    reg [31:0] PC;
    reg [31:0] memory[0:6];
    wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt;
    wire [15:0] imm;
    wire [31:0] out1,out2;
    assign funct=instruction[5:0];
    assign shamt=instruction[10:6];
    assign rd=instruction[15:11];
    assign rt=instruction[20:16];
    assign rs=instruction[25:21];
    assign opcode=instruction[31:26];
    assign imm = instruction[15:0];
    reg [31:0] temp=0;
    reg [31:0] res=0;
    initial begin
        PC=0;
        nextPC2=0;
    end
    assign nextPC1=0;
    
    always @(posedge clk, nextPC) begin
        if (reset) begin
            PC <= 0;
            
        end
        else begin
            nextPC2=nextPC1;
            // $display("nextPC=%d nextPC1=%d",nextPC,nextPC1);
            temp=nextPC2-1;
            PC <= nextPC+temp;
            $display("nextPC=%d ",nextPC);
        end
    end
    always @(posedge clk) begin
        if (reset) begin
            PC <= 0;
        end
    end

    instruction_fetch u1 (.clk(clk),.reset(reset),.PC(PC),.nextPC(nextPC),.instruction(instruction));
    data_memory u2(.clk(clk),.reset(reset),.read1(rs),.read2(rt),.write(rd),.we(1'b0),.re(1'b1),.data_in(1),.data_out1(out1),.data_out2(out2));
    alu u3 (.a(out1),.b(out2),.PC(nextPC),.instruction(instruction),.result(result),.nextPC2(nextPC1));
    // data_memory u4(.clk(clk),.reset(reset),.read1(rs),.read2(rt),.write(rd),.we(1'b1),.re(1'b0),.data_in(result),.data_out1(out1),.data_out2(out2));
    
    always @(instruction,result) begin
        $display("instr=%b",instruction);
    end
    always @(result) begin
        res=result;
        $display(" result=%d\n",result);
    end
    
endmodule