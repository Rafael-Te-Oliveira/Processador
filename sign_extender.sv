module sign_extender (
    input  logic [31:0] instrucao,
    input  logic [17:0] valor,
    input  logic [1:0]  ext,
    output logic [31:0] imediato
);
    always_comb begin
        case (ext)
            2'b00: imediato = {{16{instrucao[15]}}, instrucao[15:0]}; // tipo I, sign-extend de 16 bits
            2'b01: imediato = {{6{instrucao[25]}}, instrucao[25:0]};  // tipo J, sign-extend de 26 bits
            2'b10: imediato = {{14{valor[17]}}, valor};               // input, sign-extend de 18 bits
            default: imediato = 32'b0;
        endcase
    end
endmodule
