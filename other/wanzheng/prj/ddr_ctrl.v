//给出have read和write信号
module ddr_ctrl(
  output have_read,
  output have_write,
  
  //fifo_xb
  input fifo_xb_empty,

  
  //gen
  input clk_150_0,
  input reset_syn,
  
  //ddr ctrl top
  input fifo_ad_rreq,
  input fifo_xb_wreq,
  
  input read_req,
  input write_req,
  input burstbegin,
  output rdata_vaild,//连接到xb fifo的写使能端
  input [15:0] w_data,//从 ad fifo输入
  output [15:0] r_data,//写入到 xb fifo
  
  //fifo ad
  input [15:0] fifo_ad_r_data,//写入ddr数据
  
  //tool
  output write_ddr_out,
  output read_ddr_out,
  output [9:0] addr_out,
  output [9:0] out_addr_out
  
);




//生成写ddr信号
reg write_ddr;
always@(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  write_ddr<=1'b0;
 else if(fifo_ad_rreq==1'b1)
  write_ddr<=1'b1;
 else 
  write_ddr<=1'b0;
end
assign write_ddr_out=write_ddr;//tool

//生成读信号
reg read_ddr;
always@(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  read_ddr<=1'b0;
 else if(fifo_xb_wreq==1'b1)
  read_ddr<=1'b1;
 else
  read_ddr<=1'b0;
end
assign read_ddr_out=read_ddr;//tool

//have信号
reg ddr_empty_t;
wire ddr_empty=ddr_empty_t;
assign have_read=1'b1;
reg have_write_t;
assign have_write=have_write_t;
always @(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  begin
	have_write_t<=1'b0;
  end
 else if(out_2==1'b1&&ddr_empty==1'b0&&fifo_xb_empty==1'b1)
  have_write_t<=1'b1;
 else
  have_write_t<=1'b0;
end




//循环缓存,主要控制读地址最高位
reg out_2;
reg out_if_2;
reg [1:0] xh_state;
always @(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
 begin
  xh_state<=2'b00;
  out_2<=1'b0;
 end
 else begin
 
 case(xh_state)
 
 2'b00:begin
  xh_state<=2'b01;
  out_2<=1'b0;
  //out_addr<=10'b0;
  //addr<=10'b0;
 end
 
 2'b01:begin//写前1mb 输出后1mb
  if(addr[9]==1'b1)
  begin
   xh_state<=2'b11;
	//out_addr<=10'b0;
	ddr_empty_t<=1'b0;
  end
  else
  begin
   out_if_2=1'b1;
  end
  if(out_addr[9]==1'b1)
   ddr_empty_t<=1'b1;
 end
 
 2'b11:begin
  if(addr[9]==1'b0)
  begin
   xh_state<=2'b01;
	//out_addr<=10'b0;
	ddr_empty_t<=1'b0;
  end
  else
  begin
   out_if_2=1'b0;//读地址的最高位
	out_2=1'b1;//控制是否输出
  end
  if(out_addr[9]==1'b1)
   ddr_empty_t<=1'b1;
 end
 
 default:begin
  xh_state<=2'b00;
 end
 
 endcase
 
end
end

//写入ddr地址计数器 2mb=1m*16bit
reg [9:0] addr;
always @(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  begin
   addr<=10'b0;
  end
 else if(write_ddr==1'b1)
  begin
  addr<=10'd8+addr;
  end
end
assign addr_out=addr;//tool

//读出ddr地址计数器 9位最高位out_if_2给出
reg [9:0] out_addr;
always @(posedge clk_150_0 or posedge reset_syn)
begin
 if(reset_syn==1'b1)
  begin
   out_addr<=10'b0;
  end
  else  if(out_addr[9]==1'b1)//看一下时序保证最后8个数据能读出
	begin
	 out_addr<=10'b0;
	end
 else if(read_ddr)
  begin
   out_addr<=out_addr+10'd1;
  end

end
assign out_addr_out=out_addr;


//确定最终地址
wire [9:0]addr_end_t=write_req?addr:{out_if_2,{out_addr[8:0]}};
reg [9:0] addr_end;
always@(posedge clk_150_0)
begin
 addr_end<=addr_end_t;
end
  
ddr ddr_1(
.clk_150_0(clk_150_0),
.burstbegin(burstbegin),//每次伴随req 第一个clk拉高就行
.write_req(write_req),
.read_req(read_req),
.addr(addr_end),
. w_data(w_data),
.r_data(r_data),
.rdata_vaild(rdata_vaild)//每次读数据的同时拉高
);


/*
//循环缓存
//状态机，控制RAM实现环形缓冲
//ram 2MB 每1MB为一块
//写入16bit
//读出64bit，后接4个16位FIFO
localparam rw_width = 1;
localparam rw_state_0th={rw_width{1'b0}};//写前1mb
localparam rw_state_1th={rw_width{1'b1}};//写后1mb

wire [rw_width-1:0] state_r;


wire [`addr_width-1:0] addr_r;
wire [`addr_width-1:0] addr_next;

wire [`addr_width_r-1:0] addr_r_r2;
wire [`addr_width_r-1:0] addr_r_next;


//状态0
wire state_is_0th=(state_r==rw_state_0th);
wire [rw_width-1:0] state_0th_next;
wire state_0th_ex_ena;
assign state_0th_next=rw_state_1th;
assign state_0th_ex_ena=(addr_r=={1'b1,{`addr_width{1'b1}}});

//状态1
wire state_is_1th=(state_r==rw_state_1th);
wire [rw_width-1:0] state_1th_next;
wire state_1th_ex_ena;
assign state_1th_next=rw_state_0th;
assign state_1th_ex_ena=(addr_r=={1'b0,{`addr_width{1'b1}}});
//控制状态转移的寄存器

wire state_ena;
assign state_ena=state_0th_ex_ena
                |state_1th_ex_ena;
wire [rw_width-1:0] state_next;
assign state_next=({rw_width{state_0th_ex_ena}} &state_0th_next)
					  |({rw_width{state_1th_ex_ena}} &state_1th_next);
				  
sirv_gnrl_dfflr #(rw_width) state_dfflr (state_ena, state_next, state_r, clk, reset);		





//计数器，记录ram当前写地址

wire addr_ena;
sirv_gnrl_dfflr #(`addr_width) addr_dfflr (addr_ena,addr_next , addr_r, clk, reset);
assign addr_next=addr_r+`addr_width'd8;//好像进位自己为0？？？ 仿真时好好看看
assign addr_ena=w_vaild;



//与ram
ramip ramip_xuhuan(
	.clock(clk),
	.data(wdata),
	.rdaddress(addr_r_r2),
	.wraddress(addr_r),
	.wren(w_vaild),
	.q(rdata)
	);
	


////控制暂停--当当前块读完下一个块为载入完毕要暂停读
	 wire stop_r;
	 wire stop_next;
	 wire stop_ena;
	 sirv_gnrl_dfflr #(1) stop_dfflr (stop_ena,stop_next,stop_r,clk,reset);
	 wire r_full=(addr_r_r2[`addr_width_r-2:0]=={(`addr_width_r-1){1'b1}});//读完一个块
	 assign stop_ena=r_full
	                |state_ena;
	 assign stop_next=r_full;
	 
////控制是否可读
	 assign r_o_ready=addr_r[`addr_width-1]^state_r&(~stop_r);	
//读ram

wire addr_r_ena;
sirv_gnrl_dfflr #(`addr_width_r) addr_r_dfflr ( addr_r_ena , addr_r_next , addr_r_r2, clk , reset);
assign addr_r_next={state_r, addr_r_r2[`addr_width_r-2:0]+1 }; 
assign addr_r_ena=r_o_vaild&r_o_ready&(~stop_r);
*/

endmodule


