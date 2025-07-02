module red_screen (
    input logic clk,     
    input logic reset, 
	 input logic [5:0] acoes,
    output logic [31:0] Draw_X,
    output logic [31:0] Draw_Y,
    output logic [31:0] Draw_Color,
    output logic Enable_Draw
);

    localparam FB_WIDTH = 160;
    localparam FB_HEIGHT = 120;
    localparam VR_WIDTH = 160;
    localparam VR_HEIGHT = 350;
    localparam FB_COLOR_BITS = 9;
    localparam FB_WORDS = 19200;
    localparam FB_ADDRW = 16;

    logic [32:0] layer = 0;
    logic [32:0] prev_layer = -1;

    // Wires dos offsets vindos do módulo externo
    wire [9:0] inicio_X_wire;
    wire [9:0] inicio_Y_wire;
    wire [9:0] final_X_wire;
    wire [9:0] final_Y_wire;
	 wire [9:0] FB_X_wire;
    wire [9:0] FB_Y_wire;

    // Coordenadas VGA
    logic [9:0] VGA_X;
    logic [9:0] VGA_Y;

    // Atraso de 1 ciclo para alinhar com leitura da VRAM
    logic [9:0] VGA_X_d = 0;
    logic [9:0] VGA_Y_d = 0; 
	 logic [9:0] inicio_X_d = 0;
	 logic [9:0] inicio_Y_d = 0;
	 logic [9:0] FB_X_d = 0;
    logic [9:0] FB_Y_d = 0;


    // Cálculo de endereço da VRAM
    wire [$clog2(VR_WIDTH)-1:0] FB_Read_X = VGA_X;
    wire [$clog2(VR_HEIGHT)-1:0] FB_Read_Y = VGA_Y;

    wire [FB_ADDRW:0] FB_Read_Calc_Address = 
        ({1'b0, FB_Read_Y, 7'd0} + {1'b0, FB_Read_Y, 5'd0} + {1'b0, FB_Read_X});
    wire [FB_ADDRW-1:0] FB_Read_Address = FB_Read_Calc_Address[FB_ADDRW-1:0];

    wire [FB_COLOR_BITS-1:0] FB_Read_Data;

    // Instância da ROM de offsets
    game_process game_process (
        .clk(clk),
		  .reset(reset),
		  .layer(layer[32:0]),
		  .acoes(acoes[5:0]),
        .vram_inicio_X(inicio_X_wire),
        .vram_inicio_Y(inicio_Y_wire),
        .vram_final_X(final_X_wire),
        .vram_final_Y(final_Y_wire),
		  .FB_X(FB_X_wire),
        .FB_Y(FB_Y_wire)
    );

    // Controle de varredura e camadas
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            VGA_X <= 0;
            VGA_Y <= 0;
            layer <= 0;
            prev_layer <= -1;
        end else begin
         
            if (layer != prev_layer) begin
                VGA_X <= inicio_X_wire;
                VGA_Y <= inicio_Y_wire;
                prev_layer <= layer;
            end else if (VGA_X >= final_X_wire) begin
                VGA_X <= inicio_X_wire;
                if (VGA_Y >= final_Y_wire) begin
                    VGA_Y <= inicio_Y_wire;
						 layer <= (layer + 1) % 20000;
                end else begin
                    VGA_Y <= VGA_Y + 1;
                end
            end else begin
                VGA_X <= VGA_X + 1;
            end
        end
    end

    // Instância da VRAM
    VRAM VR (
        .address(FB_Read_Address),
        .clock(clk),
        .q(FB_Read_Data)
    );

	always @(posedge clk) begin
		 Draw_X <= VGA_X_d - inicio_X_wire + FB_X_wire;
		 Draw_Y <= VGA_Y_d - inicio_Y_wire + FB_Y_wire;
		 
		 Enable_Draw <= ~( &FB_Read_Data );
		 Draw_Color <= FB_Read_Data;
		 
		 VGA_X_d <= VGA_X;
		 VGA_Y_d <= VGA_Y;
	end

endmodule
