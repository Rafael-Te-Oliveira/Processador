module PC (novoEnd, novoEndR, desvio, zero, negativo, clock, endereco, stop, reset);

	input clock, stop, reset;
	input [2:0] desvio;
	input [31:0] novoEnd;
	input [31:0] novoEndR;
	input zero, negativo;
	output reg [31:0] endereco;
	
	initial begin
		endereco = 32'b11111111111111111111111111111111;
	end
	
	always @(posedge clock)begin
		if(!stop) begin
			if(desvio == 3'b000 || (desvio == 3'b010 && !zero) || (desvio == 3'b100 && zero) 
			|| (desvio == 3'b101 && !negativo) || (desvio == 3'b110 && !negativo && !zero)) begin
				endereco = endereco + 1;
			end
			if(desvio == 3'b001 || (desvio == 3'b010 && zero) || (desvio == 3'b100 && !zero) 
			|| (desvio == 3'b101 && negativo) || (desvio == 3'b110 && (negativo || zero))) begin
				endereco = novoEnd;
			end
			if(desvio == 3'b011) begin
				endereco = novoEndR;
			end
		end
		if(~reset) endereco = 32'b11111111111111111111111111111111;
	end
endmodule
