`include "a2q1.v"
module ripple_carry_B_bit_tb;

 reg [3:0] a;
 reg [3:0] b;
 reg cin;
 wire cout, p;
 wire [3:0] sum;

 ripple_carry_B_bit uuo(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout), .p(p));

 initial begin
    $display("%d %d %d\n",a,b,sum);
  a = 9;
  b = 6;
  cin=0;
  #10000;
  $display("%d %d %d %d\n",a,b,sum,p);
  a = 10;
  b = 9;
  cin=1;
  #10000;
  $display("%d %d %d\n",a,b,sum);
  a = 13;
  b = 12;
  #10000;
  $display("%d %d %d\n",a,b,sum);
  a = 13;
  b = 10;
  #10000;
  $display("%d %d %d\n",a,b,sum);
 end
      
endmodule
