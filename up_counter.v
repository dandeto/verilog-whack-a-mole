module up_counter #(
  parameter WIDTH,
  parameter TERM_CNT //  2**(WIDTH)-1
) (
  input      clk, reset, en,
  output reg [WIDTH-1:0] count
);

// e.g. if FREQ_KHZ is 50000, counting from 0 to 49999 has a 
// period of 50000 clock cycles


always @(posedge clk)
begin
  if (reset == 1) begin 
    count <= 0;
  end else if(en == 1) begin
		if(count == TERM_CNT) begin
			count <= 0;
		end else begin
			count <= (count + 1);
		end
  end
end

endmodule
