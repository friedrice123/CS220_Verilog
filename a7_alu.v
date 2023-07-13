module alu(a,b,PC,instruction,result,nextPC2);
    input [31:0] PC;
    input [31:0] a,b;
    input [31:0] instruction;
    output [31:0] result;
    reg [31:0] nextPC;
    reg [31:0] temp_mem;
    wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt;
    wire [15:0] imm;
    wire [25:0] offset;
    reg [31:0] ra;
    reg signed [31:0]inter;
    assign funct=instruction[5:0];
    assign shamt=instruction[10:6];
    assign rd=instruction[15:11];
    assign rt=instruction[20:16];
    assign rs=instruction[25:21];
    assign opcode=instruction[31:26];
    assign imm = instruction[15:0];
    assign offset = instruction[25:0];
    reg[31:0] nextPC1;
    output [31:0] nextPC2;
    
    always@(instruction)begin
        $display("a=%d b=%d",a,b);
        temp_mem=0;
        case (opcode)
            6'b0: 
            case (funct)
                6'b100000: begin
                temp_mem = $signed(a)+$signed(b);
                nextPC=PC;
                $display("R-Type instruction- add\n");
                end
                //$display("R-Type instruction- add\n");
                6'b100001: begin
                temp_mem = a+b;
                nextPC=PC;
                $display("R-Type instruction- addu\n");
                end
                //$display("R-Type instruction- addu\n");
                6'b100010: begin
                temp_mem = $signed(a) - $signed(b);
                nextPC=PC;
                $display("R-Type instruction- sub\n");
                end
                // $display("R-Type instruction- sub\n");
                6'b100011: begin
                temp_mem = a -b;
                nextPC=PC;
                $display("R-Type instruction- subu\n");
                end
                //$display("R-Type instruction- subu\n");
                6'b100100: begin
                temp_mem = a & b;
                nextPC=PC;
                $display("R-Type instruction- and\n");
                end
                //$display("R-Type instruction- and\n");
                6'b100101: begin
                temp_mem = a | b;
                nextPC=PC;
                $display("R-Type instruction- or\n");
                end
                // $display("R-Type instruction- or\n");
                6'b000000: begin
                temp_mem = a << shamt;
                $display("R-Type instruction- sll\n");
                end
               // $display("R-Type instruction- sll\n");
                6'b000010: 
                temp_mem = a >> shamt;
               // $display("R-Type instruction- srl\n");
                6'b101010: 
                if(a < b)begin
                    temp_mem = 1;
                end 
                else begin 
                    temp_mem = 0;
                end 
                //$display("R-Type instruction- slt\n");
                6'b001000:
                nextPC=rs;
                //$display("J-Type instruction- jr\n");
            endcase
            6'b001000: 
            temp_mem = b + imm; 
            //$display("I-Type instruction- addi\n");
            6'b001001: 
            temp_mem = b + imm;
            //$display("I-Type instruction- addiu\n");
            6'b001100: 
            temp_mem = b & imm;
            //$display("I-Type instruction- andi\n");
            6'b001101: 
            temp_mem = b | imm;
            //$display("I-Type instruction- ori\n");
            // 6'b100011: $display("I-Type instruction- lw\n");
            // 6'b101011: $display("I-Type instruction- sw\n");
            6'b000100: begin
            if(a==b) nextPC=PC+1+imm;
            // $display("I-Type instruction- beq\n,%d %d",nextPC, PC);
            end
            6'b000101: 
            begin
            if(a!=b) nextPC=PC+1+imm;
            $display("Branch to %d",nextPC);
            end
            //$display("I-Type instruction- bne\n");
            6'b000111: 
            begin
            if(a>b) nextPC=PC+1+imm;
            end
            //$display("I-Type instruction- bgt\n");
            6'b000001: 
            begin
            if(a>=b) nextPC=PC+1+imm;
            end
            //$display("I-Type instruction- bgte\n");
            6'b000011: 
            begin
            if(a<b) nextPC=PC+1+imm;
            end
            //$display("I-Type instruction- ble\n");
            6'b000110: 
            begin
            if(a<=b) nextPC=PC+1+imm;
            end
            //$display("I-Type instruction- bleq\n");
            6'b001010: 
               if(b < imm)begin
                    temp_mem = 1;
                end 
                else begin 
                    temp_mem = 0;
                end 
            //$display("I-Type instruction- slti\n");
            6'b010100: begin
            nextPC=offset;
            $display("Jump to",nextPC);
            end
            //$display("J-Type instruction- j\n");
            6'b010101: begin
            ra=PC+1;
            nextPC=offset;
            end
            //$display("J-Type instruction- jal\n");
        endcase
    end
    assign result=temp_mem;
    always @(nextPC) begin
        nextPC1=nextPC;
        // $display("nextPC1=%d",nextPC1);
    end
    assign nextPC2=nextPC1;
endmodule