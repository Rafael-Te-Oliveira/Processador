module BancoRegistradores (instrucao, clock, escreveReg, dados_escrita, endereco, jal, leRS, leRT, leRD);
	
	input [31:0] instrucao;
	input clock, escreveReg, jal;
	input [31:0] dados_escrita;
	input [31:0] endereco;
	output [31:0] leRS;
	output [31:0] leRT;
	output [31:0] leRD;
	
	reg[31:0] regs [31:0];
	
	initial begin
		regs[0] = 32'b0;
	end
	
	always @ (posedge clock) begin
		if(escreveReg) begin
			regs[instrucao[25:21]] = dados_escrita; // RS
		end
		if(jal)begin
			regs[31] = endereco + 1;
		end
	end
	
	assign leRS = regs[instrucao[25:21]];
	assign leRT = regs[instrucao[20:16]];
	assign leRD = regs[instrucao[15:11]];
		
endmodule