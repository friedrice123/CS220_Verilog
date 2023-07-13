`include "full_subtractor_32.v"

`timescale 1ns / 1ns

module full_subtractor_32_tb();
    reg [31:0] x,y;
    reg bin;
    wire [31:0] d;
    wire bout;

    full_subtractor_32 G3 (.x(x), .y(y), .bin(bin), .bout(bout), .d(d));

    // initial begin
    //     $dumpfile("full_subtractor_32_tb.vcd");
    //     $dumpvars(0,full_subtractor_32_tb);

    //     x=59;y=11;bin=0;#100;
    //     $display("%d %d %d\n",x,y,d);
    //     #100;
    //     x=11;y=59;bin=0;#100;
    //     $display("%d %d %d\n",x,y,d);
        
    // end
    integer i;
    initial begin
        x <= 32'b0;
        y <= 32'b0;
        bin <= 1'b0;

        $monitor("x=%b, y=%b, bin=%b, d=%b, bout=%b", x, y, bin, d, bout);

        for (i = 0; i < 8; i = i + 1) begin
            #10 x <= $random;
            y <= $random;
            bin <= $random;
    end
end

endmodule