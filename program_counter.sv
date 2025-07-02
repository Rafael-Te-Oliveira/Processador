module program_counter (
    input  logic         changeProgram,
    input  logic         defquantum,
    input  logic         lpc,
    input  logic [31:0]  enderecoPc,
    input  logic         endProgram,
    input  logic [31:0]  novoEnd,
    input  logic [31:0]  novoEndR,
    input  logic [2:0]   desvio,
    input  logic         zero,
    input  logic         negativo,
    input  logic         clock,
    input  logic         stop,
    input  logic         reset,
    output logic [31:0]  endereco,
    output logic [31:0]  enderecoSpc
);

    // === Parâmetros ===
    parameter int BASE_OFFSET   = 200;
    parameter int END_INIT_ADDR = 199;

    // === Registradores internos ===
    logic [31:0] quantum     = 0;
    logic [31:0] execProgram = 1;
    logic [31:0] offset      = 0;
    logic [31:0] instNum     = 0;
    logic [31:0]  programa    = 1;

    // === Inicialização ===
    initial begin
        endereco     = END_INIT_ADDR;
        enderecoSpc  = 0;
    end

    // === Lógica Sequencial ===
    always_ff @(posedge clock) begin

        // Reset
        if (reset) begin
            endereco <= END_INIT_ADDR;
            instNum  <= 0;
            execProgram <= 1;
            programa <= 1;
            offset <= 0;
            enderecoSpc <= 0;
        end else begin
            // Atualiza quantum
            if (defquantum) begin
                quantum <= novoEndR;
            end

            // Atualiza programa em execução
            if (lpc) begin
                programa = execProgram;
            end

            // Calcula offset
            offset = programa * BASE_OFFSET;

            // Controle principal
            if (!stop) begin
                // Troca de programa
                if (((instNum >= quantum && programa != 0 && programa != 1) || endProgram || changeProgram) && desvio == 3'b000) begin
                    enderecoSpc <= (endProgram) ? endereco : endereco + 1;

                    execProgram <= (changeProgram) ? novoEndR + 1 : 1;
                    endereco    <= 0;
                    instNum     <= 0;
                    programa    <= 0;

                end else begin
                    // Contador de instruções
                    if (programa != 0) begin
                        instNum <= instNum + 1;
                    end

                    // Lógica de desvio ou incremento
                    if (lpc) begin
                        endereco <= enderecoPc + offset;
                    end else begin
                        unique case (desvio)
                            3'b000: endereco <= endereco + 1;
                            3'b001: endereco <= novoEnd + offset;
                            3'b010: endereco <= (zero)            ? novoEnd + offset : endereco + 1;
                            3'b100: endereco <= (!zero)           ? novoEnd + offset : endereco + 1;
                            3'b101: endereco <= (negativo)        ? novoEnd + offset : endereco + 1;
                            3'b110: endereco <= (negativo || zero)? novoEnd + offset : endereco + 1;
                            3'b011: endereco <= novoEndR;
                            default: endereco <= endereco + 1;
                        endcase
                    end
                end
            end
        end
    end

endmodule
