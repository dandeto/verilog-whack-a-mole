module moles (
	input clk,
	input rst,
	input [9:0] random, // number from prbs
	output reg [9:0] moles        // array of 10 led signals
);

	always @(posedge clk) begin
	  if (rst == 1) begin
		 moles <= 9'b0;
	  end else begin
		 moles <= random;
	  end
	end
endmodule
