
module stormbreaker(a,b,cin,sum,cout);
    parameter B=4;
    input [127:0] a,b;
    input cin;
    output [127:0] sum;
    output cout;
    wire [128/B:0]temp;
    wire [(128/B)-1:0] p,out;

    genvar i;
    assign temp[0]=cin;
    generate 
        for(i=0;i<128/B;i=i+1)
            begin: generate_stormbreaker
                ripple_carry_B_bit r1(a[(i+1)*B-1:i*B], b[(i+1)*B-1:i*B], temp[i], sum[(i+1)*B-1:i*B], out[i],p[i]);
                mux_2to1 m1(out[i],temp[i],p[i],temp[i+1]);
            end
    endgenerate
    assign cout=temp[128/B];
endmodule

module ripple_carry_B_bit(a, b, cin, sum, cout,p);
    parameter B=4;
    input [B-1:0] a,b;
    input cin;
    output [B-1:0] sum;
    output cout,p;
    wire [B-1:0] t;
    wire [B:0] c;
    assign t[0]=a[0]^b[0];
    genvar i;
    generate 
    for(i=1;i<B;i=i+1)
        begin: generate_p
            assign t[i]=(a[i]^b[i])&(t[i-1]);
        end
    endgenerate
    assign p=t[B-1];

    genvar k;
    assign c[0]=cin;
    generate 
    for(k=0;k<B;k=k+1)
        begin: generate_ripple_carry_B_bit
            full_adder fa (a[k],b[k],c[k],c[k+1],sum[k]);
        end
    endgenerate
    assign cout=c[B];

endmodule

module full_adder(x,y,cin,cout,s);
    input wire x,y,cin;
    output wire cout,s;
    wire c_temp,s_temp,and_temp;
    
    xor s1 (s_temp,x,y);
    xor s2 (s,cin,s_temp);

    and c1 (c_temp,s_temp,cin);
    and c2 (and_temp,x,y);
    or c3(cout,and_temp,c_temp);

endmodule

// module full_adder(a, b, cin, cout, sum);
// input a, b, cin;
// output sum, cout;
// assign sum = a ^ b ^ cin;
// assign cout = (a & b) | ((a | b) & cin); 
// endmodule

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
    output out;

    assign out=(sel)?b:a;

endmodule