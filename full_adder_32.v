module full_adder_32 (x,y,s);
    input [31:0] x,y;
    output [31:0] s;
    wire cout;
    wire [31:0] carry;

    genvar i;
    generate
    for(i=0;i<32;i=i+1)
        begin: generate_full_adder_32
            if(i==0) begin
                half_adder h1 (x[0],y[0],s[0],carry[0]);
            end
            else begin
                full_adder f1 (x[i],y[i],carry[i-1],carry[i],s[i]);
            end
        end    
    assign cout = carry[31];
    endgenerate
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

module half_adder(x,y,s,cout);
    input x,y;
    output s,cout;
    wire x1,x2;
    xor s1 (s,x,y);
    and s2 (cout,x,y);
endmodule