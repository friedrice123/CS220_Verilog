`include "mod10_async_counter_copy.v"
`timescale 1ns / 1ps
module test_counter;

	// Inputs
	reg clk,reset;
	// reg reset1;

	// Outputs
	wire [3:0] q;
    initial begin
	clk<=0;
	forever #10 clk<=~clk;
	end
	// Instantiate the Unit Under Test (UUT)
	TOP uut (
		.CLK(clk),
        .OUT(q), 
		.reset(reset)
	);
	

	initial begin
		// Initialize Inputs
		//clk = 0;
		$dumpfile("test.vcd");
		$dumpvars(0,test_counter);
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		
		#2000 $finish;
        
		// Add stimulus here

	end
      
endmodule

