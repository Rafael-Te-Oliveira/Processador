module cpu (
    input logic clock_50,
    input logic enter_n,
    input logic reset_n,
    input logic [17:0] entrada,
    input logic ps2_clock,
    input logic ps2_data,

    output logic [6:0] seg [7:0],
    output logic [3:0] led_clock,

    output logic vga_hs,
    output logic vga_vs,
    output logic [7:0] vga_red,
    output logic [7:0] vga_green,
    output logic [7:0] vga_blue,
    output logic vga_blank_n,
    output logic vga_clock,
    output logic vga_sync_n
);

    // --- Reset e sinais de controle ---
    logic reset;
	 assign reset = ~reset_n;

    logic enter;
	 assign enter = ~enter_n;

    // --- Clock ---
    logic clock_25;
    logic clock_slow;

    // --- PS2 ---
    logic scan_code;
    logic scan_ready;
    logic [5:0] acoes;

    // --- VGA Draw ---
    logic [31:0] draw_x, draw_y, draw_color;
    logic draw_en;

    // --- Pipeline / CPU signals ---
    logic [17:0] valor;
    logic sinal;
    logic [31:0] saida, segmentos, segmentosPrograma;
    logic [31:0] instrucao, endereco, imediato;
    logic [31:0] leRS, leRT, leRD;
    logic [1:0] opULA, origULA, ext;
    logic [2:0] desvio, selec;
    logic regDst, memReg, escreveMem, escreveReg;
    logic out, in, stop, jal;
    logic zero, negativo, neg;
    logic [31:0] dadosLidos, dados;
    logic offset_register, spc, lpc;
    logic endProgram, nextProgram, defquantum, changeProgram;
    logic [31:0] enderecoSpc;

    // --- Clock Divider ---
    clock_divider clock_div_main (
        .clock_50(clock_50),
        .reset(reset),
        .led_clock(led_clock),
        .clock_25(clock_25),
        .clock_slow(clock_slow)
    );

    // --- PS2 Receiver ---
    ps2_receiver ps2 (
        .ps2_clock(ps2_clock),
        .ps2_data(ps2_data),
        .scan_code(scan_code),
        .scan_ready(scan_ready),
        .acoes(acoes)
    );

    // --- Program Counter ---
    program_counter PC(changeProgram, defquantum, lpc, dadosLidos, endProgram, imediato, result, desvio, zero, negativo, divclock, endereco, stop, reset, enderecoSpc);


    // --- Entrada de dados ---
    entradaDados entrada(divclock, entrada, in, out, enter, sinal, valor);

    // --- Memória de instruções ---
    instrucoes_RAM INST (
        .endereco(endereco),
        .instruction(instrucao),
        .write_clock(clock_50),
        .read_clock(clock_25)
    );

    // --- Unidade de Controle ---
    UC UC (
        .instrucao(instrucao),
        .clock(clock_25),
        .sinal(sinal),
        .desvio(desvio),
        .memReg(memReg),
        .opULA(opULA),
        .escreveMem(escreveMem),
        .origULA(origULA),
        .escreveReg(escreveReg),
        .ext(ext),
        .out(out),
        .in(in),
        .stop(stop),
        .jal(jal),
        .offset_register(offset_register),
        .lpc(lpc),
        .spc(spc),
        .nextProgram(nextProgram),
        .endProgram(endProgram),
        .defquantum(defquantum),
        .changeProgram(changeProgram)
    );

    // --- Banco de registradores ---
    BancoRegistradores BR (
        .instrucao(instrucao),
        .clock(clock_25),
        .escreveReg(escreveReg),
        .dados_escrita(dados),
        .endereco(endereco),
        .jal(jal),
        .leRS(leRS),
        .leRT(leRT),
        .leRD(leRD)
    );

    // --- Extensor de bits ---
    extensor_Bit BIT (
        .instrucao(instrucao),
        .valor(valor),
        .ext(ext),
        .imediato(imediato)
    );

    // --- Controle da ULA ---
    controle_ULA cULA (
        .instrucao(instrucao),
        .opULA(opULA),
        .selec(selec)
    );

    // --- ULA ---
    ULA ula_inst (
        .selec(selec),
        .RS(leRS),
        .RT(leRT),
        .RD(leRD),
        .IMED(imediato),
        .origULA(origULA),
        .result(result),
        .zero(zero),
        .negativo(negativo)
    );

    // --- Memória de dados ---
    dados_RAM DADO (
        .data(leRS),
        .endereco_leitura(result),
        .endereco_escrita(result),
        .we(escreveMem),
        .read_clock(clock_50),
        .write_clock(clock_25),
        .offset_register(offset_register),
        .spc(spc),
        .lpc(lpc),
        .nextProgram(nextProgram),
        .changeProgram(changeProgram),
        .enderecoSpc(enderecoSpc),
        .endProgram(endProgram),
        .acoes(acoes),
        .q(dadosLidos)
    );

    // --- Mux de memória ---
    mux_Mem MUX (
        .dadosLidos(dadosLidos),
        .result(result),
        .memReg(memReg),
        .saida(saida)
    );

    // --- Saída de dados ---
    saidaDados saida_dados (
        .clock(clock_25),
        .dados(dados),
        .endereco(endereco),
        .entrada(entrada),
        .out(out),
        .in(in),
        .saida(saida),
        .segmentos(segmentos),
        .segmentosPrograma(segmentosPrograma),
        .neg(neg)
    );

    // --- Display 7 segmentos ---
    display7seg Display (
        .segmentos(segmentos),
        .segmentosPrograma(segmentosPrograma),
        .neg(neg),
        .seg(seg)
    );

    // --- Tela vermelha (red screen) ---
    red_screen rs (
        .clock(clock_50),
        .reset(reset),
        .acoes(acoes),
        .draw_x(draw_x),
        .draw_y(draw_y),
        .draw_color(draw_color),
        .draw_en(draw_en)
    );

    // --- Controlador VGA ---
    vga_test inst_vga_test (
        .fast_clock(clock_50),
        .reset(reset),
        .vga_hs(vga_hs),
        .vga_vs(vga_vs),
        .vga_clock(vga_clock),
        .vga_red(vga_red),
        .vga_green(vga_green),
        .vga_blue(vga_blue),
        .vga_blank_n(vga_blank_n),
        .vga_sync_n(vga_sync_n),
        .draw_en(draw_en),
        .draw_x(draw_x),
        .draw_y(draw_y),
        .draw_color(draw_color)
    );

endmodule
