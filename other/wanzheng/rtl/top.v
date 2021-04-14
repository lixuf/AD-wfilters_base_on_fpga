module top(
//时钟管理
input clk_in,
input reset_syn,
input start,

//与ad
input [15:0] ad_data,
input ad_busy,
input first_data,
	output [2:0] 	ad_os,              //ad7606 过采样倍率选择
	output   		ad_cs,              //ad7606 AD cs
	output   		ad_rd,              //ad7606 AD data read
	output  		ad_reset,           //ad7606 AD reset
	output  		ad_convstab,
	
//tool
  output write_ddr_out,
  output read_ddr_out,
  
  output [9:0] addr_out,
  output [9:0] out_addr_out,
  
  output [15:0] fifo_ad_r_data,
  output fifo_ad_rreq,
  
  output data_flag,
  output [15:0] ad_ch,
  output clk_150_0,
  //tool
output [3:0] state_out,
output fifo_ad_full_flag

);
wire clk_50_0;
wire clk_50_90;
wire clk_150_90;
//tool wire clk_150_0;
wire reset_1_50_90;
wire reset_1_50_0;
clk_manger clk_manger_1(
.clk(clk_in),
.reset(~reset_syn),
.start(start),
.clk_50_0(clk_50_0),
.clk_50_90(clk_50_90),
.clk_150_90(clk_150_90),
.clk_150_0(clk_150_0),
.reset_1_50_0(reset_1_50_0),
.reset_1_50_90(reset_1_50_90)
);


//tool wire [15:0] ad_ch;
//tool wire data_flag;
ad_top ad_top_1(
//gen
.clk_50_0(clk_50_0),
.reset_1_50(reset_1_50),
//与ad的接口
.ad_data(ad_data),
.ad_busy(ad_busy),
.first_data(first_data),
//ad_ctrl输出
.ad_os(ad_os),
.ad_cs(ad_cs),
.ad_rd(ad_rd),
.ad_reset(ad_reset),
.ad_convstab(ad_convstab),
.ad_ch(ad_ch),
.data_flag(data_flag),

//tool
	.state_out(state_out)
);

wire fifo_xb_rreq;
wire fifo_xb_r_data;
wire fifo_xb_use;
wire fifo_xb_full;
xiaobo_top xiaobo_top_1(
.fifo_xb_rreq(fifo_xb_rreq),
. fifo_xb_r_data(fifo_xb_r_data),
.fifo_xb_use(fifo_xb_use),//滞后一个时钟
.fifo_xb_full(fifo_xb_full)
);

ddr_top ddr_top_1(
//gen
.reset_1_50_0(reset_1_50_0),
.clk_50_90(clk_50_90),
.clk_150_90(clk_150_90),
.clk_150_0(clk_150_0),
.reset_syn(~reset_syn),//异步复位

//fifo_ar
//ad来的都是0°相移
//在下一次采集前一定要移走
.ad_ch(ad_ch),//ad来的数据
.fifo_ad_wreq(data_flag),//连接dataflag



//fifo_xb

//来自xb ctrl
.fifo_xb_rreq(fifo_xb_rreq),
.fifo_xb_r_data(fifo_xb_r_data),
.fifo_xb_use(fifo_xb_use),
.fifo_xb_full(fifo_xb_full),

 //tool
  .write_ddr_out(write_ddr_out),
  .read_ddr_out(read_ddr_out),
  .addr_out(addr_out),
  .out_addr_out(out_addr_out),
  .fifo_ad_rreq(fifo_ad_rreq),
  .fifo_ad_r_data(fifo_ad_r_data),
  .fifo_ad_full_flag(fifo_ad_full_flag)
);

endmodule
 