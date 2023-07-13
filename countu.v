module TOP (q,clk,reset);
output [3:0] q;
input clk, reset;
reg a1;
always@(posedge clk or posedge reset)
begin 
    if(reset==0) begin
        a1<=~(q[3]&q[1]);
    end
    else begin
        a1<=1;
    end
end
T_FF tff0 (q[0],clk,a1);
T_FF tff1(q[1],q[0],a1);
T_FF  tff2 (q[2],q[1], a1);
T_FF tff3 (q[3], q[2], a1);
endmodule

module T_FF(q,clk,reset);

output q;
input clk, reset;
wire d;

D_FF dff_0 (q,d,clk,reset);
not n1(d,q);

endmodule

module D_FF(q,d,clk,reset);
output q;
input d, clk,reset;
reg q; 

always@(posedge reset or negedge clk)
begin
	if(reset)
		q<=1'b0;
	else
  		q<=d;
end
endmodule