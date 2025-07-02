module ULA (
    input  logic [2:0]  selec,
    input  logic [31:0] RS, RT, RD, IMED,
    input  logic [1:0]  origULA,
    output logic [31:0] result,
    output logic        zero,
    output logic        negativo
);

    always_comb begin
        result = 32'b0; // valor padrão para evitar latch

        case (origULA)
            2'b00: begin // tipo R
                case (selec)
                    3'b000: result = RS;
                    3'b001: result = RT + RD;
                    3'b010: result = RT - RD;
                    3'b011: result = RT * RD;
                    3'b100: result = (RD != 0) ? RT / RD : 32'b0; // proteção contra divisão por zero
                    3'b101: result = RT & RD;
                    3'b110: result = RT | RD;
                    3'b111: result = -RT;
                    default: result = 32'b0;
                endcase
            end

            2'b01: begin // tipo I
                case (selec)
                    3'b001: result = RT + IMED; // addi
                    3'b010: result = RT - IMED; // subi
                    default: result = 32'b0;
                endcase
            end

            2'b10: begin // comparações
                case (selec)
                    3'b001: result = RS - RT; // blt
                    3'b010: result = RT - RS; // bgt
                    default: result = 32'b0;
                endcase
            end

            default: result = 32'b0;
        endcase
    end

    assign negativo = result[31];
    assign zero = (result == 32'b0);

endmodule
