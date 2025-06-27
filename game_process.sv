module game_process (
    input wire clk,
	 input wire reset,
	 input wire [32:0] layer,
	 input [5:0] acoes,
    output reg [9:0] vram_inicio_X,
    output reg [9:0] vram_inicio_Y,
    output reg [9:0] vram_final_X,
    output reg [9:0] vram_final_Y,
	 output reg [9:0] FB_X,
    output reg [9:0] FB_Y
);
	
	typedef struct {
    logic [9:0] inicio_X;
    logic [9:0] inicio_Y;
    logic [9:0] final_X;
    logic [9:0] final_Y;
} Vram_Asset;

	typedef struct {
    logic [9:0] X;
    logic [9:0] Y;
} FB_Asset;

Vram_Asset vram_scenario[0:1];
Vram_Asset vram_gun[0:1];
Vram_Asset vram_HUD;
Vram_Asset vram_number[0:10];
Vram_Asset vram_enemy[0:1][0:2];

FB_Asset fb_scenario;
FB_Asset	fb_gun[0:2];
FB_Asset	fb_HUD;
FB_Asset	fb_number[0:1][0:4];
FB_Asset	fb_enemy[0:2][0:2];

initial begin
    vram_scenario[0] = '{inicio_X: 0,  inicio_Y: 0,   final_X: 159, final_Y: 119};
    vram_scenario[1] = '{inicio_X: 0, inicio_Y: 120, final_X: 159,  final_Y: 239};
	
    vram_gun[0] = '{inicio_X: 0,  inicio_Y: 240,   final_X: 39, final_Y: 273};
    vram_gun[1] = '{inicio_X: 0, inicio_Y: 274, final_X: 39,  final_Y: 307};
	
    vram_HUD = '{inicio_X: 0,  inicio_Y: 308,   final_X: 159, final_Y: 320};
	 
    vram_number[0] = '{inicio_X: 0, inicio_Y: 321, final_X: 4,  final_Y: 328};
	 vram_number[1] = '{inicio_X: 5,  inicio_Y: 321,   final_X: 9, final_Y: 328};
    vram_number[2] = '{inicio_X: 10, inicio_Y: 321, final_X: 14,  final_Y: 328};
	 vram_number[3] = '{inicio_X: 15,  inicio_Y: 321,   final_X: 19, final_Y: 328};
    vram_number[4] = '{inicio_X: 20, inicio_Y: 321, final_X: 24,  final_Y: 328};
	 vram_number[5] = '{inicio_X: 25,  inicio_Y: 321,   final_X: 29, final_Y: 328};
    vram_number[6] = '{inicio_X: 30, inicio_Y: 321, final_X: 34,  final_Y: 328};
	 vram_number[7] = '{inicio_X: 35,  inicio_Y: 321,   final_X: 39, final_Y: 328};
    vram_number[8] = '{inicio_X: 40, inicio_Y: 321, final_X: 44,  final_Y: 328};
	 vram_number[9] = '{inicio_X: 45,  inicio_Y: 321,   final_X: 49, final_Y: 328};
	 vram_number[10] = '{inicio_X: 50,  inicio_Y: 321,   final_X: 54, final_Y: 328};
	 
    vram_enemy[0][0] = '{inicio_X: 40, inicio_Y: 240, final_X: 79,  final_Y: 273};
	 vram_enemy[0][1] = '{inicio_X: 80, inicio_Y: 240, final_X: 119,  final_Y: 273};
	 vram_enemy[0][2] = '{inicio_X: 120, inicio_Y: 240, final_X: 159,  final_Y: 273};
	 
	 vram_enemy[1][0] = '{inicio_X: 40, inicio_Y: 274, final_X: 79,  final_Y: 307};
	 vram_enemy[1][1] = '{inicio_X: 80, inicio_Y: 274, final_X: 119,  final_Y: 307};
	 vram_enemy[1][2] = '{inicio_X: 120, inicio_Y: 274, final_X: 159,  final_Y: 307};
	 
	 fb_scenario = '{X: 0,  Y: 0};
	 
	 fb_gun[0] = '{X: 55,  Y: 74};
	 fb_gun[1] = '{X: 71,  Y: 74};
	 fb_gun[2] = '{X: 87,  Y: 74};
	 
	 fb_HUD = '{X: 0,  Y: 107};
	 
	 fb_number[0][0] = '{X: 28,  Y: 110};
	 fb_number[1][0] = '{X: 33,  Y: 110};
	 fb_number[0][1] = '{X: 86,  Y: 110};
	 fb_number[1][1] = '{X: 91,  Y: 110};
	 fb_number[0][2] = '{X: 140,  Y: 110};
	 fb_number[1][2] = '{X: 145,  Y: 110};
	 fb_number[0][3] = '{X: 75,  Y: 6};
	 fb_number[1][3] = '{X: 80,  Y: 6};
	 fb_number[0][4] = '{X: 140,  Y: 6};
	 fb_number[1][4] = '{X: 145,  Y: 6};
	 
	 fb_enemy[0][0] = '{X: 62,  Y: 56};
	 fb_enemy[1][0] = '{X: 74,  Y: 56};
	 fb_enemy[2][0] = '{X: 86,  Y: 56};
	 fb_enemy[0][1] = '{X: 54,  Y: 60};
	 fb_enemy[1][1] = '{X: 70,  Y: 60};
	 fb_enemy[2][1] = '{X: 86,  Y: 60};
	 fb_enemy[0][2] = '{X: 45,  Y: 73};
	 fb_enemy[1][2] = '{X: 61,  Y: 73};
	 fb_enemy[2][2] = '{X: 77,  Y: 73};
	 
