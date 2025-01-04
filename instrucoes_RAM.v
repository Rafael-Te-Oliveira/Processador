module instrucoes_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] endereco,
    output reg [(ADDR_WIDTH-1):0] instruction,
	 input write_clock, read_clock 
);
    
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] inst_ram[2048];

    initial
		begin
			$readmemb("codigoBinario.txt", inst_ram);
			//inst_ram[0] <= 32'b00000100001000000000000000000001;
			//inst_ram[1] <= 32'b00111000001000000000000000000000;
			//inst_ram[2] <= 32'b00000100001000000000000000000010;
			//inst_ram[3] <= 32'b00111000001000000000000000000000;
			//inst_ram[4] <= 32'b00000100001000000000000000000011;
			//inst_ram[5] <= 32'b00111000001000000000000000000000;
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