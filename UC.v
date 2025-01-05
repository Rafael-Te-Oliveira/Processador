module UC (instrucao, clock, sinal, desvio, memReg, opULA, escreveMem, origULA, escreveReg, ext, out, in, stop, jal, offset_register, lpc, spc, nextProgram, endProgram);

	input [31:0] instrucao;
	input clock;
	input sinal;
	
	output reg[1:0] opULA;
	output reg[2:0] desvio;
	output reg memReg;
	output reg escreveMem;
	output reg[1:0] origULA;
	output reg escreveReg;
	output reg[1:0] ext;
	output reg out;
	output reg in;
	output reg stop;
	output reg jal;
	output reg offset_register;
	output reg lpc;
	output reg spc;
	output reg nextProgram;
	output reg endProgram;
	
	always @ (instrucao[31:26] || sinal) begin
	
		desvio = 3'b000;
		memReg = 1'b0;
		escreveMem = 1'b0;
		origULA = 2'b00;
		escreveReg = 1'b0;
		opULA = 2'b00;
		ext = 2'b00;
		out = 1'b0;
		in = 1'b0;
		stop = 1'b0;
		jal = 1'b0;
		offset_register = 1'b0;
		lpc = 1'b0;
		spc = 1'b0;
		endProgram = 1'b0;
		nextProgram = 1'b0;
				
		case(instrucao[31:26])
			6'b000000: begin //arit log
				escreveReg = 1'b1;
				opULA = 2'b01;
				end
			6'b000001: begin // addi
				origULA = 2'b01;
				escreveReg = 1'b1;
				opULA = 2'b11;
				end
			6'b000010: begin // subi
				origULA = 2'b01;
				escreveReg = 1'b1;
				opULA = 2'b10;
				end
			6'b000011: begin // jump
				desvio = 3'b001;
				ext = 2'b01;
				end
			6'b000100: begin //jr
				desvio = 3'b011;
				ext = 2'b01;
				end
			6'b000101: begin //beq
				desvio = 3'b010;
				origULA = 2'b10;
				opULA = 2'b10;
				end
			6'b000110: begin //bnq
				desvio = 3'b100;
				origULA = 2'b10;
				opULA = 2'b10;
				end
			6'b000111: begin //blt
				desvio = 3'b101;
				origULA = 2'b10;
				opULA = 2'b11;
				end
			6'b001000: begin //bgt
				desvio = 3'b101;
				origULA = 2'b10;
				opULA = 2'b10;
				end
			6'b001001: begin //ble
				desvio = 3'b110;
				origULA = 2'b10;
				opULA = 2'b11;
				end
			6'b001010: begin //bge
				desvio = 3'b110;
				origULA = 2'b10;
				opULA = 2'b10;
				end
			6'b001011: begin //lw
				memReg = 1'b1;
				origULA = 2'b01;
				escreveReg = 1'b1;
				opULA = 2'b11;
				end
			6'b001100: begin //sw
				escreveMem = 1'b1;
				origULA = 2'b01;
				opULA = 2'b11;
				end
			6'b001101: begin //jal
				desvio = 3'b001;
				ext = 2'b01;
				jal = 1'b1;
				end
			6'b001110: begin //out
				if(!sinal)begin
					stop = 1'b1;
					out = 1'b1;
					end
				end
			6'b001111: begin //in
				escreveReg = 1'b1;
				case(sinal)
					1'b0:begin
						stop = 1'b1;
						opULA = 2'b10;
						in = 1'b1;
					end
					1'b1:begin
						ext = 2'b10;
						opULA = 2'b11;
						origULA = 2'b01;
					end
				endcase
				end
			6'b010000: begin //nop
				end
			6'b010001: begin //halt
				endProgram = 1'b1;
				end
			6'b101011: begin //lc
				memReg = 1'b1;
				origULA = 2'b01;
				escreveReg = 1'b1;
				opULA = 2'b11;
				offset_register = 1'b1;
				end
			6'b101100: begin //sc
				escreveMem = 1'b1;
				origULA = 2'b01;
				opULA = 2'b11;
				offset_register = 1'b1;
				end
			6'b101111: begin //lpc
				lpc = 1'b1;
				end
			6'b100001: begin //spc
				spc = 1'b1;
				end
			6'b111111: begin //spc
				nextProgram = 1'b1;
				end
		endcase
	end

	endmodule