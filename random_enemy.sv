module random_enemy (
    input  logic trigger,
    input  logic reset,
	 input logic [7:0] ammo,
	 input logic [7:0] tm,
    output logic [1:0] rng
);

    logic [7:0] lfsr;

    always_ff @(posedge trigger or posedge reset) begin
        if (reset) begin
            lfsr <= 2'b01; // valor inicial não-nulo
        end else begin
            lfsr <= (ammo / 2 + tm / 3) % 3;
        end
    end

    assign rng = lfsr;
endmodule
