module ddr_ctrl_top(
 //与ad fifo
 input fifo_ad_full_flag,//0相位
 output fifo_ad_rreq,//0相位
 input [15:0] fifo_ad_r_data,//读使能的下一个clk可以读到数据
 
 //与xb fifo
 output [15:0] fifo_xb_w_data,
 output xb_rdata_vaild,//xb fifo的写入使能
 input fifo_xb_empty,
 
 //gen
 input reset_syn,
 input clk_150_90,
 input clk_150_0,
 
 //tool
   //tool
  output write_ddr_out,
  output read_ddr_out,
  output [9:0] addr_out,
  output [9:0] out_addr_out
);

//与ad fifo
///读fifo使能
reg read_ad_ready_t;
wire read_ad_ready=read_ad_ready_t;//表示现在ddr可读fifo
assign fifo_ad_rreq=fifo_ad_full_flag&read_ad_ready;


//与xb fifo
///写fifo使能
reg write_xb_ready_t;
wire write_xb_ready=write_xb_ready_t;//表示现在ddr正在输出需写入fifo
assign fifo_xb_wreq=fifo_xb_empty&write_xb_ready;//写信号和数据同时给出就行，存储器的读数据使能
                                                //存储器给出的read vaild做为xb fifo的写入使能
reg burstbegin;
wire burstbegi=burstbegin;       
//实例化ddr ctrl
ddr_ctrl ddr_ctrl_1(
  .have_read(have_read),
  .have_write(have_write),
  
  //fifo_xb
  .fifo_xb_empty(fifo_xb_empty),

  
  //gen
  .clk_150_0(clk_150_0),
  .reset_syn(reset_syn),
  
  //ddr ctrl top
  .fifo_ad_rreq(fifo_ad_rreq),
  .fifo_xb_wreq(fifo_xb_wreq),
  
  .fifo_ad_r_data(fifo_ad_r_data),
  
  .write_req(fifo_ad_rreq),
  .read_req(fifo_xb_wreq),
  .burstbegin(burstbegi),
 .rdata_vaild(xb_rdata_vaild),//连接到xb fifo的写使能端
 .w_data(fifo_ad_r_data),//从 ad fifo输入
  . r_data(fifo_xb_w_data),
  
  //tool
  .write_ddr_out(write_ddr_out),
  .read_ddr_out(read_ddr_out),
  .addr_out(addr_out),
  .out_addr_out(out_addr_out)
);




//读写状态机
reg [3:0] count_8;
reg [1:0] ddr_state;
localparam idle = 2'b00;
localparam read = 2'b01;
localparam write = 2'b10;
always @(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  begin
   ddr_state<=2'b00;
	count_8<=4'b0000;
  end
  else
begin
 case(ddr_state)
 
 idle:begin//读ad优先
  count_8<=4'b0000;
  write_xb_ready_t<=1'b0;
  read_ad_ready_t<=1'b0;
  burstbegin<=1'b0;
  if(have_read==1'b1&fifo_ad_full_flag==1'b1)
   ddr_state<=read;
  else if(have_write==1'b1&fifo_xb_empty==1'b1)
   ddr_state<=write;
 end
 
 read:begin
  if(count_8==4'b1000)
  begin
   ddr_state<=idle;
	read_ad_ready_t<=1'b0;
  end
  else begin
   count_8<=count_8+4'b0001;
   read_ad_ready_t<=1'b1;//brush==1
  end
  if(count_8==4'b0000)
  begin
   burstbegin<=1'b1;
  end
  else 
   burstbegin<=1'b0;
 end
 
 write:begin
 if(count_8==4'b0000)
  begin
   count_8<=count_8+4'b0001;
	write_xb_ready_t<=1'b1;
   burstbegin<=1'b1;
  end
  else 
   write_xb_ready_t<=1'b0;
   ddr_state<=idle;
   burstbegin<=1'b0;
 end
 
 default:begin
  ddr_state<=idle;
 end
 
 endcase
end
end


endmodule
