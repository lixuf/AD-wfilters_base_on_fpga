`include "gen_defines.v"
module clk_gen(
input clk_in,
input reset_in,
output clk,
output reset_hi,
output reset_lo
);

//pll 50到100
wire locked;
wire clk_100;
pllip pllip_real(
	.areset(reset_in),
	.inclk0(clk_in), 
	.c0(clk_100),
	.locked(locked)
	);
assign clk=clk_100&locked;

//复位信号
assign reset_hi = ~reset_in;
assign reset_lo = reset_in;
endmodule
