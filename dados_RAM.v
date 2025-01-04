module dados_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] data,
    input [(ADDR_WIDTH-1):0] endereco_leitura, endereco_escrita,
    input we, read_clock, write_clock, offset_register,
    output reg [(DATA_WIDTH-1):0] q
);
    
    reg [DATA_WIDTH-1:0] ram[(ADDR_WIDTH-1):0];
	 reg [31:0] offset;
	 
    always @(posedge write_clock) begin
        if (offset_register) begin
            offset <= 0;
        end else begin
            offset <= 64;
        end
    end

    always @(posedge write_clock) begin
        if (we) begin
            ram[endereco_escrita + offset] <= data;
        end
    end

    always @(posedge read_clock) begin
        q <= ram[endereco_leitura + offset];
    end
    
endmodule


