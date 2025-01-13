module saidaDados (clock, dados, endereco, entrada, out, in, saida, segmentos, segmentosPrograma, neg);
	
	input clock;
	input[31:0] dados;
	input[31:0] endereco;
	input[31:0] entrada;
	input out;
	input in;

	integer i;
	
	reg[31:0] ultSegmentos;
	reg[31:0] ultSegmentosPrograma;
	reg[31:0] dadosPos;
	reg[31:0] dadosPosPrograma;
	
	output reg[31:0] segmentos;
	output reg[31:0] segmentosPrograma;
	output reg[31:0] saida;
	output reg neg;
	
	
	always @(posedge clock) begin
		if(out) begin
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
		
		if (in) begin
			segmentos = 0;
			saida = entrada;
			dadosPos = entrada;
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
		
		segmentosPrograma = 0;
		saida = endereco;
		dadosPosPrograma = endereco;
		for(i=0;i<31;i=i+1)begin
		if(segmentosPrograma[3:0] >= 5) segmentosPrograma[3:0] = segmentosPrograma[3:0] +3;
		if(segmentosPrograma[7:4] >= 5) segmentosPrograma[7:4] = segmentosPrograma[7:4] +3;
		if(segmentosPrograma[11:8] >= 5) segmentosPrograma[11:8] = segmentosPrograma[11:8] +3;
		if(segmentosPrograma[15:12] >= 5) segmentosPrograma[15:12] = segmentosPrograma[15:12] +3;
		if(segmentosPrograma[19:16] >= 5) segmentosPrograma[19:16] = segmentosPrograma[19:16] +3;
		if(segmentosPrograma[23:20] >= 5) segmentosPrograma[23:20] = segmentosPrograma[23:20] +3;
		if(segmentosPrograma[27:24] >= 5) segmentosPrograma[27:24] = segmentosPrograma[27:24] +3;
		if(segmentosPrograma[31:28] >= 5) segmentosPrograma[31:28] = segmentosPrograma[31:28] +3;
		segmentosPrograma = {segmentosPrograma[31:0], dadosPosPrograma[30-i]};
		ultSegmentosPrograma = segmentosPrograma;
		end

	end
endmodule