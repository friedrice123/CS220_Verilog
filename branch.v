module branch(pc,instruction,outputPC);
    input [31:0] instruction;
    input reg [4:0] pc;
    output[4:0] outputPC;
    wire [6:0] opcode,funct;
    wire [5:0] rs,rt,rd,shamt;
    wire [15:0] imm;
    reg signed [31:0]inter;
    assign funct=instruction[5:0];
    assign shamt=instruction[10:6];
    assign rd=instruction[15:11];
    assign rt=instruction[20:16];
    assign rs=instruction[25:21];
    assign opcode=instruction[31:26];
    assign imm = instruction[15:0];
    output [31:0] result;
    reg [31:0] mem [0:31];    // 32x32 memory array
    integer i;
    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
        mem[16] <= 4;
        mem[17] <= 2;
    end
    always@(instruction)begin
        case (opcode)
            // 6'b100011: $display("I-Type instruction- lw\n");
            // 6'b101011: $display("I-Type instruction- sw\n");
            6'b000100: 
                if(mem[rs]==mem[rt]) begin
                    pc=pc+4+10;
                end
            //$display("I-Type instruction- beq\n");
            6'b000101: $display("I-Type instruction- bne\n");
            6'b000111: $display("I-Type instruction- bgt\n");
            6'b000001: $display("I-Type instruction- bgte\n");
            6'b000011: $display("I-Type instruction- ble\n");
            6'b000110: $display("I-Type instruction- bleq\n");
            6'b010100: $display("J-Type instruction- j\n");
            6'b010101: $display("J-Type instruction- jal\n");
        endcase
    end
    assign outputPC=pc;
endmodule