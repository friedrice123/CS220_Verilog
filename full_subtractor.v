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