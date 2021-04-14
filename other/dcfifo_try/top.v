module top(
input clk_50,
input	aclr,
	input [15:0] data,
	output rdclk,
	input rdreq,
	output wrclk,
	input wrreq,
	output [15:0] q,
	output rdempty,
	output rdfull,
	output [2:0] rdusedw,
	output wrempty,
	output wrfull,
	output [2:0] wrusedw,
	output clk_50_0,
	output clk_150_0,
	output clk_150_90,
	output clk_50_90,
	input pll_reset
);


wire clk_50_90t;
wire clk_150_0t;
wire clk_150_90t;
wire locked;

pllip plll(
	.areset(pll_reset),//1复位
	.inclk0(clk_50),
	.c0(clk_50_90t),
	.c1(clk_150_0t),
	.c2(clk_150_90t),
	.locked(locked)
	);
	
assign clk_50_0=clk_50&locked;
assign clk_50_90=clk_50_90t&locked;
assign clk_150_0=clk_150_0t&locked;
assign clk_150_90=clk_150_90t&locked;


fifoip fifof(
	.aclr(aclr),
	.data(data),
	.rdclk(clk_150_90),
	.rdreq(rdreq),
	.wrclk(clk_50_90),
	.wrreq(wrreq),
	.q(q),
	.rdempty(rdempty),
	.rdfull(rdfull),
	.rdusedw(rdusedw),
	.wrempty(wrempty),
	.wrfull(wrfull),
	.wrusedw(wrusedw)
	);
endmodule 