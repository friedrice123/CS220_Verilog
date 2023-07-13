`include "a2q1.v"
module stormbreaker_tb;

 reg [127:0] a;
 reg [127:0] b;
 reg cin;
 wire cout;
 wire [127:0] sum;

 stormbreaker uut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

 initial begin
  a = 1205678900008765;
  b = 4563456789087654;
  cin=0;
  #10000;
  $display("%d %d %d %d\n",a,b,sum,cout);
  a = 84567897656890;
  b = 85678907658979;
  cin=0;
  #10000;
  $display("%d %d %d %d\n",a,b,sum,cout);
  a = 340282366920938463463374607431768211455;
  b = 3;
  cin=0;
  #10000;
  $display("%d %d %d %d\n",a,b,sum,cout);
  a = 1013;
  b = 1013;
  cin=1;
  #10000;
  $display("%d %d %d %d\n",a,b,sum,cout);
 end
      
endmodule
