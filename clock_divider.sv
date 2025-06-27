module clock_divider (
    input  logic clock_50,           
    input  logic reset,         
    output logic [3:0] led_clock,   
    output logic clock_25,     
    output logic clock_slow      
);

    logic [27:0] counter;

    // Contador com reset assíncrono
    always_ff @(posedge clock_50 or posedge reset) begin
        if (reset)
            counter <= 28'd0;
        else
            counter <= counter + 1;
    end

    // Atribuição dos sinais de saída
    assign led_out = counter[27:24];
    assign clock_25  = counter[0];
    assign clock_slow  = counter[15];

endmodule
