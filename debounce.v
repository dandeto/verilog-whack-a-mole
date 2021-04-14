module debounce #(
  parameter [15:0] DWELL_CNT
)  (
  input   clk,
  input   sig_in,
  output  sig_out
);

// TODO:
// declare reg signals here for the 16-bit counter and 1-bit state
localparam CNT_WIDTH = $clog2(DWELL_CNT);
localparam [CNT_WIDTH-1:0] TERM_CNT = DWELL_CNT - 1;

reg [CNT_WIDTH-1:0] counter;
reg state;

initial
begin
  // TODO: can add initialization values to registers here
  counter <= {CNT_WIDTH{1'b0}}; // not really important, but very handy for simulation
  state = sig_out;
end

always @(posedge clk)
begin
	if(state != sig_in) begin
		counter <= counter + 'h1; // increment counter
		if ((counter & TERM_CNT) == TERM_CNT) begin // NOTE: this is a cool way to avoid having a lot of digits to match; 
																  // The & (AND) operator with a constant makes it so that we only look
																  // at as many digits have 1's in the constant TERM_CNT.  For an up-counter
																  // the first time it hits a number with ones in all the spots we care
																  // about is when it hits TERM_CNT
		 counter <= 'h0;
		 state <= sig_in; // invert state
	  end /*else begin
		 counter <= counter + 'h1; // increment counter
	  end*/
	end else begin
		counter <= 'h0;
	end

end

// TODO: assign sig_out to the 1-bit reg that's tracking the debounce state
assign sig_out = state; //1'b0;
     
endmodule
     
