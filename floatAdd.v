module float_addition(
input [31:0] a,b, //Inputs in the format of IEEE-754 Representation.
output [31:0] sum //Outputs in the format of IEEE-754 Representation.
);

wire sign_out;

wire [31:0] a1,b1;
wire [23:0] mantissa_a,mantissa_b;
wire [7:0] exponent_diff;
wire [23:0] b_shifted;
wire [24:0] total_mantissa;
wire [30:0] sum_unsigned;
wire final_sign;

assign {a1,b1} = (a[30:0] < b[30:0]) ? {b,a} : {a,b}; // replace a and b if magnitude of b is greater than a

assign exp_a = a1[30:23]; // extract the exponents and sign
assign exp_b = b1[30:23];
assign sign_out = a1[31];

assign mantissa_a = (a1[30:23] == 0) ? {1'b0,a1[22:0]} : {1'b1,a1[22:0]}; 
assign mantissa_b = (b1[30:23] == 0) ? {1'b0,b1[22:0]} : {1'b1,b1[22:0]};

assign exponent_diff = a1[30:23] - b1[30:23]; // finding the difference in exponents
assign b_shifted = mantissa_b >> exponent_diff; // right shift b

assign final_sign = a1[31] ^ b1[31];
assign total_mantissa = final_sign?({1'b0,mantissa_a} - {1'b0,b_shifted}):({1'b0,mantissa_a} + {1'b0,b_shifted}); 

assign sum_unsigned[22:0] = total_mantissa[24] ? total_mantissa[23:1] : total_mantissa[22:0]; // calculating the sum's magnitude
assign sum_unsigned[30:23] = total_mantissa[24] ? (1'b1 + a1[30:23]) : a1[30:23];

assign sum =  {sign_out,sum_unsigned}; // giving the final sum with sign as output 
endmodule

module reg_file(clk, rst, address, mode, write, write_data, out);
    // reg_file module of VEDA from Assignment 4
    input clk;
    input rst;
    input [4:0] address;
    input write;
    input [31:0] write_data;
    input mode;

    output reg signed [31:0] out;

    reg [31:0] mem[31:0];
    reg [4:0] add_reg;
    integer i;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
        mem[1] <= 32'b0_10000001_10010000000000000000000; // = IEEE754 Representation of 6.25
        mem[7] <= 32'b1_01111111_10000000000000000000000; // = IEEE754 Representation of -1.5
        mem[10] <= 32'b0_10000001_00110000000000000000000; // = IEEE754 Representation of 4.75
    end

    always @(posedge clk) begin
        add_reg <= address;
    end
    always @(mem[add_reg]) begin
        out = mem[add_reg];
    end
    always @(posedge clk) begin
        if (write && mode == 1'b0) begin
            mem[address] = write_data;
        end
    end
    always @(posedge rst) begin
        mem[address] = 1'b0;
    end
endmodule

module float_add_verify(clk, out);
    input clk;
    output out;
    wire [31:0] a, b, check, sum;
    reg_file r0(clk, 1'b0, 5'b00001, 1'b1, 1'b0, 32'b0, a);
    reg_file r1(clk, 1'b0, 5'b00111, 1'b1, 1'b0, 32'b0, b);
    reg_file r2(clk, 1'b0, 5'b01010, 1'b1, 1'b0, 32'b0, check);
    float_addition fa0(a,b,sum);
    assign out = (sum == check); // verify that calculated sum is equal to the hardcoded sum given as input
endmodule