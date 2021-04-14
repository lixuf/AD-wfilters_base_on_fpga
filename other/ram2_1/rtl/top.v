module top(
input clk,
input reset,
input [15:0] ad_data,
input ad_busy,
input first_data,
input start,

//test
output empty_ar,
output full_ar,
output [31:0] data_ar,
input rdreq_ar,
output clk_50_0,
output clk_50_90,
output clk_150_90,
output clk_150_0,
output reset_1_50_0,
output reset_1_50_90,
output data_flag,
output ad_reset
);

/*
wire clk_50_0;
wire clk_50_90;
wire clk_150_90;
wire clk_150_0;
wire reset_1_50_0;
wire reset_1_50_90;
*/
clk_manger clk_mm(
.clk(clk),
.reset(reset),
.start(start),
.clk_50_0(clk_50_0),
.clk_50_90(clk_50_90),
.clk_150_90(clk_150_90),
.clk_150_0(clk_150_0),
.reset_1_50_0(reset_1_50_0),
.reset_1_50_90(reset_1_50_90)
);






wire [2:0]  ad_os;
wire ad_cs;
wire ad_rd;
//wire ad_reset;
wire ad_convstab;
wire [15:0] ad_ch;
//wire data_flag;
ad7606 vvv(
   .clk(clk_50_0),                  //50mhz
   .rst_n(reset_1_50),                          //同步复位
	.ad_data(ad_data),            //ad7606 采样数据
	.ad_busy(ad_busy),            //ad7606 忙标志位 
   .first_data(first_data),         //ad7606 第一个数据标志位 	  
	
	.ad_os(ad_os),              //ad7606 过采样倍率选择
	.ad_cs(ad_cs),              //ad7606 AD cs
	.ad_rd(ad_rd),              //ad7606 AD data read
   .ad_reset(ad_reset),           //ad7606 AD reset
	.ad_convstab(ad_convstab),         //ad7606 AD convert start

	.ad_ch(ad_ch),   

	
	.data_flag(data_flag)
	);
	
	
	
//连接AD和ram控制器的fifo
//写入50mhz，读出150mhz
//50mhz需要与基准偏移90°
//写时钟同步的reset
fifoip_50_150_16_32 fifoip_ad_ram(
	.aclr(reset_1_50_0),
	.data(ad_ch),
	.rdclk(clk_150_0),
	.rdreq(rdreq_ar),
	.wrclk(clk_50_0),
	.wrreq(data_flag),
	.q(data_ar),
	.rdfull(full_ar)
	);
/*
	aclr,
	data,
	rdclk,
	rdreq,
	wrclk,
	wrreq,
	q,
	rdfull);
	*/

endmodule 