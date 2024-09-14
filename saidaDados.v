module saidaDados (clock, dados, out, saida, segmentos, neg);
	
	input clock;
	input[31:0] dados;
	input out;

	integer i;
	
	reg[31:0] ultSegmentos;
	reg[31:0] dadosPos;
	
	output reg[31:0] segmentos;
	output reg[31:0] saida;
	output reg neg;
	
	
	always @(posedge clock) begin
		case(out)
			1'b01:begin
			segmentos = 0;
			saida = dados;
			dadosPos = dados;
			if(dados[31])begin
				dadosPos = ~dados + 1;
				neg = 1;
			end
			if(!dados[31])begin
				neg = 0;
			end
			for(i=0;i<31;i=i+1)begin
			if(segmentos[3:0] >= 5) segmentos[3:0] = segmentos[3:0] +3;
			if(segmentos[7:4] >= 5) segmentos[7:4] = segmentos[7:4] +3;
			if(segmentos[11:8] >= 5) segmentos[11:8] = segmentos[11:8] +3;
			if(segmentos[15:12] >= 5) segmentos[15:12] = segmentos[15:12] +3;
			if(segmentos[19:16] >= 5) segmentos[19:16] = segmentos[19:16] +3;
			if(segmentos[23:20] >= 5) segmentos[23:20] = segmentos[23:20] +3;
			if(segmentos[27:24] >= 5) segmentos[27:24] = segmentos[27:24] +3;
			if(segmentos[31:28] >= 5) segmentos[31:28] = segmentos[31:28] +3;
			segmentos = {segmentos[31:0], dadosPos[30-i]};
			ultSegmentos = segmentos;
			end
		end
	endcase
	end
endmodule