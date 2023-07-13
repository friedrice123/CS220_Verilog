module decoder_3to8(a,b,c,y0,y1,y2,y3,y4,y5,y6,y7);
    input a,b,c;
    output y0,y1,y2,y3,y4,y5,y6,y7;
    wire a_comp,b_comp,c_comp;

    not n1 (a_comp,a);
    not n2 (b_comp,b);
    not n3 (c_comp,c);

    and a0 (y0,a_comp,b_comp,c_comp);
    and a1 (y1,a_comp,b_comp,c);
    and a2 (y2,a_comp,b,c_comp);
    and a3 (y3,a_comp,b,c);
    and a4 (y4,a,b_comp,c_comp);
    and a5 (y5,a,b_comp,c);
    and a6 (y6,a,b,c_comp);
    and a7 (y7,a,b,c);

endmodule