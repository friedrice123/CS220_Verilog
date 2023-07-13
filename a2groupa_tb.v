`include "a2groupa.v"

module test;
    parameter k=16;
    reg [k-1:0] a,b;
    wire [k-1:0] sum;
    wire cout;
    mjolnir a1(.a(a),.b(b),.sum(sum),.cout(cout));
    initial begin
        #20;
        a=34;b=5;#40;
        $display("%d %d",sum,cout);
    end
endmodule