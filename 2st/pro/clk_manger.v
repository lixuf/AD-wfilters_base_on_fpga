module clk_manger(
input clk,
input reset,
input start,
output clk_50_0,
output clk_50_90,
output clk_150_90,
output clk_150_0,
output reset_1_50_0,
output reset_1_50_90
);

//开机初始化 1ms
reg state_start;
reg clk_start;
reg [5:0] i;
localparam init=1'b0;
localparam process=1'b1;

always @ (posedge clk)
begin
 case(state_start)
 init:begin
	 if(i==6'b110010)
	  state_start<=process;
	 else
	 begin
	  i=i+6'b1;
	  clk_start<=1'b0;
	 end
 end
 process:begin
	 clk_start<=1'b1;
 end
 default:begin
	 state_start<=init;
	 clk_start<=1'b0;
	 i<=6'b0;
 end
 endcase
end





//时钟
//c0 50_90
//c1 150_0
//c2 150_90
wire locked;
wire clk_50_90_temp;
wire clk_150_0_temp;
wire clk_150_90_temp;
pllip pll_u1(
	.areset(),
	.inclk0(clk),
	.c0(clk_50_90_temp),
	.c1(clk_150_0_temp),
	.c2(clk_150_90_temp),
	.locked(locked)
	);
assign clk_50_0=clk&clk_start&locked;
assign clk_50_90=clk_50_90_temp&clk_start&locked;
assign clk_150_0=clk_150_0_temp&clk_start&locked;
assign clk_150_90=clk_150_90_temp&clk_start&locked;



//复位
///90
wire reset_1_50_90_temp;
sirv_gnrl_dffrs #(1) reset_dffrs50_90(1'b0 ,reset_1_50_90_temp , clk_50_0,reset);
sirv_gnrl_dffl #(1) reset_dffl50_90(1'b1,reset_1_50_90_temp ,reset_1_50_90,clk_50_0);
///0
wire reset_1_50_0_temp;
sirv_gnrl_dffrs #(1) reset_dffrs50_0(1'b0 ,reset_1_50_0_temp , clk_50_90,reset);
sirv_gnrl_dffl #(1) reset_dffl50_0(1'b1,reset_1_50_0_temp ,reset_1_50_0,clk_50_90);


endmodule
