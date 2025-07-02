module display7seg (segmentos, segmentosPrograma, neg, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);

	input[31:0] segmentos;
	input[31:0] segmentosPrograma;
	input neg;
	
	output reg[6:0] seg0;
	output reg[6:0] seg1;
	output reg[6:0] seg2;
	output reg[6:0] seg3;
	output reg[6:0] seg4;
	output reg[6:0] seg5;
	output reg[6:0] seg6;
	output reg[6:0] seg7;
	
	always @ (*) begin
		case (segmentos[3:0])
			4'b0000: seg0 = 7'b1000000;
			4'b0001: seg0 = 7'b1111001;
			4'b0010: seg0 = 7'b0100100;
			4'b0011: seg0 = 7'b0110000;
			4'b0100: seg0 = 7'b0011001;
			4'b0101: seg0 = 7'b0010010;
			4'b0110: seg0 = 7'b0000010;
			4'b0111: seg0 = 7'b1111000;
			4'b1000: seg0 = 7'b0000000;
			4'b1001: seg0 = 7'b0011000;
			4'bxxxx: seg0 = 7'b1111111;
			default: seg0 = 7'b1111111;
		endcase
		case (segmentos[7:4])
			4'b0000: seg1 = 7'b1000000;
			4'b0001: seg1 = 7'b1111001;
			4'b0010: seg1 = 7'b0100100;
			4'b0011: seg1 = 7'b0110000;
			4'b0100: seg1 = 7'b0011001;
			4'b0101: seg1 = 7'b0010010;
			4'b0110: seg1 = 7'b0000010;
			4'b0111: seg1 = 7'b1111000;
			4'b1000: seg1 = 7'b0000000;
			4'b1001: seg1 = 7'b0011000;
			4'bxxxx: seg1 = 7'b1111111;
			default: seg1 = 7'b1111111;
		endcase
		case (segmentos[11:8])
			4'b0000: seg2 = 7'b1000000;
			4'b0001: seg2 = 7'b1111001;
			4'b0010: seg2 = 7'b0100100;
			4'b0011: seg2 = 7'b0110000;
			4'b0100: seg2 = 7'b0011001;
			4'b0101: seg2 = 7'b0010010;
			4'b0110: seg2 = 7'b0000010;
			4'b0111: seg2 = 7'b1111000;
			4'b1000: seg2 = 7'b0000000;
			4'b1001: seg2 = 7'b0011000;
			4'bxxxx: seg2 = 7'b1111111;
			default: seg2 = 7'b1111111;
		endcase
		case (segmentos[15:12])
			4'b0000: seg3 = 7'b1000000;
			4'b0001: seg3 = 7'b1111001;
			4'b0010: seg3 = 7'b0100100;
			4'b0011: seg3 = 7'b0110000;
			4'b0100: seg3 = 7'b0011001;
			4'b0101: seg3 = 7'b0010010;
			4'b0110: seg3 = 7'b0000010;
			4'b0111: seg3 = 7'b1111000;
			4'b1000: seg3 = 7'b0000000;
			4'b1001: seg3 = 7'b0011000;
			4'bxxxx: seg3 = 7'b1111111;
			default: seg3 = 7'b1111111;
		endcase
		case (segmentos[19:16])
			4'b0000: seg4 = 7'b1000000;
			4'b0001: seg4 = 7'b1111001;
			4'b0010: seg4 = 7'b0100100;
			4'b0011: seg4 = 7'b0110000;
			4'b0100: seg4 = 7'b0011001;
			4'b0101: seg4 = 7'b0010010;
			4'b0110: seg4 = 7'b0000010;
			4'b0111: seg4 = 7'b1111000;
			4'b1000: seg4 = 7'b0000000;
			4'b1001: seg4 = 7'b0011000;
			4'bxxxx: seg4 = 7'b1111111;
			default: seg4 = 7'b1111111;
		endcase
		case (segmentos[23:20])
			4'b0000: seg5 = 7'b1000000;
			4'b0001: seg5 = 7'b1111001;
			4'b0010: seg5 = 7'b0100100;
			4'b0011: seg5 = 7'b0110000;
			4'b0100: seg5 = 7'b0011001;
			4'b0101: seg5 = 7'b0010010;
			4'b0110: seg5 = 7'b0000010;
			4'b0111: seg5 = 7'b1111000;
			4'b1000: seg5 = 7'b0000000;
			4'b1001: seg5 = 7'b0011000;
			4'bxxxx: seg5 = 7'b1111111;
			default: seg5 = 7'b1111111;
		endcase
		case ({segmentosPrograma[15:12], segmentosPrograma[11:8]})
			 8'b00000000, 8'b00000001: begin
				  seg7 = 7'b1111111; 
				  seg6 = 7'b1000000; // 0
			 end
			 8'b00000010, 8'b00000011: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b1000000; // 0
			 end
			 8'b00000100, 8'b00000101: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b1111001; // 1
			 end
			 8'b00000110, 8'b00000111: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0100100; // 2
			 end
			 8'b00001000, 8'b00001001: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0110000; // 3
			 end
			 8'b00010000, 8'b00010001: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0011001; // 4
			 end
			 8'b00010010, 8'b00010011: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0010010; // 5
			 end
			 8'b00010100, 8'b00010101: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0000010; // 6
			 end
			 8'b00010110, 8'b00010111: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b1111000; // 7
			 end
			 8'b00011000, 8'b00011001: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b0000000; // 8
			 end
			 default: begin
				  seg7 = 7'b1111111;
				  seg6 = 7'b1111111; // Caso inválido
			 end
		endcase
		if(neg)begin
		seg7 = 7'b0111111;
		end
	end
endmodule
		