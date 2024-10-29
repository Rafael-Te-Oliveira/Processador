module dados_RAM
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
    input [(DATA_WIDTH-1):0] data,
    input [(ADDR_WIDTH-1):0] endereco_leitura, endereco_escrita,
    input we, read_clock, write_clock, 
	 //set_offset,
    output reg [(DATA_WIDTH-1):0] q
	 // Additional register to store offset
    //output reg [(DATA_WIDTH-1):0] offset_value
);
    
    // Declare the RAM variable
    reg [DATA_WIDTH-1:0] ram[2048];

    
	 
	 
    
    always @ (posedge write_clock) begin
        // Write with offset adjustment
        if (we) begin
              ram[endereco_escrita] <= data;
        end
    end
    
    always @ (posedge read_clock) begin
			//if (set_offset) begin
         //   offset_value <= endereco_leitura;
			//end
         q <= ram[endereco_leitura];
      
    end
    
endmodule


