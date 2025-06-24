module instrucoes_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] endereco,
    output reg [(ADDR_WIDTH-1):0] instruction,
	 input write_clock, read_clock 
);
    
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] inst_ram[800];

    initial
		begin
			//rotina
			$readmemb("instrucoes_ram/rotina_troca_contexto.txt", inst_ram, 0, 199);
			//sistema operacional
			$readmemb("instrucoes_ram/so.txt", inst_ram, 200, 399);
			//jogador
			$readmemb("instrucoes_ram/jogador.txt", inst_ram, 400, 599);
			//subtracao
			$readmemb("instrucoes_ram/programa_2.txt", inst_ram, 600, 799);
			//maior
			//$readmemb("instrucoes_ram/programa_3.txt", inst_ram, 800, 999);
			//fibonacci
			//$readmemb("instrucoes_ram/programa_4.txt", inst_ram, 1000, 1199);
			//perimetro
			//$readmemb("instrucoes_ram/programa_5.txt", inst_ram, 1200, 1399);
			//gcd
			//$readmemb("instrucoes_ram/programa_6.txt", inst_ram, 1400, 1599);
			//fatorial
			//$readmemb("instrucoes_ram/programa_7.txt", inst_ram, 1600, 1799);
			//potencia
			//$readmemb("instrucoes_ram/programa_8.txt", inst_ram, 1800, 1999);
		end
	 
    
    always @ (posedge write_clock) begin
        // Write with offset adjustment
        //if (we) begin
        //      ram[endereco_escrita] <= data;
        //end
    end
    
    always @ (posedge write_clock) begin

         instruction <= inst_ram[endereco];
      
    end
    
endmodule