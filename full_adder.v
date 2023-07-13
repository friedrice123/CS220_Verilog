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