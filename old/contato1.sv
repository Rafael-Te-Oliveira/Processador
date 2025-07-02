module contato1 (
    input  logic        CLOCK_50,
    output logic [3:0]  LEDR,
	 input  logic        reset,
    output logic        divclock,
    output logic        depclock
);

    logic [27:0] count;

    always_ff @(posedge CLOCK_50 or posedge reset) begin
        if (reset)
            count <= 28'd0;
        else
            count <= count + 1;
    end

    assign LEDR     = count[27:24];
    assign divclock = count[5];   // Clock dividido (normal)
    assign depclock = count[15];  // Clock de depuração

endmodule
