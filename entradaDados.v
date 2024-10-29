module entradaDados(clock, entrada, in, out, enter, sinal, valor);

	input[17:0] entrada;
	input clock;
	input in, out;
	input enter;
	
	integer controle=0;
	
	output reg sinal;
	output reg [17:0] valor;
	
	always @(posedge clock) begin
				sinal = 1'b0;
				if(in && !controle && !enter)begin
					valor = entrada;
					sinal = !enter;
					controle = 1;
				end
				if(out && !controle && !enter)begin
					sinal = !enter;
					controle = 1;
				end
				if(enter) begin
					sinal = 1'b0;
					controle = 0;
				end
	end
endmodule