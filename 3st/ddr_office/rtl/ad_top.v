module ad_top(
//gen
input clk_50_0,
input reset_1_50,
input ddr_clk_90,
input clk_50_90,
input reset_syn,
input ddr_clk,

//ad_ctrl输出-连线
//与ad的接口
input [15:0] ad_data,
input ad_busy,
input first_data,
output [2:0]  ad_os,
output ad_cs,
output ad_rd,
output ad_reset,
output ad_convstab,



//fifo
input rd_fifo_req,
output [31:0] data_out,
output full,

//sim
output [31:0] ad_ch,
output data_flag

);


wire clr_fifo;
//wire data_flag;
ad7606 ad_ctrl(
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

	
	.data_flag(data_flag),
	.clr_fifo(clr_fifo)
	);
	

reg rd_fifo_req_1;
always@(posedge ddr_clk)
begin
 rd_fifo_req_1<=rd_fifo_req;
end
  
fifo_50_1667 (
	.aclr(reset_ayn|clr_fifo),
	.data(ad_ch),
	.rdclk(ddr_clk_90),
	.rdreq(rd_fifo_req_1),
	.wrclk(clk_50_90),
	.wrreq(data_flag),
	.q(data_out),
	.rdfull(full)
	);
	
	
endmodule
