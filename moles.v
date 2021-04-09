module moles (
	      input 	       clk,
	      input 	       rst,
	      input [27:0]     count, 
	      input [9:0]      random, // number from prbs
	      output reg [9:0] moles        // array of 10 led signals
	      );

   reg [9:0] 		       old_moles = 0;
   
   always @(posedge clk) begin
      if (rst == 1) begin
	 moles <= 9'b0;
      end else if (count == 20000000) begin
	 moles <= random;
	 old_moles <= random;
      end else begin
	 moles <= old_moles;
      end
   end
endmodule
