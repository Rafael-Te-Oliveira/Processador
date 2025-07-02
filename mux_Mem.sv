module mux_Mem (
    input  logic [31:0] dadosLidos,
    input  logic [31:0] result,
    input  logic        memReg,
    output logic [31:0] saida
);

    always_comb begin
        if (memReg)
            saida = dadosLidos;
        else
            saida = result;
    end

endmodule
