`define ad_width 16
module top_xiaobao(
input clk_50;
input reset;
input [`ad_width-1:0] ad_data;
input ad_vaild;

input out_vaild;
output out_ready;
output out_data;
);

wire fifo_ad_empty;
wire [`ad_widtth-1:0] fifo_ad_data;
wire fifo_ad_rdreq;
fifoip fifo_ad(
	.clock(clk),
	.data(ad_data),
	.rdreq(fifo_ad_rdreq),
	.sclr(reset),
	.wrreq(ad_vaild),
	.empty(fifo_ad_empty),
	.q(fifo_ad_data)
	);
	
ram_control ram_control_real(
.clk (clk);
.reset(reset);

.wdata(fifo_ad_data);
.w_vaild(~fifo_ad_empty);

.r_o_vaild;
.rdata;
.r_o_ready
);

wire locked;
wire clk_100;
wire clk;
pllip pllip_real(
	.areset(~reset),
	.inclk0(clk_50),
	.c0(clk_100),
	.locked(locked)
	);