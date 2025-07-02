module vga_sync_old
(
	input Fast_Clock,
	input Reset,
	output reg VGA_HS,
	output reg VGA_VS,
	output reg VGA_Clk,
	output reg [9:0] Counter_X, //Horizontal
	output reg [9:0] Counter_Y,	//Vertical
	output reg VGA_Blank_N,
	output VGA_Sync_N
);

localparam VERT_VISIBLE_PIXELS = 10'd480;
localparam VERT_SYNC_START = 10'd493;
localparam VERT_SYNC_END = 10'd494; //(VERT_SYNC_START + 2 - 1);
localparam VERT_TOTAL_PIXELS = 10'd525;

localparam HORZ_VISIBLE_PIXELS = 10'd640;
localparam HORZ_SYNC_START = 10'd659;
localparam HORZ_SYNC_END = 10'd754; //(HORZ_SYNC_START + 96 - 1);
localparam HORZ_TOTAL_PIXELS = 10'd800;

reg VGA_HS_D1;
reg VGA_VS_D1;
reg VGA_Blank_D1;
wire Counter_X_Clear;
wire Counter_Y_Clear;

initial
begin
	Counter_X <= 10'b0;
	Counter_Y <= 10'b0;
end

wire vga_clk_wire;

vga_pll vga_pll
(
	.inclk0(Fast_Clock),
	.c0(vga_clk_wire)
);

always @(*) begin
	VGA_Clk = vga_clk_wire;
end

assign VGA_Sync_N = 1'b1; //Should be tied to 1
assign Counter_X_Clear = (Counter_X == (HORZ_TOTAL_PIXELS-1));
assign Counter_Y_Clear = (Counter_Y == (VERT_TOTAL_PIXELS-1));

//--------------------------------------------------------

always @(posedge VGA_Clk or posedge Reset)
begin
	if (Reset)
		Counter_X <= 10'd0;
	else if (Counter_X_Clear)
		Counter_X <= 10'd0;
	else
	begin
		Counter_X <= Counter_X + 1'b1;
	end
end

always @(posedge VGA_Clk or posedge Reset)
begin
	if (Reset)
		Counter_Y <= 10'd0;
	else if (Counter_X_Clear && Counter_Y_Clear)
		Counter_Y <= 10'd0;
	else if (Counter_X_Clear) //Increment when x counter resets
		Counter_Y <= Counter_Y + 1'b1;
end

always @(posedge VGA_Clk)
begin
	//- Sync Generator (ACTIVE LOW)
	VGA_HS_D1 <= ~((Counter_X >= HORZ_SYNC_START) && (Counter_X <= HORZ_SYNC_END));
	VGA_VS_D1 <= ~((Counter_Y >= VERT_SYNC_START) && (Counter_Y <= VERT_SYNC_END));

	//- Current X and Y is valid pixel range
	VGA_Blank_D1 <= ((Counter_X < HORZ_VISIBLE_PIXELS) && (Counter_Y < VERT_VISIBLE_PIXELS));

	//- Add 1 cycle delay
	VGA_HS <= VGA_HS_D1;
	VGA_VS <= VGA_VS_D1;
	VGA_Blank_N <= VGA_Blank_D1;
end

endmodule