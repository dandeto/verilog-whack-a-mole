module up_counter #(
  parameter WIDTH,
  parameter TERM_CNT //  2**(WIDTH)-1
) (
  input      clk, reset, en,
  output reg [WIDTH-1:0] count,
  output reg clk_out
);

always @(posedge clk)
begin
  if (reset == 1) begin
    count <= 0;
    clk_out <= 0;
  end else if(en == 1) begin
    if(count < (TERM_CNT/2)-1) begin // first half
      count <= count + 1;
      clk_out <= 1;
    end else if(count < TERM_CNT) begin // second half
      count <= count + 1;
      clk_out <= 0;
    end else begin // reached max, reset
      count <= 0;
      clk_out <= 1;
    end
  end
end

endmodule
