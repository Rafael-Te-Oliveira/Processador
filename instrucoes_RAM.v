module instrucoes_RAM (endereco, instrucao);

	input [31:0] endereco;
	output [31:0] instrucao;
	
	reg [31:0] inst_ram[1024:0];
	
	initial begin
			$readmemb("codigoBinario.txt", inst_ram);
			//inst_ram[0] = 32'b00110000000000000000000000000000;//out r0
			//inst_ram[1] = 32'b00100100001000000000000000000010;//lw r1 <- mem[r0 + 2]
			//inst_ram[2] = 32'b00110000001000000000000000000000;//out r1 = 2
			//inst_ram[3] = 32'b00100100010000010000000000000010;//lw r2 <= mem[r1 + 2]
			//inst_ram[4] = 32'b00110000010000000000000000000000;//out r2 = 4
			//inst_ram[5] = 32'b00101000001000000000000000000001;//sw r1 -> mem[r0 + 1]
			//inst_ram[6] = 32'b00100100011000000000000000000001;//lw r3 <- mem[r0 + 1]
			//inst_ram[0] = 32'b00110000000000000000000000000000;//out r3
			
	end
	
	assign instrucao = inst_ram[endereco];

endmodule