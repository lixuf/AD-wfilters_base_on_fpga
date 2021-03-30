//最后记得优化选择结构
//第一版 片上ram  2^16*8bit
//假设数据都能按时取走
`define addr_width 15//写地址宽度
`define wdata_width 16
`define addr_width_r 13
`define rdata_width 64
module ram_control(
input clk;
input reset;

input [`wdata_width-1:0] wdata;
input w_vaild;

input r_o_vaild;
output [`rdata_width-1:0] rdata;
output r_o_ready;
);
//计数器，记录ram当前写地址
wire [`addr_width-1:0] addr_r;
wire [`addr_width-1:0] addr_next;
wire addr_ena;
sirv_gnrl_dfflr #(`addr_width) addr_dfflr (addr_ena,addr_next , addr_r, clk, reset);
assign addr_next=addr_r+1;//好像进位自己为0？？？ 仿真时好好看看
assign addr_ena=w_vaild;



//与ram
ramip ramip_xuhuan(
	.clock(clk),
	.data(wdata),
	.rdaddress(addr_r_r),
	.wraddress(addr_r),
	.wren(w_vaild),
	.q(rdata)
	);
	
	
//读ram
wire [`addr_width_r-1:0] addr_r_r;
wire [`addr_width_r-1:0] addr_r_next;
wire addr_r_ena;
sirv_gnrl_dfflr #(`addr_r_width) addr_r_dfflr (addr_r_ena,addr_r_next , addr_r_r, clk, reset);
assign addr_r_next={state_r,{addr_r_r[0:`addr_width_r-2]+1}}; 
assign addr_r_ena=r_o_vaild&r_o_ready&(~stop_r);
////控制暂停--当当前块读完下一个块为载入完毕要暂停读
	 wire stop_r;
	 wire stop_next;
	 wire stop_ena;
	 sirv_gnrl_dfflr #(1) stop_dfflr (stop_ena,stop_next,stop_r,clk,reset);
	 assign stop_ena=r_full
	                |state_ena;
	 assign stop_next=r_full;
	 wire r_full=(addr_r_r[0:`addr_width_r-2]=={(`addr_width_r-1){1'b1}});//读完一个块
////控制是否可读
    wire r_o_ready;
	 assign r_o_ready=addr_r[`addr_with-1]^state_r&(~stop_r);



//状态机，控制RAM实现环形缓冲
//ram 2MB 每1MB为一块
//写入16bit
//读出64bit，后接4个16位FIFO
localparam rw_width = 1;
localparam rw_state_0th={rw_width{1'b0}};//写前1mb
localparam rw_state_1th={rw_width{1'b1}};//写后1mb

//控制状态转移的寄存器
wire [rw_width-1:0] state_r;
wire state_ena;
assign state_ena=state_0th_ex_ena
                |state_1th_ex_ena;
wire [rw_width-1:0] state_next;
assign state_next=({rw_width{state_0th_ex_ena}} &state_0th_next)
					  |({rw_width{state_1th_ex_ena}} &state_1th_next);
				  
sirv_gnrl_dfflr #(rw_width) state_dfflr (state_ena, state_next, state_r, clk, reset);					  

//状态0
wire state_is_0th=(state_r==rw_state_0th);
wire [rw_width-1:0] state_0th_next;
wire state_0th_ex_ena;
assign state_0th_next=rw_state_1th;
assign state_oth_ex_ena=(addr_r=={1'b1,{`addr_width{1'b1}});

//状态1
wire state_is_1th=(state_r==re_state_1th);
wire [rw_width-1:0] state_1th_next;
wire state_1th_ex_ena;
assign state_1th_next=rw_state_0th;
assign state_1th_ex_ena=(addr_r=={1'b0,{`addr_width{1'b1}});
