module PC (changeProgram, defquantum, lpc, enderecoPc, endProgram, novoEnd, novoEndR, desvio, zero, negativo, clock, endereco, stop, reset, enderecoSpc);
 
	input changeProgram;
	input defquantum;
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

	integer instNum = 0;
	
	 reg [31:0] quantum;
	 reg [31:0] execProgram;
	 reg [31:0] offset;
	 integer programa = 1;
	 integer programaAtual = 1;
	
	initial begin
		endereco = 199;
		enderecoSpc = 0;
		quantum = 0;
		execProgram = 0;
	end
	
	always @(posedge clock)begin
		
		if(defquantum)begin
			quantum = novoEndR;
		end
		
		if(lpc)begin
			programa = execProgram;
		end
		
		offset = programa * 200;
		
		if (!stop) begin
			if(((instNum>=quantum && programa != 0 && programa != 1) || endProgram || changeProgram) && !desvio) begin
				if(endProgram) begin
					enderecoSpc = endereco;
				end else begin
					enderecoSpc = endereco + 1;
				end
				
				if(changeProgram) begin
					execProgram = novoEndR + 1;
				end else begin
					execProgram = 1;
				end
				endereco = 0;
				instNum = 0;
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

		if (reset) begin
			 endereco = 199;
		end
	end
endmodule