end

reg scenario_flag = 0;             
reg [25:0] scenario_timer;

reg gun_flag = 0;
reg [1:0] gun_y = 1;
reg [25:0] gun_timer = 0;
reg prev_acao4 = 0;
reg [7:0] ammo = 60;
reg [4:0] acoes_prev;

reg enemy_flag = 0;
reg [2:0] enemy_x = 0;
reg [2:0] enemy_y = 0;
reg [1:0] rng;
reg [25:0] enemy_timer = 0;
reg trigger = 0;

reg [7:0] hp = 80;
reg [7:0] pts = 0;
reg [7:0] max = 0;
reg [7:0] tm = 60;
reg [25:0] timer = 0;

reg menu = 1;

random_enemy re (
.trigger(trigger),
.reset(reset),
.ammo(ammo),
.tm(tm),
.rng(rng)
);


always_ff @(posedge clk) begin
    // detectar flanco de subida
    if (acoes[1] && !acoes_prev[1]) begin
        if (gun_y > 0)
            gun_y <= gun_y - 1;
    end else if (acoes[3] && !acoes_prev[3]) begin
        if (gun_y < 2)
            gun_y <= gun_y + 1;
    end
    acoes_prev <= acoes;
end

always @(posedge clk) begin
    if(menu) begin
		 if(acoes[5]) begin
			menu <= 0;
			gun_flag <= 0;
			ammo <= 60;
			enemy_flag <= 0;
			hp <= 80;
			pts <= 0;
			tm <= 60;
			scenario_flag <= 0;
			gun_timer <= 0;
			enemy_timer <= 0;
			scenario_timer <= 0;
			enemy_y <= 0;
			timer <= 0;
		 end
	 end else begin
		 //gun_y = 1 - acoes[1] + acoes[3];
		 prev_acao4 <= acoes[4];

		 if (~prev_acao4 && acoes[4] && ammo) begin
			  gun_flag <= 1;
			  gun_timer <= 0;
			  ammo <= ammo - 1;
			  if(gun_y == enemy_x && !enemy_flag)begin
					enemy_flag <= 1;
					pts = pts + 1;
					if(pts > max) begin
						max <= pts;
					end
			  end
		 end else if (gun_flag) begin
			  if (gun_timer >= 26'd12_499_999) begin
					gun_flag <= 0;
			  end else begin
					gun_timer <= gun_timer + 1;
			  end
		 end
		 
		 if (acoes[0] || acoes[2]) begin
			  if (scenario_timer >= 26'd29_999_999) begin
					scenario_timer <= 0;
					scenario_flag <= ~scenario_flag;
					if(acoes[0])
						enemy_y = enemy_y + 1;
					else
						enemy_y = (enemy_y == 0) ? 0 : (enemy_y - 1);
			  end else begin
					scenario_timer <= scenario_timer + 1;
			  end
		 end
		 
		 if(enemy_timer >= 26'd29_999_999) begin
			enemy_timer <= 0;
			enemy_y = enemy_y + 1;
		 end else begin
			enemy_timer <= enemy_timer + 1;
		 end
		 
		 if(timer >= 26'd50_000_000)begin
			timer <= 0;
			tm <= tm - 1;
		 end else begin
			timer <= timer + 1;
		 end
		 
		 if(enemy_y > 2) begin
			enemy_y <= 0;
			enemy_x <= rng;
			if(!enemy_flag) hp <= hp - 10;
			enemy_flag <= 0;
			trigger <=1;
		 end else begin
			trigger <= 0;
			end
		 
		 if(hp <= 0 || tm <= 0)begin
			menu <= 1;
		 end
	end
end



always @(*) begin
		 case (layer)
			  32'd0: begin
					vram_inicio_X <= vram_scenario[scenario_flag].inicio_X;
					vram_inicio_Y <= vram_scenario[scenario_flag].inicio_Y;
					vram_final_X <= vram_scenario[scenario_flag].final_X;
					vram_final_Y <= vram_scenario[scenario_flag].final_Y;
					FB_X <= fb_scenario.X;
					FB_Y <= fb_scenario.Y;
			  end
			  32'd1: begin
					vram_inicio_X <= vram_enemy[enemy_flag][enemy_y].inicio_X;
					vram_inicio_Y <= vram_enemy[enemy_flag][enemy_y].inicio_Y;
					vram_final_X <= vram_enemy[enemy_flag][enemy_y].final_X;
					vram_final_Y <= vram_enemy[enemy_flag][enemy_y].final_Y;
					FB_X <= fb_enemy[enemy_x][enemy_y].X;
					FB_Y <= fb_enemy[enemy_x][enemy_y].Y;
			  end
			  32'd2: begin
					vram_inicio_X <= vram_gun[gun_flag].inicio_X;
					vram_inicio_Y <= vram_gun[gun_flag].inicio_Y;
					vram_final_X <= vram_gun[gun_flag].final_X;
					vram_final_Y <= vram_gun[gun_flag].final_Y;
					FB_X <= fb_gun[gun_y].X;
					FB_Y <= fb_gun[gun_y].Y;
			  end
			  32'd3: begin
					vram_inicio_X <= vram_HUD.inicio_X;
					vram_inicio_Y <= vram_HUD.inicio_Y;
					vram_final_X <= vram_HUD.final_X;
					vram_final_Y <= vram_HUD.final_Y;
					FB_X <= fb_HUD.X;
					FB_Y <= fb_HUD.Y;
			  end
			  32'd4: begin
					vram_inicio_X <= vram_number[hp/10].inicio_X;
					vram_inicio_Y <= vram_number[hp/10].inicio_Y;
					vram_final_X <= vram_number[hp/10].final_X;
					vram_final_Y <= vram_number[hp/10].final_Y;
					FB_X <= fb_number[0][0].X;
					FB_Y <= fb_number[0][0].Y;
			  end
			  32'd5: begin
					vram_inicio_X <= vram_number[hp%10].inicio_X;
					vram_inicio_Y <= vram_number[hp%10].inicio_Y;
					vram_final_X <= vram_number[hp%10].final_X;
					vram_final_Y <= vram_number[hp%10].final_Y;
					FB_X <= fb_number[1][0].X;
					FB_Y <= fb_number[1][0].Y;
			  end
			  32'd6: begin
					vram_inicio_X <= vram_number[tm/10].inicio_X;
					vram_inicio_Y <= vram_number[tm/10].inicio_Y;
					vram_final_X <= vram_number[tm/10].final_X;
					vram_final_Y <= vram_number[tm/10].final_Y;
					FB_X <= fb_number[0][1].X;
					FB_Y <= fb_number[0][1].Y;
			  end
			  32'd7: begin
					vram_inicio_X <= vram_number[tm%10].inicio_X;
					vram_inicio_Y <= vram_number[tm%10].inicio_Y;
					vram_final_X <= vram_number[tm%10].final_X;
					vram_final_Y <= vram_number[tm%10].final_Y;
					FB_X <= fb_number[1][1].X;
					FB_Y <= fb_number[1][1].Y;
			  end
			  32'd8: begin
					vram_inicio_X <= vram_number[ammo/10].inicio_X;
					vram_inicio_Y <= vram_number[ammo/10].inicio_Y;
					vram_final_X <= vram_number[ammo/10].final_X;
					vram_final_Y <= vram_number[ammo/10].final_Y;
					FB_X <= fb_number[0][2].X;
					FB_Y <= fb_number[0][2].Y;
			  end
			  32'd9: begin
					vram_inicio_X <= vram_number[ammo%10].inicio_X;
					vram_inicio_Y <= vram_number[ammo%10].inicio_Y;
					vram_final_X <= vram_number[ammo%10].final_X;
					vram_final_Y <= vram_number[ammo%10].final_Y;
					FB_X <= fb_number[1][2].X;
					FB_Y <= fb_number[1][2].Y;
			  end
			  32'd10: begin
					vram_inicio_X <= vram_number[pts/10].inicio_X;
					vram_inicio_Y <= vram_number[pts/10].inicio_Y;
					vram_final_X <= vram_number[pts/10].final_X;
					vram_final_Y <= vram_number[pts/10].final_Y;
					FB_X <= fb_number[0][3].X;
					FB_Y <= fb_number[0][3].Y;
			  end
			  32'd11: begin
					vram_inicio_X <= vram_number[pts%10].inicio_X;
					vram_inicio_Y <= vram_number[pts%10].inicio_Y;
					vram_final_X <= vram_number[pts%10].final_X;
					vram_final_Y <= vram_number[pts%10].final_Y;
					FB_X <= fb_number[1][3].X;
					FB_Y <= fb_number[1][3].Y;
			  end
			  32'd12: begin
					vram_inicio_X <= vram_number[max/10].inicio_X;
					vram_inicio_Y <= vram_number[max/10].inicio_Y;
					vram_final_X <= vram_number[max/10].final_X;
					vram_final_Y <= vram_number[max/10].final_Y;
					FB_X <= fb_number[0][4].X;
					FB_Y <= fb_number[0][4].Y;
			  end
			  32'd13: begin
					vram_inicio_X <= vram_number[max%10].inicio_X;
					vram_inicio_Y <= vram_number[max%10].inicio_Y;
					vram_final_X <= vram_number[max%10].final_X;
					vram_final_Y <= vram_number[max%10].final_Y;
					FB_X <= fb_number[1][4].X;
					FB_Y <= fb_number[1][4].Y;
			  end
			  default: begin
					vram_inicio_X <= vram_number[pts%10].inicio_X;
					vram_inicio_Y <= vram_number[pts%10].inicio_Y;
					vram_final_X <= vram_number[pts%10].final_X;
					vram_final_Y <= vram_number[pts%10].final_Y;
					FB_X <= fb_number[1][3].X;
					FB_Y <= fb_number[1][3].Y;
			  end
		 endcase
end

endmodule
