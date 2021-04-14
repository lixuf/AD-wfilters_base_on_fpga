module ad_top(
//gen
input clk_50_0,
input reset_1_50,
//与ad的接口
input [15:0] ad_data,
input ad_busy,
input first_data,
//ad_ctrl输出
output [2:0]  ad_os,
output ad_cs,
output ad_rd,
output ad_reset,
output ad_convstab,
output [15:0] ad_ch,
output data_flag,

//tool
output [3:0] state_out
);



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
	
	//tool
	.state_out(state_out)
	);
	
endmodule
