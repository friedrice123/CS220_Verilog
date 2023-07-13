module decode(instruction);
    input [31:0] instruction;
    wire [6:0] opcode,funct;
    wire [5:0] rs,rt,rd,shamt;
    assign funct=instruction[5:0];
    assign shamt=instruction[10:6];
    assign rd=instruction[15:11];
    assign rt=instruction[20:16];
    assign rs=instruction[25:21];
    assign opcode=instruction[31:26];
    always@(instruction)begin
        case (opcode)
            6'b0: 
            case (funct)
                6'b100000: $display("R-Type instruction- add\n");
                6'b100001: $display("R-Type instruction- addu\n");
                6'b100010: $display("R-Type instruction- sub\n");
                6'b100011: $display("R-Type instruction- subu\n");
                6'b100100: $display("R-Type instruction- and\n");
                6'b100101: $display("R-Type instruction- or\n");
                6'b000000: $display("R-Type instruction- sll\n");
                6'b000010: $display("R-Type instruction- srl\n");
                6'b101010: $display("R-Type instruction- slt\n");
                6'b001000: $display("J-Type instruction- jr\n");
            endcase
            6'b001000: $display("I-Type instruction- addi\n");
            6'b001001: $display("I-Type instruction- addiu\n");
            6'b001100: $display("I-Type instruction- andi\n");
            6'b001101: $display("I-Type instruction- ori\n");
            6'b100011: $display("I-Type instruction- lw\n");
            6'b101011: $display("I-Type instruction- sw\n");
            6'b000100: $display("I-Type instruction- beq\n");
            6'b000101: $display("I-Type instruction- bne\n");
            6'b000111: $display("I-Type instruction- bgt\n");
            6'b000001: $display("I-Type instruction- bgte\n");
            6'b000011: $display("I-Type instruction- ble\n");
            6'b000110: $display("I-Type instruction- bleq\n");
            6'b001010: $display("I-Type instruction- slti\n");
            6'b010100: $display("J-Type instruction- j\n");
            6'b010101: $display("J-Type instruction- jal\n");
        endcase
    end
endmodule