module PC (lpc, enderecoPc, endProgram, novoEnd, novoEndR, desvio, zero, negativo, clock, endereco, stop, reset, enderecoSpc);
 
	input lpc;
	input [31:0] enderecoPc;
	input endProgram;
	input clock, stop, reset;
	input [2:0] desvio;
	input [31:0] novoEnd;
	input [31:0] novoEndR;
	input zero, negativo;
	
	output reg [31:0] endereco;
	output reg [31:0] enderecoSpc;
	
	integer quantum = 5;
	integer instNum = 0;
	
	 reg [31:0] offset;
	 integer programa = 1;
	 integer programaAtual = 1;
	
	initial begin
		endereco = 999;
		enderecoSpc = 0;
	end
	
	always @(posedge clock)begin
		
		if(lpc)begin
			programa = programaAtual % 5 + 1;
			//programa = 1;
		end
		
		offset = programa * 1000;
		
		if (!stop) begin
			if(((instNum>=quantum && programa != 0)|| endProgram) && !desvio) begin
				enderecoSpc = endereco + 1;
				endereco = 0;
				instNum = 0;
				programaAtual = programa;
				programa = 0;
			end else begin
				if(programa != 0) begin 
					instNum = instNum + 1;
				end
				if(lpc) begin
						endereco = enderecoPc + offset;
				end else begin
					 case (desvio)
						  3'b000: endereco = endereco + 1;
						  3'b001: endereco = novoEnd + offset;
						  3'b010: endereco = (zero) ? novoEnd + offset : endereco + 1;
						  3'b100: endereco = (zero) ? endereco + 1 : novoEnd + offset;
						  3'b101: endereco = (negativo) ? novoEnd + offset : endereco + 1;
						  3'b110: endereco = (negativo || zero) ? novoEnd + offset : endereco + 1;
						  3'b011: endereco = novoEndR;
					 endcase
				end
			end
		end

		if (~reset) begin
			 endereco = 999;
		end
	end
endmodule
