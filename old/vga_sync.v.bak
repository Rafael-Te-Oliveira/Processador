module vga_sync (
    input wire clk,       // 25MHz
    output reg hsync,
    output reg vsync,
    output reg video_on
);

    reg [9:0] h_count = 0;
    reg [9:0] v_count = 0;

    // Contador horizontal
    always @(posedge clk) begin
        if (h_count == 799) begin
            h_count <= 0;
            if (v_count == 524)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end else begin
            h_count <= h_count + 1;
        end
    end

    // Geração dos pulsos de sincronismo e sinal de vídeo ativo
    always @(*) begin
        hsync = ~(h_count >= 656 && h_count < 752);
        vsync = ~(v_count >= 490 && v_count < 492);
        video_on = (h_count < 640) && (v_count < 480);
    end
endmodule
