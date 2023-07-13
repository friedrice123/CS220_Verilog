// module floating_point_adder(a,b,result);
//     input [31:0] a;
//     input [31:0] b;
//     output reg [31:0] result;
//     // Break the inputs into their component parts: sign, exponent, and mantissa.
//     wire sign_a = a[31];
//     wire sign_b = b[31];
//     wire exponent_a = a[30:23];
//     wire exponent_b = b[30:23];
//     wire mantissa_a = a[22:0];
//     wire mantissa_b = b[22:0];

//     // Determine the larger of the two exponents.
//     wire [7:0]larger_exponent;
//     wire [7:0]smaller_exponent;
//     wire [7:0]equal_exponents;
//     wire signed_zero_result;
//     assign larger_exponent = (exponent_a > exponent_b) ? exponent_a : exponent_b;
//     assign smaller_exponent = (exponent_a < exponent_b) ? exponent_a : exponent_b;
//     assign equal_exponents = (exponent_a == exponent_b);

//     // Determine the shift amount for the smaller mantissa.
//     wire shift_amount;
//     assign shift_amount = larger_exponent - smaller_exponent;

//     // Shift the smaller mantissa by the shift amount.
//     wire [22:0] shifted_mantissa_b;
//     wire [22:0] shifted_mantissa_a;
//     if(exponent_a > exponent_b) begin
//      assign shifted_mantissa_b = {mantissa_b, 23'b0} >> shift_amount;
//      assign shifted_mantissa_a = {mantissa_a,23'b0} ;
//     end 
//     else if (exponent_a < exponent_b)  begin
//      assign shifted_mantissa_a = {mantissa_a, 23'b0} >> shift_amount;
//      assign shifted_mantissa_b = {mantissa_b,23'b0} ;
//     end 

//     // Determine the sign of the result.
//     wire sign_result;
//     wire both_positive;
//     wire both_negative;
//     wire opposite_signs;
//     assign both_positive = (~sign_a) & (~sign_b);
//     assign both_negative = sign_a & sign_b;
//     assign opposite_signs = (sign_a != sign_b);
//    // assign sign_result = (equal_exponents & both_positive) | opposite_signs;
//    //check the cases where sign result will be positive or negative

//     // Compute the sum of the mantissas.
//     wire [22:0] sum_mantissas;
//     wire carry_out;
//     assign {carry_out, sum_mantissas} = shifted_mantissa_a + shifted_mantissa_b;

//     // Normalize the sum if necessary.
//     wire [25:0] normalized_sum;
//     wire [22:0] normalized_mantissa;
//     wire [7:0] normalized_exponent;
//     if(carry_out == 0) begin 
//       //  something that shifts and makes the number of form 1.0
//       //define exponent, mantissa and sum here
//     end
//     // assign normalized_mantissa = sum_mantissas[22:0];
//     // assign normalized_exponent = larger_exponent + carry_out;
//     // assign normalized_sum = {carry_out, normalized_mantissa};

//     // Handle special cases.
//     assign signed_zero_result = (both_positive & (mantissa_a == 0) & (mantissa_b == 0));
//     always @(*) begin
//         if (signed_zero_result) begin
//             result = {1'b0, larger_exponent, 23'b0};
//         end else if ((exponent_a == 0) & (exponent_b == 0)) begin
//             result = {sign_result, 1'b0, normalized_sum};
//         end else if (exponent_a == 0) begin
//             result = {sign_result, normalized_exponent, normalized_mantissa};
//         end else if (exponent_b == 0) begin
//             result = {sign_result, normalized_exponent, normalized_mantissa};
//         end else begin
//             result = {sign_result, normalized_exponent, normalized_mantissa};
//         end
//     end
// endmodule
module veda_memory(clk,rst,mode,write_enab,address1,address2,address3,data_in_1,data_in_2,data_out);
    input clk,rst;
    input mode;
    input write_enab;
    input [4:0] address1,address2,address3;
    input [31:0] data_in_1, data_in_2;
    output reg[31:0] data_out;
    wire [31:0] data_in_3;
    reg [31:0] mem [31:0];
    
    always @ (posedge clk or posedge rst) begin
        if (mode == 0) begin
        mem[address1] = data_in_1;
        mem[address2] = data_in_2;
        mem[address3] = adder(data_in_1,data_in_2,clk,data_in_3);
        end else begin
        data_out <= mem[address3];
        end
    end
endmodule

module adder(operand_1,operand_2,clk,Sum);

//Declaring input and outputs
input [31:0] operand_1;
input [31:0] operand_2;
input [0:0] clk;
//input [0:0] reset;
output [31:0] Sum;
reg [31:0] sum;
wire reset;
//Declaration of other variables
reg [7:0] exponent_1, exponent_2;
reg [23:0] mantissa_1, mantissa_2;
reg [7:0] new_exponent;
wire [7:0] exponent_final;
wire [23:0] mantissa_final;
reg [24:0] mantissa_sum;
reg [23:0] shifted_mantissa_1,shifted_mantissa_2;
wire [23:0] cas_shifted_mantissa_1,cas_shifted_mantissa_2;
wire [24:0] add_mantissa_sum;
reg [7:0] tmp_new_exponent;
wire [7:0] add_new_exponent;
wire [7:0] cas_new_exponent;


