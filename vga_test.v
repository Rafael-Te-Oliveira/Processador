module vga_test (
    input wire clk_25mhz,
    output wire hsync,
    output wire vsync,
    output wire [7:0] red,
    output wire [7:0] green,
    output wire [7:0] blue
);

    wire video_on;

    vga_sync syncgen (
        .clk(clk_25mhz),
        .hsync(hsync),
        .vsync(vsync),
        .video_on(video_on)
    );

	 assign red   = 8'b11111111;
    assign green = 8'b00000000;
    assign blue  = 8'b00000000;

endmodule
