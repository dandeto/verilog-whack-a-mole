module moles (
	input            clk,
	input            mole_clk,
	input            rst,
	input [3:0]      idle,
	input [27:0]     count, 
	input [9:0]      random, // number from prbs
	input [9:0]      switch,
	output reg [9:0] moles,  // array of 10 led signals
	output reg [23:0] score
);

	reg [9:0] switch_buffer = 0;
	reg [3:0] last_idle = 0;
	reg reverse = 0;
	reg start = 0;
	integer i;
   
	always @(posedge clk) begin
		if (rst == 1) begin
			//moles <= switch; // this could help the user reset the switches, but it actually doesn't matter
			// cool idle animation
			if(idle != last_idle) begin
				last_idle <= idle;
				moles <= 0;
				if(reverse == 0) begin
					if(idle == 9) begin reverse <= 1; end
					moles[idle] <= 1;
				end else begin
					if(idle == 9) begin reverse <= 0; end
					moles[9-idle] <= 1;
				end
			end
			start <= 1; // reset start
			score <= 0; // reset score
		end else begin
			if(start) begin
				moles <= 0;
				start <= 0;
				switch_buffer[i] <= switch[i]; // init switch buffer
			end
			if (mole_clk == 1) begin // change moles on clk unless reset
				moles <= random;
			end

			// take switch input unless reset
			for(i = 0; i < 10; i = i + 1) begin
				if (switch[i] == ~switch_buffer[i]) begin
					if(moles[i] == 1) begin
						moles[i] <= 0;
						score <= score + ((100000000 - count) >> 14); // get scoring from count, left shift to reduce score size
					end 
					switch_buffer[i] <= switch[i]; // update switch buffer
				end
			end
		end
	end
endmodule
