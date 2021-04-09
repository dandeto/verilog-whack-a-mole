module prbs16(
	      input 		clk,
	      input 		rst,
	      input 		shiftEn,
	      output [15:0] outSeq
	      );

   reg [15:0] lfsrReg;

   initial begin
      lfsrReg <= 16'hFFFF;
   end
   
   always @(posedge clk)
     begin
	if (rst)
	  begin
	     lfsrReg <= 16'hFFFF;
	  end
	else if (shiftEn)
	  begin
	     lfsrReg[15] <= lfsrReg[14];
	     lfsrReg[14] <= lfsrReg[13];
	     lfsrReg[13] <= lfsrReg[12];
	     lfsrReg[12] <= lfsrReg[11];
	     lfsrReg[11] <= lfsrReg[10];
	     lfsrReg[10] <= lfsrReg[9];
	     lfsrReg[9] <= lfsrReg[8];
	     lfsrReg[8] <= lfsrReg[7];
	     lfsrReg[7] <= lfsrReg[6];
	     lfsrReg[6] <= lfsrReg[5];
	     lfsrReg[5] <= lfsrReg[4];
	     lfsrReg[4] <= lfsrReg[3];
	     lfsrReg[3] <= lfsrReg[2];
	     lfsrReg[2] <= lfsrReg[1];
	     lfsrReg[1] <= lfsrReg[0];
	     lfsrReg[0] <= lfsrReg[15] ^ lfsrReg[12] ^ lfsrReg[11] ^ lfsrReg[10];
	  end
	if(lfsrReg == 16'h0000)
	  begin
	     lfsrReg <= 16'hFFFF;
	  end
     end
   assign outSeq = lfsrReg;
endmodule
