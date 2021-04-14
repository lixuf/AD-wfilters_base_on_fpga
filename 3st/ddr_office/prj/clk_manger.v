module clk_manger(
input clk,
input reset,
input phy_clk,
output clk_50_0,
output clk_50_90,
output phy_clk_90
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
wire locked1;
wire clk_50_90_temp;
wire phy_clk_90_temp;
pll166_7 pll166(
	.areset(),
	.inclk0(phy_clk),
	.c0(phy_clk_90_temp),
	.locked(locked1)
	);
wire locked2;
pll50 pll_50(
	.areset(),
	.inclk0(clk),
	.c0(clk_50_90_temp),
	.locked(locked2)
	);
wire locked=locked1&locked2;
assign clk_50_0=clk&clk_start&locked;
assign clk_50_90=clk_50_90_temp&clk_start&locked;
assign phy_clk_90=phy_clk_90_temp&clk_start&locked;






endmodule
