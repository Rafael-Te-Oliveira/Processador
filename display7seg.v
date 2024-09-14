module display7seg (segmentos, neg, seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7);

	input[31:0] segmentos;
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
		case (segmentos[27:24])
			4'b0000: seg6 = 7'b1000000;
			4'b0001: seg6 = 7'b1111001;
			4'b0010: seg6 = 7'b0100100;
			4'b0011: seg6 = 7'b0110000;
			4'b0100: seg6 = 7'b0011001;
			4'b0101: seg6 = 7'b0010010;
			4'b0110: seg6 = 7'b0000010;
			4'b0111: seg6 = 7'b1111000;
			4'b1000: seg6 = 7'b0000000;
			4'b1001: seg6 = 7'b0011000;
			4'bxxxx: seg6 = 7'b1111111;
			default: seg6 = 7'b1111111;
		endcase
		case (segmentos[31:28])
			4'b0000: seg7 = 7'b1000000;
			4'b0001: seg7 = 7'b1111001;
			4'b0010: seg7 = 7'b0100100;
			4'b0011: seg7 = 7'b0110000;
			4'b0100: seg7 = 7'b0011001;
			4'b0101: seg7 = 7'b0010010;
			4'b0110: seg7 = 7'b0000010;
			4'b0111: seg7 = 7'b1111000;
			4'b1000: seg7 = 7'b0000000;
			4'b1001: seg7 = 7'b0011000;
			4'bxxxx: seg7 = 7'b1111111;
			default: seg7 = 7'b1111111;
		endcase
		if(neg)begin
		seg7 = 7'b0111111;
		end
	end
endmodule
		