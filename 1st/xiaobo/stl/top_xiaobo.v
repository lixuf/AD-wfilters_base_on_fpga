`include "gen_defines.v"
module top_xiaobo(
input clk_50,
input reset_in,

input [`ad_width-1:0] ad_data,
input ad_vaild,

input out_vaild,
output out_ready,
output [`rdata_width-1:0] out_data
);

wire reset_hi;
wire reset_lo;
wire clk;



//输入fifo
wire fifo_ad_empty;
wire [`ad_width-1:0] fifo_ad_data;
wire fifo_ad_rdreq=~fifo_ad_empty;
fifoip fifo_ad(
	.clock(clk),
	.data(ad_data),
	.rdreq(fifo_ad_rdreq),
	.sclr(reset_lo),
	.wrreq(ad_vaild),
	.empty(fifo_ad_empty),
	.q(fifo_ad_data)
	);
	
	
	 
//输出FIFO
wire r_o_vaild;
wire r_o_ready;
wire [`rdata_width-1:0] rdata;
out_fifo out_fifo_re(
.r_o_vaild(r_o_vaild),
.r_o_ready(r_o_ready),
.rdata(rdata),

.clk(clk),
.reset(reset_lo),

.filter_vaild(out_vaild),
.filter_ready(out_ready),
.filter_data(out_data)
);






ram_control ram_control_real(
.clk (clk),
.reset(reset),

.wdata(fifo_ad_data),
.w_vaild(~fifo_ad_empty),

.r_o_vaild(r_o_vaild),
.r_o_ready(r_o_ready),
	.rdata(rdata)

);





//时钟和复位信号管理
clk_gen clk_gen_rv(
.clk_in(clk_50),
.reset_in(reset_in),
.clk(clk),
.reset_lo(reset_lo),
.reset_hi(reset_hi)
);


endmodule
	

