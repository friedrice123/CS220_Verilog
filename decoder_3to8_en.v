module decoder_3to8_en (inp,enab,y);
    input [2:0] inp;
    input enab;
    output [7:0] y;
        reg [7:0] y;

    always @(inp or enab)
        begin
            if(enab) begin
                y=8'b00000000;
                case(inp)
                    3'b000: y[0]=1'b1;
                    3'b001: y[1]=1'b1;
                    3'b010: y[2]=1'b1;
                    3'b011: y[3]=1'b1;
                    3'b100: y[4]=1'b1;
                    3'b101: y[5]=1'b1;
                    3'b110: y[6]=1'b1;
                    3'b111: y[7]=1'b1;
                    default: y=8'b00000000;
                endcase
            end
            else begin
                y=8'b00000000;
            end
        end
endmodule