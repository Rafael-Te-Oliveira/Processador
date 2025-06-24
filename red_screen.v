module red_screen (
    input wire clk,           
    input wire reset,         
    output reg [31:0] Draw_X,
    output reg [31:0] Draw_Y,
    output reg [31:0] Draw_Color,
    output reg Enable_Draw
);

    localparam FB_WIDTH = 160;
    localparam FB_HEIGHT = 120;
    localparam VR_WIDTH = 160;
    localparam VR_HEIGHT = 350;
    localparam FB_COLOR_BITS = 9;
    localparam FB_WORDS = 19200;
    localparam FB_ADDRW = 16;

    integer layer = 0;
    integer prev_layer;

    integer inicio_X = 0;
    integer inicio_Y = 0;
    integer final_X;
    integer final_Y;

    reg [9:0] VGA_X;
    reg [9:0] VGA_Y;

    reg [9:0] VGA_X_d;  // Valores atrasados
    reg [9:0] VGA_Y_d;

    wire [$clog2(VR_WIDTH)-1:0] FB_Read_X = VGA_X;
    wire [$clog2(VR_HEIGHT)-1:0] FB_Read_Y = VGA_Y;

    wire [FB_ADDRW:0] FB_Read_Calc_Address = ({1'b0, FB_Read_Y, 7'd0} + {1'b0, FB_Read_Y, 5'd0} + {1'b0, FB_Read_X});
    wire [FB_ADDRW-1:0] FB_Read_Address = FB_Read_Calc_Address[FB_ADDRW-1:0];

    wire [FB_COLOR_BITS-1:0] FB_Read_Data;

    // Controle de varredura e camadas
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            VGA_X <= 0;
            VGA_Y <= 0;
            layer <= 0;
            prev_layer <= 0;
        end else begin
            layer = layer % 5000;
				//layer = 5;
            case (layer)
                3'd0: begin
                    inicio_X = 1;
                    inicio_Y = 1;
                    final_X = 160;
                    final_Y = 120;
                end
                3'd1: begin
                    inicio_X = 40;
                    inicio_Y = 240;
                    final_X = 80;
                    final_Y = 273;
                end
                3'd2: begin
                    inicio_X = 81;
                    inicio_Y = 240;
                    final_X = 120;
                    final_Y = 273;
                end
                3'd3: begin
                    inicio_X = 1;
                    inicio_Y = 240;
                    final_X = 40;
                    final_Y = 273;
                end
                3'd4: begin
                    inicio_X = 1;
                    inicio_Y = 308;
                    final_X = 160;
                    final_Y = 320;
                end
                default: begin
                    inicio_X = 1;
                    inicio_Y = 308;
                    final_X = 160;
                    final_Y = 320;
                end
            endcase

            if (layer != prev_layer) begin
					  VGA_X <= inicio_X;
					  VGA_Y <= inicio_Y;
					  prev_layer <= layer;
				 end else if (VGA_X == final_X - 1) begin
					  VGA_X <= inicio_X;
					  if (VGA_Y == final_Y - 1) begin
							VGA_Y <= inicio_Y;
							layer <= layer + 1;
					  end else begin
							VGA_Y <= VGA_Y + 1;
					  end
				 end else begin
					  VGA_X <= VGA_X + 1;
				 end

        end
    end

    // Instância da VRAM
    VRAM VR(
        .address(FB_Read_Address),
        .clock(clk),
        .q(FB_Read_Data)
    );

    // Saída de desenho (sincronizada com o dado da VRAM)
    always @(posedge clk) begin
        // Atraso de 1 ciclo para alinhar com FB_Read_Data
        VGA_X_d <= VGA_X;
        VGA_Y_d <= VGA_Y;

        case (layer)
            3'd0: begin
                Draw_X <= VGA_X_d - inicio_X;
                Draw_Y <= VGA_Y_d - inicio_Y;
            end
            3'd1: begin
                Draw_X <= VGA_X_d - inicio_X + 87;
                Draw_Y <= VGA_Y_d - inicio_Y + 57;
            end
            3'd2: begin
                Draw_X <= VGA_X_d - inicio_X + 53;
                Draw_Y <= VGA_Y_d - inicio_Y + 61;
            end
            3'd3: begin
                Draw_X <= VGA_X_d - inicio_X + 72;
                Draw_Y <= VGA_Y_d - inicio_Y + 80;
            end
            3'd4: begin
                Draw_X <= VGA_X_d;
                Draw_Y <= VGA_Y_d - inicio_Y + 108;
            end
            default: begin
                Draw_X <= VGA_X_d;
                Draw_Y <= VGA_Y_d - inicio_Y + 108;
            end
        endcase

        Enable_Draw <= ~( &FB_Read_Data );
        Draw_Color <= FB_Read_Data;
    end

endmodule
