`include "counter_design.v"
module TOP (CLK,OUT,reset);
  input CLK,reset;
  reg CLK_new;
  counter_design uut (
		.clk(CLK),
        .out(CLK_new), 
		.reset(reset)
	);
  output [3:0] OUT;
  wire [1:0]nine_yet_op;
//   reg [31:0] int_count;
  NINE_YET m(OUT,nine_yet_op);
  T_FF Q0(CLK_new,1'b1,OUT[0],reset);
  T_FF Q1(nine_yet_op[0],1'b1,OUT[1],reset);
  T_FF Q2(~OUT[1],1'b1,OUT[2],reset);
  T_FF Q3(nine_yet_op[1],1'b1,OUT[3],reset);
endmodule

module NINE_YET (IN,OUT);
  input  [3:0] IN;
  output reg [1:0]OUT;
  always @ ( * ) begin
    if(IN==9) OUT<=2'b01; //Q[3] should be toggled the next cycle, Q[2] should not
    else OUT<={~IN[2],~IN[0]}; //just pass Q` of Tff[2] and Tff[0]
  end
endmodule



module T_FF (CLK,T,OUT,reset);
  input CLK,T,reset;
  output reg OUT=0;
  always @ ( posedge CLK or posedge reset ) begin
    if(reset==0)
    begin
        if(T) OUT<=~OUT;
        else  OUT<=OUT;
    end
    else begin
        OUT<=0;
    end
  end
endmodule


// module T_FF(clk,reset,q);

// output q;
// input clk, reset;
// wire d;

// D_FF dff_0 (q,d,clk,reset);
// not n1(d,q);

// endmodule

// module D_FF(q,d,clk,reset);
// output q;
// input d, clk,reset;
// reg q; 

// always@(posedge reset or negedge clk)
// begin
// 	if(reset)
// 		q<=1'b0;
// 	else
//   		q<=d;
// end
// endmodule