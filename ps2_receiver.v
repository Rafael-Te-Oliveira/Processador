module ps2_receiver (
    input ps2_clk,
    input ps2_data,
    output reg [7:0] scan_code,
    output reg scan_ready,
	 //output reg teste_ps2,
	 output reg [4:0] direcao
);
	reg [10:0] key_data;
	reg [7:0] auxCode;
	integer count = 0;
	 
	always @( negedge ps2_clk )
		begin
			key_data [ count ] = ps2_data ;
			count = count + 1;
			if( count == 11) // Recebendo os 11 bits do teclado
				begin
				if( auxCode == 8'hF0 ) // hF0 scancode que indica que a tecla foi "solta "
					scan_code <= key_data [8:1];
				auxCode = key_data [8:1];
				count = 0;
				end
	end
	
	always@ ( scan_code )
		begin
		if( scan_code == 8'h75 || scan_code == 8'h1d ) // Cima ou W
			direcao = 5'b00010 ;
		else if( scan_code == 8'h6b || scan_code == 8'h1c ) // Esq ou A
			direcao = 5'b00100 ;
		else if( scan_code == 8'h72 || scan_code == 8'h1b ) // Baixo ou S
			direcao = 5'b01000 ;
		else if( scan_code == 8'h74 || scan_code == 8'h23 ) // Dir ou D
			direcao = 5'b10000 ;
		else if( scan_code == 8'h29 ) // Space
			direcao = 5'b00111 ;
		else direcao <= direcao ;
	end
endmodule
