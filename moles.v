module moles (
	input            clk,
	input            rst,
	input [27:0]     count, 
	input [9:0]      random, // number from prbs
	input [9:0]      switch,
	output reg [9:0] moles   // array of 10 led signals
);

	reg [9:0] switch_buffer = 10'b0;
	integer i;
   
	always @(count, switch) begin // when random changes
		if (rst == 1) begin
			moles <= 9'b0;
		end else if (count == 20000000) begin // change moles
			moles <= random;
		end else begin
			for(i = 0; i < 10; i = i + 1) begin
				if (switch[i] == ~switch_buffer[i]) begin
					moles[i] <= 1'b0; // get scoring from count
					switch_buffer[i] <= switch[i];
					// score = (20000000 - count); // then take the top 8 bits
				end
			end
		end
	end

endmodule
