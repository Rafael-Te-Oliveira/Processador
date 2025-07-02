module control_unit (
    input  logic [31:0] instrucao,
    input  logic        sinal,
    output logic [2:0]  desvio,
    output logic        memReg,
    output logic [1:0]  opULA,
    output logic        escreveMem,
    output logic [1:0]  origULA,
    output logic        escreveReg,
    output logic [1:0]  ext,
    output logic        out,
    output logic        in,
    output logic        stop,
    output logic        jal,
    output logic        offset_register,
    output logic        lpc,
    output logic        spc,
    output logic        nextProgram,
    output logic        endProgram,
    output logic        defquantum,
    output logic        changeProgram
);

    typedef enum logic [5:0] {
        OP_R_TYPE       = 6'b000000, // aritmético lógico R-type
        OP_ADDI         = 6'b000001,
        OP_SUBI         = 6'b000010,
        OP_JUMP         = 6'b000011,
        OP_JR           = 6'b000100,
        OP_BEQ          = 6'b000101,
        OP_BNE          = 6'b000110,
        OP_BLT          = 6'b000111,
        OP_BGT          = 6'b001000,
        OP_BLE          = 6'b001001,
        OP_BGE          = 6'b001010,
        OP_LW           = 6'b001011,
        OP_SW           = 6'b001100,
        OP_JAL          = 6'b001101,
        OP_OUT          = 6'b001110,
        OP_IN           = 6'b001111,
        OP_NOP          = 6'b010000,
        OP_HALT         = 6'b010001,
        OP_LC           = 6'b101011,
        OP_SC           = 6'b101100,
        OP_LPC          = 6'b101111,
        OP_SPC          = 6'b100001,
        OP_NEXTPROG     = 6'b111111,
        OP_DEFQUANTUM   = 6'b111110,
        OP_CHANGEPROG   = 6'b111101
    } opcode_t;

    opcode_t opcode;

    always_comb begin
			opcode = opcode_t'(instrucao[31:26]);
			
        // Valores padrão (resets)
        desvio          = 3'b000;
        memReg          = 1'b0;
        escreveMem      = 1'b0;
        origULA         = 2'b00;
        escreveReg      = 1'b0;
        opULA           = 2'b00;
        ext             = 2'b00;
        out             = 1'b0;
        in              = 1'b0;
        stop            = 1'b0;
        jal             = 1'b0;
        offset_register = 1'b0;
        lpc             = 1'b0;
        spc             = 1'b0;
        endProgram      = 1'b0;
        nextProgram     = 1'b0;
        defquantum      = 1'b0;
        changeProgram   = 1'b0;

        unique case (opcode)
            OP_R_TYPE: begin
                escreveReg = 1'b1;
                opULA      = 2'b01;
            end
            OP_ADDI: begin
                origULA    = 2'b01;
                escreveReg = 1'b1;
                opULA      = 2'b11;
            end
            OP_SUBI: begin
                origULA    = 2'b01;
                escreveReg = 1'b1;
                opULA      = 2'b10;
            end
            OP_JUMP: begin
                desvio = 3'b001;
                ext    = 2'b01;
            end
            OP_JR: begin
                desvio = 3'b011;
                ext    = 2'b01;
            end
            OP_BEQ: begin
                desvio = 3'b010;
                origULA = 2'b10;
                opULA = 2'b10;
            end
            OP_BNE: begin
                desvio = 3'b100;
                origULA = 2'b10;
                opULA = 2'b10;
            end
            OP_BLT: begin
                desvio = 3'b101;
                origULA = 2'b10;
                opULA = 2'b11;
            end
            OP_BGT: begin
                desvio = 3'b101;
                origULA = 2'b10;
                opULA = 2'b10;
            end
            OP_BLE: begin
                desvio = 3'b110;
                origULA = 2'b10;
                opULA = 2'b11;
            end
            OP_BGE: begin
                desvio = 3'b110;
                origULA = 2'b10;
                opULA = 2'b10;
            end
            OP_LW: begin
                memReg = 1'b1;
                origULA = 2'b01;
                escreveReg = 1'b1;
                opULA = 2'b11;
            end
            OP_SW: begin
                escreveMem = 1'b1;
                origULA = 2'b01;
                opULA = 2'b11;
            end
            OP_JAL: begin
                desvio = 3'b001;
                ext = 2'b01;
                jal = 1'b1;
            end
            OP_OUT: begin
                if (!sinal) begin
                    stop = 1'b1;
                    out = 1'b1;
                end
            end
            OP_IN: begin
                escreveReg = 1'b1;
                case (sinal)
                    1'b0: begin
                        stop = 1'b1;
                        opULA = 2'b10;
                        in = 1'b1;
                    end
                    1'b1: begin
                        ext = 2'b10;
                        opULA = 2'b11;
                        origULA = 2'b01;
                    end
                endcase
            end
            OP_NOP: begin
                // no operation
            end
            OP_HALT: begin
                endProgram = 1'b1;
            end
            OP_LC: begin
                memReg = 1'b1;
                origULA = 2'b01;
                escreveReg = 1'b1;
                opULA = 2'b11;
                offset_register = 1'b1;
            end
            OP_SC: begin
                escreveMem = 1'b1;
                origULA = 2'b01;
                opULA = 2'b11;
                offset_register = 1'b1;
            end
            OP_LPC: begin
                lpc = 1'b1;
            end
            OP_SPC: begin
                spc = 1'b1;
            end
            OP_NEXTPROG: begin
                nextProgram = 1'b1;
            end
            OP_DEFQUANTUM: begin
                defquantum = 1'b1;
            end
            OP_CHANGEPROG: begin
                changeProgram = 1'b1;
            end
            default: begin
                // instrução desconhecida - valores default já aplicados
            end
        endcase
    end

endmodule
