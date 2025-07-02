module ps2_receiver_old (
    input ps2_clk,
    input ps2_data,
    output reg [5:0] acoes // agora 6 bits
);
	 reg [10:0] key_data;
    reg [7:0] last_code;
    reg break_code = 0;
    integer count = 0;

    always @(negedge ps2_clk) begin
        key_data[count] = ps2_data;
        count = count + 1;

        if (count == 11) begin
            count = 0;

            if (key_data[8:1] == 8'hF0) begin
                break_code <= 1;
            end else begin
                if (break_code) begin
                    // Tecla liberada
                    case (key_data[8:1])
                        8'h1C, 8'h6B: acoes[1] <= 0; // A ou seta esquerda
                        8'h1D, 8'h75: acoes[0] <= 0; // W ou seta cima
                        8'h1B, 8'h72: acoes[2] <= 0; // S ou seta baixo
                        8'h23, 8'h74: acoes[3] <= 0; // D ou seta direita
                        8'h29:        acoes[4] <= 0; // Espaço
                        8'h5A:        acoes[5] <= 0; // Enter
                    endcase
                    break_code <= 0;
                end else begin
                    // Tecla pressionada
                    case (key_data[8:1])
                        8'h1C, 8'h6B: acoes[1] <= 1; // A ou seta esquerda
                        8'h1D, 8'h75: acoes[0] <= 1; // W ou seta cima
                        8'h1B, 8'h72: acoes[2] <= 1; // S ou seta baixo
                        8'h23, 8'h74: acoes[3] <= 1; // D ou seta direita
                        8'h29:        acoes[4] <= 1; // Espaço
                        8'h5A:        acoes[5] <= 1; // Enter
                    endcase
                end
            end
        end 
    end
endmodule
