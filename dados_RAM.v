module dados_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] data,
    input [(ADDR_WIDTH-1):0] endereco_leitura, endereco_escrita,
    input we, read_clock, write_clock, offset_register, spc, lpc, nextProgram, changeProgram,
	 input [(DATA_WIDTH-1):0] enderecoSpc,
    output reg [(DATA_WIDTH-1):0] q
);

    reg [31:0] execProgram;
    reg [DATA_WIDTH-1:0] ram[7000];
	 reg [31:0] offset;
	 integer programa = 1;
	 integer i = 1;
	 
	 always @(posedge write_clock) begin
			if(changeProgram)begin
				execProgram = endereco_leitura;
			end
			
			if(nextProgram) begin
				if(i%2)begin
					programa = execProgram;
				end else begin
					programa = 1;
				end
				i = i + 1;
				//programa = programa % 3 + 1;
				//programa = 1;
			end
	 end
	 
    always @(spc || lpc || offset_register) begin
			if (offset_register || spc || lpc) begin
				offset = 0;
			end else begin
				offset = 32;
			end
			
			offset = offset + programa * 1000;
    end

    always @(posedge write_clock) begin
		  if (spc) begin
				ram[offset] <= enderecoSpc - programa * 1000;
		  end else if (we) begin
            ram[endereco_escrita + offset] <= data;
        end 
		  
    end
			
    always @(posedge read_clock) begin
        if (lpc) begin
				q <= ram[offset];
		  end else begin
				q <= ram[endereco_leitura + offset];
		  end
    end
    
endmodule


