module moles (
	input            clk,
	input            rst,
	input [27:0]     count, 
	input [9:0]      random, // number from prbs
	input [9:0]      switch,
	output reg [9:0] moles,  // array of 10 led signals
	output reg [23:0] score
);

	reg [9:0] switch_buffer = 0;
	integer i;
   
	always @(posedge clk) begin // when random changes
		if (rst == 1) begin
			moles <= 0;
			score <= 0;
		end else if (count == 100000000) begin // change moles
			moles <= random;
		end else begin
			for(i = 0; i < 10; i = i + 1) begin
				if (switch[i] == ~switch_buffer[i]) begin
					if(moles[i] == 1) begin
						moles[i] <= 0;
						score <= score + ((100000000 - count) >> 12); // get scoring from count, left shift to reduce score size
					end 
					switch_buffer[i] <= switch[i]; // update switch buffer
				end
			end
		end
	end

endmodule
