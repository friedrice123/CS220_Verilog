module veda(clk,reset,write_enable,address,data_in,mode,data_out);
input mode,clk,reset,write_enable;
input [4:0]address;
input [31:0]data_in;
output reg [31:0]data_out;
reg [31:0] temp;
reg [31:0] mem [31:0];
integer i;
always@(posedge clk)
begin
    //Scribble
    if(reset)
    begin
        for(i=0;i<32;i=i+1)
        begin
            mem[i]=32'b0;
        end
        temp=32'b0;
    end
    //Interpret
    else
    begin
        if(mode)
        begin
            for(i=0;i<32;i++)
            begin
                mem[i]=mem[i];
            end
        end
        else
        begin
            if(write_enable)
            begin
                for(i=0;i<32;i++)
                begin
                    mem[i]=mem[i];
                end
                mem[address]=data_in;
            end
            else
            begin
                for(i=0;i<32;i++)
                begin
                    mem[i]=mem[i];
                end
            end
        end
        temp=mem[address];
    end
end
always@(posedge clk)
begin
    data_out=temp;
end
endmodule
