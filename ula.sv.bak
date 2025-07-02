module ULA (selec, RS, RT, RD, IMED, origULA, result, zero, negativo);

	input [2:0] selec;
	input [31:0] RS, RT, RD, IMED;
	input [1:0] origULA;
	output reg [31:0] result;
	output zero, negativo;

	always @(selec or RS or RT or RD or IMED) begin
		
		if(origULA == 2'b00) begin //tipo R
		case (selec[2:0])
			3'b000: result = RS;
			3'b001: result = RT + RD;
			3'b010: result = RT - RD;
			3'b011: result = RT * RD;
			3'b100: result = RT / RD;
			3'b101: result = RT & RD;
			3'b110: result = RT | RD;
			3'b111: result = -RT;
		endcase
		end
		
		if(origULA == 2'b01) begin //tipo I
		case (selec[2:0])
			3'b001: result = RT + IMED; //addi
			3'b010: result = RT - IMED; //subi
		endcase
		end
		
		if(origULA == 2'b10) begin //Comparacoes
		case (selec[2:0])
			3'b001: result = RS - RT; //blt
			3'b010: result = RT - RS; //bgt
		endcase
		end
	end
	assign negativo = result[31];
	nor(zero, result[31], result[30], result[29], result[28], result[27], result[26], result[25], result[24], result[23], result[22], result[21], result[20],
			result[19], result[18], result[17], result[16], result[15], result[14], result[13], result[12], result[11], result[10], result[9], result[8],
			result[7], result[6], result[5], result[4], result[3], result[2], result[1], result[0]);
endmodule