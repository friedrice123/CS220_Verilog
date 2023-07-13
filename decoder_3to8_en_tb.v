`include "decoder_3to8_en.v"

module decoder_3to8_en_tb();
    reg [2:0] inp;
    reg enab;
    wire [7:0] y;

    decoder_3to8_en G5 (.inp(inp),.enab(enab),.y(y));

    initial begin
        $dumpfile("decoder_3to8_en_tb.vcd");
        $dumpvars(0, decoder_3to8_en_tb);

        enab=0;inp=5;#10;
        enab=1;inp=0;#10;
        enab=1;inp=1;#10;
        enab=1;inp=2;#10;
        enab=1;inp=3;#10;
        enab=1;inp=4;#10;
        enab=1;inp=5;#10;
        enab=1;inp=6;#10;
        enab=1;inp=7;#10;
        enab=0;inp=0;#10;
    end

endmodule