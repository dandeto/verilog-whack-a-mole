module up_counter #(
  parameter WIDTH,
  parameter TERM_CNT //  2**(WIDTH)-1
) (
  input      clk, reset, en,
  output reg [WIDTH-1:0] count,
  output reg timer
);

always @(posedge clk or posedge reset)
begin
  if (reset == 1) begin
    count <= 0;
    timer <= 0;
  end else if(en == 1) begin
    if(count < TERM_CNT) begin
      count <= count + 1;
      timer <= 0;
    end else begin // reached max, reset and timer goes off
      count <= 0;
      timer <= 1;
    end
  end
end

endmodule
