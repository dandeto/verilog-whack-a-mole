module gameFSM (
	input      clk,
	input      start_btn,
	input      time_up,
	output     game_state
);

	// enum
	localparam GAME_ON   = 0;
	localparam HIGHSCORE = 1;
	
	reg STATE = HIGHSCORE;

	always @(posedge clk) begin
		if (STATE == GAME_ON) begin
			if(start_btn || time_up) begin
				STATE <= HIGHSCORE;
			end			
		end else if (STATE == HIGHSCORE) begin
			if(start_btn) begin // if in highscore state and hit start button
				STATE <= GAME_ON;
			end
		end
	end
	
	assign game_state = STATE;
endmodule
