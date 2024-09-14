module dados_RAM (endereco, dados, escreveMem, clock, dadosLidos);
	
	input [31:0] dados;
	input [31:0] endereco;
	input escreveMem, clock;
	output [31:0] dadosLidos;
	
	reg[31:0] dados_ram[1024:0];
	
	initial begin
			//dados_ram[0] = 32'b00000000000000000000000000000000;
			//dados_ram[1] = 32'b00000000000000000000000000000001;
			//dados_ram[2] = 32'b00000000000000000000000000000010;
			//dados_ram[3] = 32'b00000000000000000000000000000011;
			//dados_ram[4] = 32'b00000000000000000000000000000100;
			//dados_ram[5] = 32'b00000000000000000000000000000101;
	end
	
	always @ (posedge clock) begin
		if (escreveMem) begin
			dados_ram[endereco] = dados;
		end
	end
	
	assign dadosLidos = dados_ram[endereco];
	
endmodule