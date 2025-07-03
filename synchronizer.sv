module synchronizer (
    input  wire clk,
    input  wire enter,
    input  wire reset,
    input  wire acoes [0:5],

    output logic enter_sync,
    output logic reset_sync,
    output logic acoes_sync [0:5]
);

    // Etapas intermediárias para sincronização
    logic enter_sync_0, reset_sync_0;
    logic acoes_sync_0 [0:5];

    always_ff @(posedge clk) begin
        // Primeira etapa
        enter_sync_0 <= enter;
        reset_sync_0 <= reset;
        acoes_sync_0 <= acoes;

        // Segunda etapa
        enter_sync   <= enter_sync_0;
        reset_sync   <= reset_sync_0;
        acoes_sync   <= acoes_sync_0;
    end

endmodule
