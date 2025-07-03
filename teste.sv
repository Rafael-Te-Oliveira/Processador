module teste (
    input logic clock,
    input logic enter_n,
    input logic reset_n,
    input logic [17:0] entrada,
    input logic ps2_clk,
    input logic ps2_data,
    output logic [6:0] seg [7:0],
    output logic [3:0] ledr,
    output logic hsync,
    output logic vsync,
    output logic [7:0] red,
    output logic [7:0] green,
    output logic [7:0] blue,
    output logic vga_blank,
    output logic vga_clock,
    output logic vga_sync
);

    logic enter;
	 assign enter = !enter_n;
    logic reset;
	 assign reset = !reset_n;
		
    logic [17:0] valor;
    logic sinal;
    logic [31:0] saida;
    logic [31:0] segmentos;
    logic [31:0] instrucao;
    logic [31:0] endereco;
    logic [1:0] opULA;
    logic regDst;
    logic [2:0] desvio;
    logic memReg;
    logic escreveMem;
    logic [1:0] origULA;
    logic escreveReg;
    logic [1:0] ext;
    logic out;
    logic in;
    logic stop;
    logic jal;
    logic [31:0] leRS;
    logic [31:0] leRT;
    logic [31:0] leRD;
    logic [31:0] imediato;
    logic [2:0] selec;
    logic [31:0] result;
    logic zero;
    logic negativo;
    logic [31:0] dadosLidos;
    logic [31:0] dados;
    logic neg;
    logic divclock;
    logic depclock;
    logic offset_register;
    logic spc;
    logic [31:0] enderecoSpc;
    logic lpc;
    logic endProgram;
    logic nextProgram;
    logic [31:0] segmentosPrograma;
    logic defquantum;
    logic changeProgram;
    logic acoes [0:5];
    logic [31:0] draw_x;
    logic [31:0] draw_y;
    logic [31:0] draw_color;
    logic enable_draw;
    logic enter_sync, reset_sync;
    logic acoes_sync [0:5];

    synchronizer sync_inst (
        .clk         (clock),
        .enter       (enter),
        .reset       (reset),
        .acoes       (acoes),
        .enter_sync  (enter_sync),
        .reset_sync  (reset_sync),
        .acoes_sync  (acoes_sync)
    );

    clock_divider clock_divider_inst (
        .fast_clock  (clock),
        .reset       (reset_sync),
        .slow_clock  (divclock),
        .dep_clock   (depclock),
        .ledr        (ledr)
    );

    program_counter program_counter_inst (
        .changeProgram (changeProgram),
        .defquantum    (defquantum),
        .lpc           (lpc),
        .enderecoPc    (dadosLidos),
        .endProgram    (endProgram),
        .novoEnd       (imediato),
        .novoEndR      (result),
        .desvio        (desvio),
        .zero          (zero),
        .negativo      (negativo),
        .clock         (divclock),
        .endereco      (endereco),
        .stop          (stop),
        .reset         (reset_sync),
        .enderecoSpc   (enderecoSpc)
    );

    switch_input switch_input_inst (
        .clock   (divclock),
        .entrada (entrada),
        .in      (in),
        .out     (out),
        .enter   (enter_sync),
        .sinal   (sinal),
        .valor   (valor)
    );

    rom_instructions rom_instructions_inst (
        .addr   (endereco),
        .clk     (clock),
        .q  (instrucao)
    );

    control_unit control_unit_inst (
        .instrucao      (instrucao),
        .sinal          (sinal),
        .desvio         (desvio),
        .memReg         (memReg),
        .opULA          (opULA),
        .escreveMem     (escreveMem),
        .origULA        (origULA),
        .escreveReg     (escreveReg),
        .ext            (ext),
        .out            (out),
        .in             (in),
        .stop           (stop),
        .jal            (jal),
        .offset_register(offset_register),
        .lpc            (lpc),
        .spc            (spc),
        .nextProgram    (nextProgram),
        .endProgram     (endProgram),
        .defquantum     (defquantum),
        .changeProgram  (changeProgram)
    );

    register_file register_file_inst (
        .instrucao   (instrucao),
        .clock         (divclock),
        .escreveReg  (escreveReg),
        .dados_escrita       (dados),
        .endereco    (endereco),
        .jal         (jal),
        .leRS        (leRS),
        .leRT        (leRT),
        .leRD        (leRD)
    );

    sign_extender sign_extender_inst (
        .instrucao (instrucao),
        .valor   (valor),
        .ext       (ext),
        .imediato     (imediato)
    );

    ula_control ula_control_inst (
        .instrucao (instrucao),
        .opULA        (opULA),
        .selec     (selec)
    );

    ula ula_inst (
        .selec        (selec),
        .RS        (leRS),
        .RT        (leRT),
        .RD        (leRD),
        .IMED  (imediato),
        .origULA   (origULA),
        .result     (result),
        .zero      (zero),
        .negativo  (negativo)
    );

    ram_data ram_data_inst (
        .data     (leRS),
        .endereco_leitura  (result),
        .endereco_escrita  (result),
        .we   (escreveMem),
        .read_clock         (clock),
        .write_clock     (divclock),
        .offset_register  (offset_register),
        .spc         (spc),
        .lpc         (lpc),
        .nextProgram (nextProgram),
        .changeProgram  (changeProgram),
        .enderecoSpc (enderecoSpc),
        .endProgram  (endProgram),
        .q     (dadosLidos)
    );

    mux_mem mux_mem_inst (
        .dadosLidos (dadosLidos),
        .result   (result),
        .memReg   (memReg),
        .saida    (dados)
    );

    data_output data_output_inst (
        .clock              (divclock),
        .dados            (dados),
        .endereco         (endereco),
        .entrada          (entrada),
        .out              (out),
        .in               (in),
        .saida            (saida),
        .segmentos        (segmentos),
        .segmentosPrograma(segmentosPrograma),
        .neg              (neg)
    );

    display7seg display7seg_inst (
        .segmentos         (segmentos),
        .segmentosPrograma (segmentosPrograma),
        .neg               (neg),
        .seg               (seg)
    );

    red_screen rs (
        .clk         (clock),
        .reset       (reset_sync),
        .acoes       (acoes_sync),
        .Draw_X      (draw_x),
        .Draw_Y      (draw_y),
        .Draw_Color  (draw_color),
        .Enable_Draw (enable_draw)
    );

    vga_test inst_vga_test (
        .Fast_Clock    (clock),
        .Slow_Clock    (depclock),
        .Reset         (reset_sync),
        .VGA_HS        (hsync),
        .VGA_VS        (vsync),
        .VGA_Clk       (vga_clock),
        .VGA_Red       (red),
        .VGA_Green     (green),
        .VGA_Blue      (blue),
        .VGA_Blank_N   (vga_blank),
        .VGA_Sync_N    (vga_sync),
        .Enable_Draw   (enable_draw),
        .Draw_X        (draw_x),
        .Draw_Y        (draw_y),
        .Draw_Color    (draw_color)
    );

    ps2_receiver PS2 (
        .ps2_clk   (ps2_clk),
        .ps2_data  (ps2_data),
        .acoes     (acoes)
    );

endmodule
