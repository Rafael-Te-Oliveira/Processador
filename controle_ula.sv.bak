module controle_ULA (instrucao, opULA, selec);

	input [31:0] instrucao;
	input [1:0] opULA;
	
	output reg[2:0] selec;
	
	always @(selec) begin
		case(opULA[1:0])
			2'b00: selec = 3'b000;
			2'b01: begin
				case(instrucao[5:0])
					6'b000000: selec = 3'b001; //soma
					6'b000001: selec = 3'b010; //sub
					6'b000010: selec = 3'b011; //mult
					6'b000011: selec = 3'b100; //div
					6'b000100: selec = 3'b101; //and
					6'b000101: selec = 3'b110; //or
					6'b000110: selec = 3'b111; //invert
				endcase
				end
			2'b10: selec = 3'b010;
			2'b11: selec = 3'b001;
		endcase
	end
endmodule
		