module display7seg (
    input  [31:0] segmentos,
    input  [31:0] segmentosPrograma,
    input  neg,
    output reg [6:0] seg [7:0]
);

    always @(*) begin
        // Segmentos principais (seg[0] até seg[5])
        seg[0] = decodifica(segmentos[3:0]);
        seg[1] = decodifica(segmentos[7:4]);
        seg[2] = decodifica(segmentos[11:8]);
        seg[3] = decodifica(segmentos[15:12]);
        seg[4] = decodifica(segmentos[19:16]);
        seg[5] = decodifica(segmentos[23:20]);

        // Programa (seg[6] e seg[7])
        case ({segmentosPrograma[15:12], segmentosPrograma[11:8]})
            8'b00000000, 8'b00000001: begin seg[6] = 7'b1000000; seg[7] = 7'b1111111; end // 0
            8'b00000010, 8'b00000011: begin seg[6] = 7'b1000000; seg[7] = 7'b1111111; end
            8'b00000100, 8'b00000101: begin seg[6] = 7'b1111001; seg[7] = 7'b1111111; end // 1
            8'b00000110, 8'b00000111: begin seg[6] = 7'b0100100; seg[7] = 7'b1111111; end // 2
            8'b00001000, 8'b00001001: begin seg[6] = 7'b0110000; seg[7] = 7'b1111111; end // 3
            8'b00010000, 8'b00010001: begin seg[6] = 7'b0011001; seg[7] = 7'b1111111; end // 4
            8'b00010010, 8'b00010011: begin seg[6] = 7'b0010010; seg[7] = 7'b1111111; end // 5
            8'b00010100, 8'b00010101: begin seg[6] = 7'b0000010; seg[7] = 7'b1111111; end // 6
            8'b00010110, 8'b00010111: begin seg[6] = 7'b1111000; seg[7] = 7'b1111111; end // 7
            8'b00011000, 8'b00011001: begin seg[6] = 7'b0000000; seg[7] = 7'b1111111; end // 8
            default: begin seg[6] = 7'b1111111; seg[7] = 7'b1111111; end
        endcase

        // Negativo
        if (neg)
            seg[7] = 7'b0111111; // Sinal de "-"
    end

    // Função para converter nibble → 7 segmentos
    function [6:0] decodifica(input [3:0] nibble);
        case (nibble)
            4'h0: decodifica = 7'b1000000;
            4'h1: decodifica = 7'b1111001;
            4'h2: decodifica = 7'b0100100;
            4'h3: decodifica = 7'b0110000;
            4'h4: decodifica = 7'b0011001;
            4'h5: decodifica = 7'b0010010;
            4'h6: decodifica = 7'b0000010;
            4'h7: decodifica = 7'b1111000;
            4'h8: decodifica = 7'b0000000;
            4'h9: decodifica = 7'b0011000;
            default: decodifica = 7'b1111111; // segmento apagado
        endcase
    endfunction

endmodule
