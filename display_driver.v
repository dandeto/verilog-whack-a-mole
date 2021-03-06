module display_driver (
  input        clk,
  input        displayState,
  input        dispMode,
  input        oneMsPulse,
  input 			reset,
  input [23:0] score,
  input [23:0] highscore,
  output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

  localparam GAME_ON    = 1'b0; // display mode enum
  localparam HIGHSCORE  = 1'b1;
  
  localparam CHAR_R = 5'h10;
  localparam CHAR_O = 5'h11;
  localparam CHAR_G = 5'h12;
  localparam CHAR_BLANK = 5'h13;
  
  wire [15:0] DEC_POWER [4:0];
  assign DEC_POWER[4] = 16'd10000;
  assign DEC_POWER[3] = 16'd1000;
  assign DEC_POWER[2] = 16'd100;
  assign DEC_POWER[1] = 16'd10;
  assign DEC_POWER[0] = 16'd1;
  
  reg [11:0] threeSecCnt;
  
  reg [15:0] decResult;
  reg [15:0] decTemp;
  reg [2:0] decState;
  reg [3:0] decDigits [4:0];
  
  
  reg [4:0] char0;
  reg [4:0] char1;
  reg [4:0] char2;
  reg [4:0] char3;
  reg [4:0] char4;
  reg [4:0] char5;
  
  integer i;
  
  always @(*)
  begin
	/*if(reset) begin // must hold key down
	displayState = 1;
	end else begin
	displayState = 0;
	end*/
    if (displayState == GAME_ON) begin // regular score
      if (dispMode) // hex
        {char5,char4,char3,char2,char1,char0} = {1'b0,score[23:20],1'b0,score[19:16],1'b0,score[15:12],1'b0,score[11:8],1'b0,score[7:4],1'b0,score[3:0]};
      else begin // decimal
        char5 = CHAR_BLANK;
        char4 = {1'b0,decDigits[4]};
        char3 = {1'b0,decDigits[3]};
        char2 = {1'b0,decDigits[2]};
        char1 = {1'b0,decDigits[1]};
        char0 = {1'b0,decDigits[0]};
      end
    end else begin // high score
      {char5,char4,char3,char2,char1,char0} = {1'b0,highscore[23:20],1'b0,highscore[19:16],1'b0,highscore[15:12],1'b0,highscore[11:8],1'b0,highscore[7:4],1'b0,highscore[3:0]};
    end
  end

  /*always @(posedge clk)
  begin
    case (displayState)
    SHOW_RESULT : begin
      threeSecCnt <= 12'd0;
      if (ShowOpReg) begin
        displayState <= SHOW_OPREG;
      end else if (ShowOpCode) begin
        displayState <= SHOW_OPCODE;
      end
    end
    SHOW_OPREG : begin
      if (ShowOpCode) begin
        threeSecCnt  <= 12'd0;
        displayState <= SHOW_OPCODE;
      end else begin
        if (ShowOpReg) begin // another button press
          threeSecCnt  <= 12'd0;
        end else begin
          threeSecCnt <= threeSecCnt+oneMsPulse;
        end
        if (threeSecCnt==12'd2999) begin // timed out
          displayState <= SHOW_RESULT;
        end
      end
    end
    default : begin // SHOW_OPCODE
      if (ShowOpReg) begin
        threeSecCnt  <= 12'd0;
        displayState <= SHOW_OPREG;
      end else begin
        if (ShowOpCode) begin // another button press
          threeSecCnt  <= 12'd0;
        end else begin
          threeSecCnt <= threeSecCnt+oneMsPulse;
        end
        if (threeSecCnt==12'd2999) begin // timed out
          displayState <= SHOW_RESULT;
        end
      end
    end
    endcase
    
    if (decState==3'b111) begin // idle
      if (decResult!=score) begin // new value
        decState <= 3'b100; // ten thousands
        decResult <= score; // grab it right away, just in case the switch bounces (we will recalculate)
        for (i=0;i<=4;i=i+1) decDigits[i] <= {4'b0}; // reset
      end
      decTemp <= score;
    end else begin // here we will decrement through the values of 10^(4...0)
      if (decTemp>=DEC_POWER[decState]) begin
        decTemp <= decTemp-DEC_POWER[decState];
        decDigits[decState] <= decDigits[decState]+4'd1;
      end else begin
        decState <= decState-1;
      end
    end
  end*/
  
  // map the display values to hex driver
  hex_driver hex_display [5:0] (
    .InVal ({char5,char4,char3,char2,char1,char0}),
    .OutVal ({HEX5,HEX4,HEX3,HEX2,HEX1,HEX0})
  );
endmodule
