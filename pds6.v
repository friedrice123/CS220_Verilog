// `include "fetch.v"
// module alu(clk,result);
//     // input [31:0]instruction;
//     input clk;
//     reg reset;
//     wire [31:0] instruction;
//     output [31:0] result;
//     fetch u1(clk, 5'b0, 5'b0, 1'b1 , 1'b0, 32'b00000000000000001111111111111111,.data_out(data_out));
//     fetch u1(clk, 5'b0, 5'b0, 1'b0 , 1'b1,.data_in(data_in),.data_out(data_out));
//     decode u2(instruction);
    
// endmodule

// module fetch(
//     input clk,              // clock input
//     input [4:0] a1,       // address input (5-bit address for 32 words)
//     input [4:0] a2,
//     input  we,               // write enable input
//     input re,
//     input [31:0] data_in,
//     output reg signed [31:0] data_out // output data
// );

// reg [31:0] mem [0:31];    // 32x32 memory array
// integer i;

// initial begin
//     for(i = 0; i < 32; i = i + 1) begin
//         mem[i] <= 0;
//     end
//     mem[0] <= 
//     mem[1] <= 32'b0_10000001_10010000000000000000000;
//     mem[2] <= 32'b1_01111111_10000000000000000000000;
//     mem[3] <= 32'b0_10000001_00110000000000000000000;
//     mem[4] <= 32'b0_10000001_00110000000000000000001;
//     mem[5] <= 32'b0_10000001_00110000000000000000011;
//     mem[6] <= 32'b0_10000001_00110000000000000000111;
// end
// always @(posedge clk) begin
//     if (we) begin
//         mem[a1] = data_in;
//     end

//     if (re) begin
//         data_out = mem[a2];
//     end
// end
// endmodule

// module decode(instruction);
//     input [31:0] instruction;
//     wire [6:0] opcode,funct;
//     wire [5:0] rs,rt,rd,shamt;
//     assign funct=instruction[5:0];
//     assign shamt=instruction[10:6];
//     assign rd=instruction[15:11];
//     assign rt=instruction[20:16];
//     assign rs=instruction[25:21];
//     assign opcode=instruction[31:26];
//     always@(instruction)begin
//         case (opcode)
//             6'b0: 
//             case (funct)
//                 6'b100000: $display("R-Type instruction- add\n");
//                 6'b100001: $display("R-Type instruction- addu\n");
//                 6'b100010: $display("R-Type instruction- sub\n");
//                 6'b100011: $display("R-Type instruction- subu\n");
//                 6'b100100: $display("R-Type instruction- and\n");
//                 6'b100101: $display("R-Type instruction- or\n");
//                 6'b000000: $display("R-Type instruction- sll\n");
//                 6'b000010: $display("R-Type instruction- srl\n");
//                 6'b101010: $display("R-Type instruction- slt\n");
//                 6'b001000: $display("J-Type instruction- jr\n");
//             endcase
//             6'b001000: $display("I-Type instruction- addi\n");
//             6'b001001: $display("I-Type instruction- addiu\n");
//             6'b001100: $display("I-Type instruction- andi\n");
//             6'b001101: $display("I-Type instruction- ori\n");
//             6'b100011: $display("I-Type instruction- lw\n");
//             6'b101011: $display("I-Type instruction- sw\n");
//             6'b000100: $display("I-Type instruction- beq\n");
//             6'b000101: $display("I-Type instruction- bne\n");
//             6'b000111: $display("I-Type instruction- bgt\n");
//             6'b000001: $display("I-Type instruction- bgte\n");
//             6'b000011: $display("I-Type instruction- ble\n");
//             6'b000110: $display("I-Type instruction- bleq\n");
//             6'b001010: $display("I-Type instruction- slti\n");
//             6'b010100: $display("J-Type instruction- j\n");
//             6'b010101: $display("J-Type instruction- jal\n");
//         endcase
//     end
// endmodule


// module r_type (instruction , result);
// input [31:0] instruction;
// wire [6:0] opcode,funct;
// wire [5:0] rs,rt,rd,shamt;
// output [31:0] result;
//   assign funct=instruction[5:0];
//     assign shamt=instruction[10:6];
//     assign rd=instruction[15:11];
//     assign rt=instruction[20:16];
//     assign rs=instruction[25:21];
//     assign opcode=instruction[31:26];
    
//     always@(instruction)begin
//         case (opcode)
//             6'b0: 
//             case (funct)
//                 6'b100000: 
//                 //$display("R-Type instruction- add\n");
//                 6'b100001:
//                 // $display("R-Type instruction- addu\n");
//                 6'b100010: 
//                 //$display("R-Type instruction- sub\n");
//                 6'b100011: 
//                 //$display("R-Type instruction- subu\n");
//                 6'b100100: 
//                 //$display("R-Type instruction- and\n");
//                 6'b100101: 
//                 //$display("R-Type instruction- or\n");
//                 6'b000000: 
//                 //$display("R-Type instruction- sll\n");
//                 6'b000010: 
//                 //$display("R-Type instruction- srl\n");
//                 6'b101010: 
//                 //$display("R-Type instruction- slt\n");
                
//             endcase
//         endcase 
//     end 
    
// endmodule