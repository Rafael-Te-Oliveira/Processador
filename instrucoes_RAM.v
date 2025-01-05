module instrucoes_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] endereco,
    output reg [(ADDR_WIDTH-1):0] instruction,
	 input write_clock, read_clock 
);
    
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] inst_ram[7000];

    initial
		begin
			$readmemb("instrucoes_ram/rotina_troca_contexto.txt", inst_ram, 0, 999);
			$readmemb("instrucoes_ram/so.txt", inst_ram, 1000, 1999);
			//$readmemb("instrucoes_ram/programa_1.txt", inst_ram, 2000, 2999);
			//$readmemb("instrucoes_ram/programa_2.txt", inst_ram, 3000, 3999);
			//$readmemb("instrucoes_ram/programa_3.txt", inst_ram, 4000, 4999);
			//$readmemb("instrucoes_ram/programa_4.txt", inst_ram, 5000, 5999);
			//$readmemb("instrucoes_ram/programa_5.txt", inst_ram, 6000, 6999);
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