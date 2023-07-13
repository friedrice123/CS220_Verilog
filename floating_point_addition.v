module fpga_check(clk, led_correct, led_incorrect);
    input clk;
    output led_correct,led_incorrect;
    wire [31:0] a, b, check1, check2, s;
    veda r0(clk, 1'b0, 5'b00001, 1'b1, 1'b0, 32'b0, a);
    veda r1(clk, 1'b0, 5'b00111, 1'b1, 1'b0, 32'b0, b);
    veda r2(clk, 1'b0, 5'b01010, 1'b1, 1'b0, 32'b0, check1);
    veda r3(clk, 1'b0, 5'b01011, 1'b1, 1'b0, 32'b0, check2);
    floatAdder fa0(a,b,s);
    assign led_correct = (s == check1); // verify that calculated sum is equal to the hardcoded sum given as input
    assign led_incorrect = (s == check2);
endmodule



module veda(clk, rst, addr_1, mode, we, write_data, data_out);
    input clk;
    input rst;
    input [4:0] addr_1;
    input we;
    input [31:0] write_data;
    input mode;
    output reg [31:0] data_out;

    reg [31:0] mem[31:0];
    reg [4:0] temp_addr;
    integer i;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
        mem[1] <= 32'b11000000101101010111000010100100; 
        mem[7] <= 32'b11000001111001110000101000111101; 
        mem[10] <= 32'b11000010000010100011001100110011; 
        mem[11] <= 32'b11000010000010100011001100110010;
    end

    always @(posedge clk) begin
        temp_addr <= addr_1;
        if (we && mode == 1'b0) begin
            mem[addr_1] = write_data;
        end
    end
    always @(posedge rst) begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
        mem[addr_1] = 1'b0;
    end
    always @(mem[temp_addr]) begin
        data_out = mem[temp_addr];
    end
endmodule


module floatAdder(a,b,s);

input [31:0]a,b;
output [31:0]s;
reg [31:0] big,smaller;
reg [23:0] mant_a,mant_b;reg [24:0] mant_final;reg [30:0] sum_unsigned;wire [23:0] new_b;
wire [7:0] exponent_diff;
wire sign_out;
reg [4:0] number_zero;
reg [23:0]normalised;

always@(*) begin
    if(a[30:0] < b[30:0]) begin
        {big,smaller} = {b,a};
    end
    else begin
        {big,smaller} = {a,b};
    end
end
assign sign_out = big[31];
assign exp_a = big[30:23]; // extract the exponents and sign
assign exp_b = smaller[30:23];

always@(*) begin
    if(big[30:23]==0) begin
        mant_a={1'b0,big[22:0]};
    end
    else begin
        mant_a={1'b1,big[22:0]};
    end
end
always@(*) begin
    if(smaller[30:23]==0) begin
        mant_b={1'b0,smaller[22:0]};
    end
    else begin
        mant_b={1'b1,smaller[22:0]};
    end
end
assign exponent_diff = big[30:23] - smaller[30:23]; // finding the difference in exponents
assign new_b = mant_b >> exponent_diff; // right shift b

always@(*) begin
    if(big[31] ^ smaller[31]) begin
        mant_final = (mant_a - new_b);
    end
    else begin
        mant_final = (mant_a + new_b);
    end
end
integer i;
always@(*) begin
    number_zero=23;
    for(i=1;i<24;i=i+1)begin
        if(mant_final[i])begin
            number_zero=24-i;
        end
        else begin
            number_zero=number_zero;
        end
    end
    normalised=mant_final<<number_zero;
end
always@(*) begin
    if(mant_final[24]) begin
        sum_unsigned[22:0] = mant_final[23:1];
    end
    else if(number_zero>big[30:23])begin
        sum_unsigned[22:0]=0;
    end
    else begin
        sum_unsigned[22:0] = mant_final[22:0];
    end
end
always@(*) begin
    if(mant_final[24]) begin
        sum_unsigned[30:23] = (1'b1 + big[30:23]);
    end
    else if(number_zero>big[30:23])begin
        sum_unsigned[30:23]=0;
    end
    else begin
        sum_unsigned[30:23] = big[30:23]-number_zero+1;
    end
end
assign s =  {sign_out,sum_unsigned}; // giving the final sum with sign as output 

endmodule