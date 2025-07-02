module register_file  (
    input  logic [31:0] instrucao,
	 input  logic        clock,
    input  logic        escreveReg,
    input  logic [31:0] dados_escrita,
	 input  logic [31:0] endereco,
	 input  logic        jal,
    
    output logic [31:0] leRS,
    output logic [31:0] leRT,
    output logic [31:0] leRD
);

    logic [31:0] regs [31:0];

    initial begin
        for (int i = 0; i < 32; i++)
            regs[i] = 32'b0;
    end

    always_ff @(posedge clock) begin
        if (escreveReg)
            regs[instrucao[25:21]] <= dados_escrita;
        if (jal)
            regs[31] <= endereco + 1;
    end

    always_comb begin
        leRS = regs[instrucao[25:21]];
        leRT = regs[instrucao[20:16]];
        leRD = regs[instrucao[15:11]];
    end
endmodule
