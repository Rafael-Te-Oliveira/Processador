module teste (clock, enter,reset, entrada, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, ledr);
	
	input clock;
	input enter;
	input reset;
	input[17:0] entrada;
	
	wire[17:0] valor;
	wire sinal;
	wire[31:0] saida;
	wire[31:0] segmentos;
	wire[31:0] instrucao;
	wire[31:0] endereco;
	wire[1:0] opULA;
	wire regDst;
	wire[2:0] desvio;
	wire memReg;
	wire escreveMem;
	wire [1:0] origULA;
	wire escreveReg;
	wire [1:0]ext;
	wire out;
	wire in;
	wire stop;
	wire jal;
	wire [31:0] leRS;
	wire [31:0] leRT;
	wire [31:0] leRD;
	wire [31:0] imediato;
	wire [2:0] selec;
	wire [31:0] result;
	wire zero;
	wire negativo;
	wire [31:0] dadosLidos;
	wire [31:0] dados;
	wire neg;
	wire divclock;
	
	output [6:0] seg0;
	output [6:0] seg1;
	output [6:0] seg2;
	output [6:0] seg3;
	output [6:0] seg4;
	output [6:0] seg5;
	output [6:0] seg6;
	output [6:0] seg7;
	output [3:0] ledr;
	
	contato1 C1(clock, ledr, reset, divclock);
	
	PC PC(imediato, result, desvio, zero, negativo, divclock, endereco, stop, reset);
	
	entradaDados(divclock, entrada, in, out, enter, sinal, valor);
	
	instrucoes_RAM INST(endereco, instrucao,  clock , divclock);
	
	UC UC(instrucao, divclock, sinal, desvio, memReg, opULA, escreveMem, origULA, escreveReg, ext, out, in, stop, jal);
	
	BancoRegistradores BR(instrucao, divclock, escreveReg, dados, endereco, jal, leRS, leRT, leRD);
	
	extensor_Bit BIT(instrucao, valor, ext, imediato);
	
	controle_ULA cULA(instrucao, opULA, selec);
	
	ULA ULA (selec, leRS, leRT, leRD, imediato, origULA, result, zero, negativo);
	
	dados_RAM DADO(leRS, result, result, escreveMem, clock , divclock, dadosLidos);
	
	//dados_RAM DADO(result, leRS, escreveMem, divclock, dadosLidos);
	
	mux_Mem MUX(dadosLidos, result, memReg, dados);
	
	saidaDados SaidaDados(divclock, dados, out, saida, segmentos, neg);
	
	display7seg Display(segmentos, neg, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);
		

endmodule 