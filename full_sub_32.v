module full_sub_32 (x,y,bin,bout,d);
    input [31:0] x,y;
    input bin;
    output [31:0] d;
    output bout;

    wire [31:0] carry;

    genvar i;
    generate
    for(i=0;i<32;i=i+1)
        begin
            if (i==0) full_subtractor f1(x[i],y[i],bin,carry[i],d[i]);
            else full_subtractor f1(x[i],y[i],carry[i-1],carry[i],d[i]);
        end    
    endgenerate

    assign bout = carry[31];

endmodule

module full_subtractor(x,y,bin,bout,d);
    input wire x,y,bin;
    output wire bout,d;
    wire b_temp,d_temp,a1,a2,a3,n1;
    
    xor s1 (d_temp,x,y);
    xor s2 (d,bin,d_temp);

    not c1 (n1,x);
    and c2 (a1,n1,bin);
    and c3 (a2,n1,y);
    and c4 (a3,y,bin);
    or c5 (b_temp,a1,a2);
    or c6 (bout,a3,b_temp);

endmodule

// module half_subtractor (x,y,d,bout);
//     input x,y;
//     output d,bout;
//     wire xnot,ynot;
//     not n1 (xnot,x);
//     not n2 (ynot,y);
//     xor s1 (d,x,y);
//     and s2 (bout,xnot,y);
// endmodule