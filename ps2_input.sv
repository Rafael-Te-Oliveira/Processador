module ps2_input (
    input  logic clk,       // clock do sistema (ex: 50 MHz)
    input  logic ps2_clk,
    input  logic ps2_data,
    output reg acoes [0:5]
);

    // Flip-flops de sincronização para ps2_clk e ps2_data
    logic ps2_clk_sync_0, ps2_clk_sync_1;
    logic ps2_data_sync_0, ps2_data_sync_1;

    // Detecta borda negativa no ps2_clk sincronizado
    logic ps2_clk_sync_prev;

    // Registro para capturar os bits do dado
    reg [10:0] key_data;
    reg [3:0] bit_count;
    reg break_code;
	 
	 logic [7:0] scan_code;
    
    // Sincronização de ps2_clk
    always_ff @(posedge clk) begin
        ps2_clk_sync_0 <= ps2_clk;
        ps2_clk_sync_1 <= ps2_clk_sync_0;

        ps2_data_sync_0 <= ps2_data;
        ps2_data_sync_1 <= ps2_data_sync_0;

        ps2_clk_sync_prev <= ps2_clk_sync_1;
    end

    // Captura dados na borda negativa do ps2_clk sincronizado
    always_ff @(posedge clk) begin
        if (ps2_clk_sync_prev && !ps2_clk_sync_1) begin  // borda negativa detectada
            key_data[bit_count] <= ps2_data_sync_1;
            bit_count <= bit_count + 1;

            if (bit_count == 10) begin
                bit_count <= 0;

                // Processa scan_code e ações aqui
                scan_code = key_data[8:1];

                if (scan_code == 8'hF0) begin
                    break_code <= 1;
                end else begin
                    if (break_code) begin
                        // Tecla liberada
                        case (scan_code)
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
                        case (scan_code)
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
    end
endmodule
