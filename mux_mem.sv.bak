module mux_Mem (dadosLidos, result, memReg, saida);

	input[31:0] dadosLidos;
	input[31:0] result;
	input memReg;
	
	output reg [31:0] saida;
	
	always @(*) begin
		if(memReg) saida = dadosLidos;
		if(!memReg) saida = result;
	end
endmodule