reg busy_1=0;
reg busy_2=0;
reg busy_3=0;

compandshift cas(mantissa_1,mantissa_2,exponent_1,exponent_2,clk,reset,cas_shifted_mantissa_1,cas_shifted_mantissa_2,cas_new_exponent,done_1);
addition add(shifted_mantissa_1,shifted_mantissa_2,tmp_new_exponent,clk,reset,add_mantissa_sum,add_new_exponent,done_2); 
normalisation normalise(mantissa_sum,new_exponent,clk,reset,mantissa_final,exponent_final,done_3);

always @(posedge clk)
begin
    if(busy_1==0)
    begin
        exponent_1<=operand_1[30:23];
        exponent_2<=operand_2[30:23];
        mantissa_1<={1'b1,operand_1[22:0]};
        mantissa_2<={1'b1,operand_2[22:0]};
        busy_1<=1;    
    end
    else if (done_1==1 && busy_2==0)
    begin
        shifted_mantissa_1<=cas_shifted_mantissa_1;
        shifted_mantissa_2<=cas_shifted_mantissa_2;
        tmp_new_exponent<=cas_new_exponent;
        busy_1<=0;
        busy_2<=1;
    end
    else if(done_2==1 && busy_3==0)
    begin
        mantissa_sum <= add_mantissa_sum;
        new_exponent <= add_new_exponent;
        busy_2<=0;
        busy_3<=1;
    end
    else if(done_3==1)
    begin
        sum<={operand_1[31],exponent_final,mantissa_final[22:0]};
        busy_3<=0;
        // $display("module:%b",sum);
    end
end
assign Sum = sum; 
endmodule

//This module Compares Exponent of both inputs and shifts mantissa to make exponent equal.
module compandshift(cas_mantissa_1,cas_mantissa_2,cas_exponent_1,cas_exponent_2,clk,reset,cas_shifted_mantissa_1,cas_shifted_mantissa_2,cas_new_exponent,done_1);

input [23:0] cas_mantissa_1, cas_mantissa_2;
input [7:0] cas_exponent_1, cas_exponent_2;
input clk,reset;
output reg [23:0] cas_shifted_mantissa_1,cas_shifted_mantissa_2;
output reg [7:0] cas_new_exponent;
output reg done_1=0;
reg [7:0] diff; 

always @(posedge clk)
begin
    if(cas_exponent_1 == cas_exponent_2)
    begin
        cas_shifted_mantissa_1<=cas_mantissa_1;
        cas_shifted_mantissa_2<=cas_mantissa_2;
        cas_new_exponent<=cas_exponent_1+1'b1;
        done_1<=1;
    end
    else if(cas_exponent_1>cas_exponent_2)
    begin
        diff=cas_exponent_1-cas_exponent_2;
        cas_shifted_mantissa_1<=cas_mantissa_1;
        cas_shifted_mantissa_2<=(cas_mantissa_2>>diff);
        cas_new_exponent<=cas_exponent_1+1'b1;
        done_1<=1;
    end
    else if(cas_exponent_2>cas_exponent_1)
    begin
        diff=cas_exponent_2-cas_exponent_1;
        cas_shifted_mantissa_2<=cas_mantissa_2;
        cas_shifted_mantissa_1<=(cas_mantissa_1>>diff);
        cas_new_exponent<=cas_exponent_2+1'b1;
        done_1<=1;
    end
end
endmodule

//This module add shifted mantissas
module addition(shifted_mantissa_1,shifted_mantissa_2,tmp_new_exponent,clk,reset,mantissa_sum,add_new_exponent,done_2);
input [23:0] shifted_mantissa_1;
input [23:0] shifted_mantissa_2;
input [7:0] tmp_new_exponent;
input clk,reset;
output reg [24:0] mantissa_sum;
output reg done_2=0;
output reg [7:0] add_new_exponent;
always @(posedge clk)
begin
    mantissa_sum<=shifted_mantissa_1+shifted_mantissa_2;
    add_new_exponent<=tmp_new_exponent;
    if(mantissa_sum==(shifted_mantissa_1+shifted_mantissa_2))
    begin
        done_2<=1;
    end
end 
endmodule

//==============================================================================================================================================================================================
//This module normalises the output mantissa
module normalisation(mantissa_sum,new_exponent,clk,reset,mantissa_final,exponent_final,done_3);
input [24:0] mantissa_sum;
input [7:0] new_exponent;
input clk,reset;
output reg [23:0] mantissa_final;
output reg [7:0] exponent_final;
output reg done_3=0;
reg rst=0;

always @(posedge clk)
begin
    if(rst==0)
    begin
        mantissa_final<=mantissa_sum[24:1];
        exponent_final<=new_exponent;
        if(mantissa_final==mantissa_sum[24:1])
        begin
            rst<=1;
        end
    end
    else begin
        repeat(24) begin
            if(mantissa_final[23]==0)
            begin
                mantissa_final<=(mantissa_final<<1'b1);
                exponent_final<=exponent_final-1'b1;
            end
            else begin
                done_3<=1;
                rst<=0;
            end
        end
    end
end
endmodule
