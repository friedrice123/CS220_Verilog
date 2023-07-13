module mux_4to1(a,b,c,d,s1,o);
input [31:0] a,b,c,d;
input [1:0] s1;
output reg [31:0]o;
always @(a or b or c or d or s1)
begin
    case(s1)
    2'b00 : o = a;
    2'b01 : o = b;
    2'b10 : o = c;
    default : o = d;
    endcase 
end
endmodule