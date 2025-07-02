module dados_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] data,
    input [(ADDR_WIDTH-1):0] endereco_leitura, endereco_escrita,
    input we, read_clock, write_clock, offset_register, spc, lpc, nextProgram, changeProgram,
	 input [(DATA_WIDTH-1):0] enderecoSpc,
	 input endProgram,
    output reg [(DATA_WIDTH-1):0] q
);

    reg [31:0] execProgram;
    reg [DATA_WIDTH-1:0] ram[800];
	 reg [31:0] offset;
	 reg [31:0] programasAtivos = 232;
	 
	 reg [DATA_WIDTH-1:0] temp_value;
	 integer programa = 1;
	 integer i = 1;
	 reg encerrou = 0;
	 reg resetou= 0;
	 
	 
	 always @(posedge write_clock) begin
			if(changeProgram)begin
				execProgram = endereco_leitura + 1;
			end
			
			if(nextProgram) begin
				if(i%2)begin
					programa = execProgram;
				end else begin
					programa = 1;
				end
				i = i + 1;
			end
	 end
	 
    always @(spc || lpc || offset_register) begin
			if (offset_register || spc || lpc) begin
				offset = 0;
			end else begin
				offset = 32;
			end
			
			offset = offset + programa * 200;
    end

    always @(posedge write_clock) begin
		  if (spc) begin
				ram[offset] <= enderecoSpc - programa * 200;
		  end else if (resetou) begin
				ram[execProgram*200] <= 0;
				resetou <= 0;
		  end else if (we) begin
            ram[endereco_escrita + offset] <= data;
        end else if (endProgram) begin
				ram[programasAtivos + execProgram] <= 0;
				encerrou <= 1;
		  end else if (encerrou) begin
				ram[programasAtivos] <= temp_value - 1;
				encerrou <= 0;
				resetou <= 1;
		  end 

    end
			
    always @(posedge read_clock) begin
		  if (lpc) begin
				q <= ram[offset];
		  end  else begin
				q <= ram[endereco_leitura + offset];
		  end
    end
	 
	always @(posedge read_clock) begin
		if(endProgram) begin
				temp_value <= ram[programasAtivos];
		  end 
    end
    
endmodule


