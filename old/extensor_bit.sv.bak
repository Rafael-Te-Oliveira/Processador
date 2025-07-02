module extensor_Bit(instrucao, valor, ext, imediato);
	input[31:0] instrucao;
	input[17:0] valor;
	input[1:0] ext;
	output reg[31:0] imediato;
	
	always @(*) begin
		case(ext)
			2'b00:begin
				imediato = instrucao[15:0]; // tipo I
				if(instrucao[15] == 1'b1) imediato = imediato + 32'b11111111111111110000000000000000;
			end
			2'b01:begin
				imediato = instrucao[25:0]; // tipo J
				if(instrucao[25] == 1'b1) imediato = imediato + 32'b11111100000000000000000000000000;
			end
			2'b10:begin
				imediato = valor[17:0]; // input
				if(valor[17] == 1'b1) imediato = imediato + 32'b11111111111111000000000000000000;
			end
	endcase
	end
endmodule 