module switch_input (
    input  logic        clock,
    input  logic [17:0] entrada,
    input  logic        in,
    input  logic        out,
    input  logic        enter,
    output logic        sinal,
    output logic [17:0] valor
);

    logic flag_controle;

    always_ff @(posedge clock) begin
        // Reinicia o controle quando enter é liberado
        if (!enter) begin
            sinal         <= 1'b0;
            flag_controle <= 1'b0;
        end 
        // Entrada ativa
        else if (in && !flag_controle) begin
            valor         <= entrada;
            sinal         <= 1'b1;
            flag_controle <= 1'b1;
        end 
        // Saída ativa
        else if (out && !flag_controle) begin
            sinal         <= 1'b1;
            flag_controle <= 1'b1;
        end 
        else begin
            sinal <= 1'b0;
        end
    end

endmodule
