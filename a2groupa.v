module mjolnir(a,b,sum,cout);
    parameter k=16;
    input [k-1:0]a,b;
    output [k-1:0]sum;
    output cout;
    wire c,c0,c1;
    wire [(k/2)-1:0] s1,s0;
    b_bit_full_adder u1(a[(k/2)-1:0],b[(k/2)-1:0],1'b0,sum[(k/2)-1:0],c);
    b_bit_full_adder u2(a[k-1:(k/2)],b[k-1:(k/2)],1'b0,s0,c0);
    b_bit_full_adder u3(a[k-1:(k/2)],b[k-1:(k/2)],1'b0,s1,c1);
    mux_2to1_sum u4(s0,s1,c,sum[k-1:(k/2)]);
    mux_2to1_c u5(c0,c1,c,cout);
endmodule

module b_bit_full_adder(a,b,cin,sum,cout);
    parameter B=8;
    input [B-1:0] a,b;
    input cin;
    output [B-1:0] sum;
    output cout;
    wire carry[B-1:0];
    genvar i;
    generate
        for(i=0;i<B;i=i+1)begin
            if (i==0) begin
                full_adder uut(a[0],b[0],cin,sum[0],carry[0]);
            end
            else begin 
                full_adder uut(a[i],b[i],carry[i-1],sum[i],carry[i]);
            end
        end
    endgenerate
    assign cout=carry[B-1];
endmodule

module mux_2to1_sum(s0,s1,sel,out);
    parameter b=8;
    input [b-1:0] s0,s1;
    input sel;
    output reg [b-1:0] out;
    always@ (s0,s1,sel)begin
        case(sel)
        1'b0: out<=s0;
        default: out<=s1;
        endcase
    end
endmodule

module mux_2to1_c(c0,c1,sel,out);
    input c0,c1;
    input sel;
    output reg out;
    always@ (c0,c1,sel)begin
        case(sel)
        1'b0: out<=c0;
        default: out<=c1;
        endcase
    end
endmodule

module full_adder(a,b,cin,sum,cout);
    input a,b,cin;
    output sum,cout;
    assign sum=a^b^cin;
    assign cout=(a&b)|((a^b)&cin);
endmodule