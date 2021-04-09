module moles (
	input            clk,
	input            rst,
	input [27:0]     count, 
	input [9:0]      random, // number from prbs
	input [9:0]      switch,
	output reg [9:0] moles,  // array of 10 led signals
	output [23:0] score
);

	reg [9:0] switch_buffer = 10'b0;
	reg [23:0] score_reg = 0;
	integer i;
   
	always @(posedge clk) begin // when random changes
		if (rst == 1) begin
			moles <= 9'b0;
		end else if (count == 50000000) begin // change moles
			moles <= random;
		end else begin
			for(i = 0; i < 10; i = i + 1) begin
				if (switch[i] == ~switch_buffer[i]) begin
					if(moles[i] == 1'b1) begin
						moles[i] <= 1'b0;
						score_reg <= score_reg + 1'b1; // get scoring from count later
					end else if(moles[i] == 1'b0 && score_reg > 0) begin
						score_reg <= score_reg - 1'b1;
					end
					switch_buffer[i] <= switch[i]; // update switch buffer
				end
			end
		end
	end

	assign score = score_reg;
	
endmodule
