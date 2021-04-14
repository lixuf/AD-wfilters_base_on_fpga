//fifo->ddr_ctrl
//fifo输入时钟50mhz
//fifo输出时钟150mhz
//存满8个数据就读出
//放入ddr中
//用full信号做为ddr写请求信号

//ddr_ctrl->fifo


module ddr_top(
//gen
input reset_1_50_0,
input clk_50_90,
input clk_150_90,
input clk_150_0,
input reset_syn,//异步复位

//fifo_ar
//ad来的都是0°相移
//在下一次采集前一定要移走
input [15:0] ad_ch,//ad来的数据
input fifo_ad_wreq,//连接dataflag



//fifo_xb

//来自xb ctrl
input fifo_xb_rreq,
output [15:0] fifo_xb_r_data,
output [2:0]fifo_xb_use,
output fifo_xb_full,

   //tool
  output write_ddr_out,
  output read_ddr_out,
  output [9:0] addr_out,
  output [9:0] out_addr_out,
  output [15:0] fifo_ad_r_data,
  output fifo_ad_rreq,
  output fifo_ad_full_flag

);





 
 

//ad与ram之间的fifo
//存入数据计数到8就把写满信号同步到150mhz域中
reg [3:0] count_fifo_in;
reg full_flag;
always @(posedge clk_50_90 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  begin
   count_fifo_in<=4'b0000;
   full_flag<=1'b0;
  end
 else if(count_fifo_in==4'b1000)
  begin
   full_flag<=1'b1;
   count_fifo_in<=4'b0000;
  end
 else if(fifo_ad_wreq==1'b1)
  begin
   full_flag<=1'b0;
   count_fifo_in<=count_fifo_in+4'b0001;
  end
end

//把存满标志位同步过150mhz中
reg full_flag_1;
reg full_flag_2;
always @(posedge clk_150_0)
begin
 full_flag_1<=full_flag;
 full_flag_2<=full_flag_1;
end
assign fifo_ad_full_flag=full_flag_2;



//tool wire fifo_ad_rreq;
fifoip_50_150 fifoip_50_150_1 (
	.aclr(reset_syn),
	.data(ad_ch),
	.rdclk(clk_50_90),
	.rdreq(fifo_ad_wreq),
	.wrclk(clk_150_90),
	.wrreq(fifo_ad_rreq),
	.q(fifo_ad_r_data)
	);

	
	
	
	
	
	
	
wire fifo_xb_w_data;
wire fifo_xb_wreq;
wire fifo_xb_empty;
//ddr的输出fifo与小波 150mhz

fifoip_150_150 fifoip_150_150_1(
	.aclr(reset_syn),
	.clock(clk_150_90),
	.data(fifo_xb_w_data),
	.rdreq(fifo_xb_rreq),
	.sclr(),
	.wrreq(fifo_xb_wreq),
	.empty(fifo_xb_empty),
	.full(fifo_xb_full),
	.q(fifo_xb_r_data),
	.usedw(fifo_xb_use)
	);




ddr_ctrl_top ddr_ctrl_top_1(
 //与ad fifo
 .fifo_ad_full_flag(fifo_ad_full_flag),//0相位
 .fifo_ad_rreq(fifo_ad_rreq),//0相位
 .fifo_ad_r_data(fifo_ad_r_data),//读使能的下一个clk可以读到数据
 
 //与xb fifo
.fifo_xb_w_data(fifo_xb_w_data),
.xb_rdata_vaild(fifo_xb_wreq),//xb fifo的写入使能
.fifo_xb_empty(fifo_xb_empty),
 
 //gen
.reset_syn(reset_syn),
.clk_150_90(clk_150_90),
.clk_150_0(clk_150_0),
  //tool
  .write_ddr_out(write_ddr_out),
  .read_ddr_out(read_ddr_out),
  .addr_out(addr_out),
  .out_addr_out(out_addr_out)
);



	/*
//ad->ddr的fifo
wire rdreq_ar;
wire [15:0] data_ar;
wire empty_ar;
wire full_ar;

//连接AD和ram控制器的fifo
//写入50mhz，读出150mhz
//50mhz需要与基准偏移90°
//写时钟同步的reset
fifoip_50_150 fifoip_ad_ram(
	.aclr(reset_1_50_0),
	.data(ad_ch),
	.rdclk(clk_50_90),
	.rdreq(rdreq_ar),
	.wrclk(clk_150_90),
	.wrreq(wrreq_ad),
	.q(data_ar),
	.rdempty(empty_ar),
	.wrfull(full_ar)
	);
	
//ddr->xiaobo的fifo
wire [15:0] data_xb;
wire wdreq_xb;
wire empty_xb;
wire full_xb;

fifoip_150_150 fifoip_ram_xb(	
	.aclr(),
	.clock(clk_150_90),
	.data(data_xb),
	.rdreq(),
	.sclr(reset_syn),//异步复位
	.wrreq(wdreq_xb),
	.empty(empty_xb),
	.full(full_xb),
	.q(),
	.usedw()
	);
	
//ram的控制器
ctrl_top ctrl_top_1(
.clk_150_0(clk_150_0),
.clk_150_90(clk_150_90),
.reset_1_50_0(reset_1_50_0),

.w_req(full_ar),//来自full
.r_req(empty_xb),//来自empty

.w_fifo_req(rdreq_ar),//8个时钟
.r_fifo_req(wdreq_xb),

.w_fifo_data(data_ar),//连续读8个，在请求信号之后的90°
.r_fifo_data(data_xb)
);
*/
endmodule

