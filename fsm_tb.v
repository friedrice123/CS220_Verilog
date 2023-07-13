`timescale 1ns / 1ns
`include "fsm.v"
 module testbench;
// Inputs
reg x;
reg clk;
reg reset;
// Outputs
wire z;
// Instantiate the Unit Under Test (UUT)
seq_detector uut (
    .x(x), 
    .clk(clk), 
    .reset(reset), 
    .z(z)
);

initial begin
clk = 0;
forever #5 clk = ~clk;
end 
// initial begin
//  $dumpfile("dump.vcd");
//  $dumpvars(0, testbench);

    
//     reset = 1'b1;
//     x = 1'b0;
//     begin 
//     #12 x = 0;#10 x = 0 ; #10 x = 1 ; #10 x = 0 ;
//     #12 x = 1;#10 x = 0 ; #10 x = 1 ; #10 x = 0 ;
//     #12 x = 1;#10 x = 1 ; #10 x = 0 ; #10 x = 1 ;
//     #12 x = 0;#10 x = 1 ; #10 x = 1 ; #10 x = 0 ;
//     #10 $finish;
//     end 
// end 
initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1, testbench);
  // Initialize Inputs
  x = 0;
  reset = 1;
  // Wait 100 ns for global reset to finish
  #30;
      reset = 0;
  #40;
  x = 1;
  #10;
  x = 0;
  #10;
  x = 1; 
  #20;
  x = 0; 
  #20;
  x = 1; 
  #20;
  x = 0;
  #20;  
  // Add stimulus here
  $finish;

 end
endmodule