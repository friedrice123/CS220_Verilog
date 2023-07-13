
module stormbreaker(a,b,cin,sum,cout);
    input [127:0] a,b;
    input cin;
    output [127:0] sum;
    output cout;

    
endmodule

module ripple_carry_n_bit(a, b, cin, sum, cout);
    parameter B=4;
    input [B:0] a,b;
    input cin;
    wire c1,c2,c3;
    output [B:0] sum;
    output cout;

    full_adder fa0((a[0]), (b[0]),(cin),(sum[0]),(c1));
    full_adder fa1((a[1]), (b[1]), (c1),(sum[1]),(c2));
    full_adder fa2((a[2]), (b[2]), (c2),(sum[2]),(c3));
    full_adder fa3((a[3]), (b[3]), (c3),(sum[3]),(cout));
endmodule

module full_adder(x,y,cin,s,cout);
    input wire x,y,cin;
    output wire cout,s;
    wire c_temp,s_temp,and_temp;
    
    xor s1 (s_temp,x,y);
    xor s2 (s,cin,s_temp);

    and c1 (c_temp,s_temp,cin);
    and c2 (and_temp,x,y);
    or c3(cout,and_temp,c_temp);

endmodule

module half_adder(x,y,s,cout);
    input x,y;
    output s,cout;
    wire x1,x2;
    xor s1 (s,x,y);
    and s2 (cout,x,y);
endmodule

module mux_2to1(a,b,sel,out);
    input a,b;
    input sel;
    output reg out;
    always @(a or b or sel)
    begin
        case(sel)
        1'b0 : out = a;
        default : out = b;
        endcase 
    end
endmodule