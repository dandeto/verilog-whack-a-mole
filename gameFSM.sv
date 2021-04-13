module gameFSM (
	input        clk,
	input        rst,
	input [27:0] count,
	input        start_btn
);

	reg STATE;

	localparam GAME_ON   = 0;
	localparam HIGHSCORE = 1;

	always @(posedge clk) begin // when random changes
		if (GAME_ON) begin
			if(start_btn) begin
				STATE <= HIGHSCORE; // include timer as well
			end			
		end else if (HIGHSCORE)
			if(start_btn) begin // if in highscore state and hit start button
				STATE <= GAME_ON;
			end
		end
	end
endmodule
