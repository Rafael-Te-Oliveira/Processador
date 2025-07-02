module contato1(CLOCK_50, LEDR, Key, divclock, depclock);

input CLOCK_50;
input Key;

output [3:0]LEDR;
output divclock;
output depclock;

reg [27:0]count;
wire reset_n;

assign reset_n = Key;

always@(posedge CLOCK_50 or negedge reset_n)
begin
    if (~reset_n)
      count = 0;
    else
      count = count + 1;
  end
  
  assign LEDR = count[27:24];
  assign divclock = count[5]; //normal
  assign depclock = count[15]; //depuracao
  
endmodule