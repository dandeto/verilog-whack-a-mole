module prbs16(
	      input 		clk,
	      input 		rst,
	      input 		shiftEn,
	      output [9:0] outSeq
	      );

   reg [9:0] lfsrReg;

   initial begin
      lfsrReg <= 10'b1001001101;
   end
   
   always @(posedge clk)
     begin
	if (rst)
	  begin
	     lfsrReg <= 10'b1001001101;
	  end
	else if (shiftEn)
	  begin
	     lfsrReg[9] <= lfsrReg[8];
	     lfsrReg[8] <= lfsrReg[7];
	     lfsrReg[7] <= lfsrReg[6];
	     lfsrReg[6] <= lfsrReg[5];
	     lfsrReg[5] <= lfsrReg[4];
	     lfsrReg[4] <= lfsrReg[3];
	     lfsrReg[3] <= lfsrReg[2];
	     lfsrReg[2] <= lfsrReg[1];
	     lfsrReg[1] <= lfsrReg[0];
	     lfsrReg[0] <= lfsrReg[9] ^ lfsrReg[6] ^ lfsrReg[5] ^ lfsrReg[4];
	  end
	if(lfsrReg == 0)
	  begin
	     lfsrReg <= 10'b1001001101;
	  end
     end
   assign outSeq = lfsrReg;
endmodule
