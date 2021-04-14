module ddr_test2(

	input  wire  source_clk,        //输入系统时钟50Mhz
	input rst_n,
	
   output  [ 14: 0] mem_addr,
   output  [  2: 0] mem_ba,
   output           mem_cas_n,
   output  [  0: 0] mem_cke,
   inout   [  0: 0] mem_clk,
   inout   [  0: 0] mem_clk_n,
   output  [  0: 0] mem_cs_n,
   output  [  1: 0] mem_dm,
   inout   [ 15: 0] mem_dq,
   inout   [  1: 0] mem_dqs,
   output  [  0: 0] mem_odt,
   output           mem_ras_n,
   output           mem_we_n ,
   //sim
   output    phy_clk	,
	output local_ready,
	output [ADDR_WIDTH - 1:0] local_address,
	output local_burstbegin,
	output local_init_done,
	output [DATA_WIDTH - 1:0] local_rdata,
	output local_rdata_valid,
	output local_read_req,
	output [DATA_WIDTH - 1:0] local_wdata,
	output local_wdata_req,
	output local_write_req,
	output [2:0] local_size,
	
	
	//ad-ram的fifo  50mhz-166.7mhz
	/*full信号做为写入请求，写信号被接收后，由local ready充当fifo读取信号*/
	input w_req,
	output read_fifo,
	input [31:0] read_fifo_data,
	//ram-xiaobo的fifo 166.7mhz
	/*用r vaild做为fifo写入信号
	  empty做为ddr的读1信号*/
	input r_req,
	output write_fifo,
	//addr生成模块
	/*当接受读时更新addr 控制是否可读
	  当接受写时更新写addr*/
	input [24:0] rd_addr,
	input [24:0] wr_addr,
	input read_en,//读使能信号
	output rd_addr_up,//地址自增信号，来自mem brush
	output wr_addr_up//严格控制 自增时才为1//未加
	
);

parameter DATA_WIDTH = 32;           //总线数据宽度
parameter ADDR_WIDTH = 25;           //总线地址宽度

parameter IDLE = 3'd0;
parameter MEM_READ = 3'd1;
parameter MEM_WRITE  = 3'd2; 
reg[2:0] state;
reg[2:0] next_state;

//////////状态锁存///////////////
always@(posedge	phy_clk)
	begin
		if(~local_init_done)          //等待初始化成功
			state <= IDLE;
		else	
			state <= next_state;
	end
	
/////读写仲裁 写优先///////////
always@(*)
	begin 
		case(state)
			IDLE:
			   if(w_req)
				 next_state <= MEM_WRITE;  
				else if(r_req&read_en)
				 next_state <= MEM_READ;
			MEM_WRITE:                    //写入数据到DDR2
				if(wr_burst_finish)          
					next_state <= IDLE;
			MEM_READ:                    //读出数据从DDR2
				if(rd_burst_finish)
					next_state <= IDLE;
			default:
				next_state <= IDLE;
		endcase
end

wire  [ADDR_WIDTH - 1:0] wr_burst_addr;
wire [ADDR_WIDTH - 1:0] rd_burst_addr;
wire    wr_burst_data_req;
wire    rd_burst_data_valid;
reg  [9:0] wr_burst_len;
reg  [9:0] rd_burst_len;
reg     wr_burst_req;
reg     rd_burst_req;
wire [DATA_WIDTH - 1:0] wr_burst_data;
wire [DATA_WIDTH - 1:0] rd_burst_data;


//DDR的读写地址和数据//
assign wr_burst_addr = wr_addr;//来自地址产生模块
assign rd_burst_addr = rd_addr;    
assign wr_burst_data = read_fifo_data;     //写入DDR的数据,注意时序！！


//产生burst写请求信号
assign read_fifo=	wr_burst_data_req;
always@(posedge phy_clk)
	begin
		if(next_state == MEM_WRITE && state != MEM_WRITE)
			begin
				wr_burst_req <= 1'b1;      //产生ddr burst写请求       
				wr_burst_len <= 10'd4;
			end
		else if(wr_burst_data_req)       //写入burst数据请求，该信号做为fifo的读信号
			begin
				wr_burst_req <= 1'b0;
				wr_burst_len <= 10'd4;
			end
		else
			begin
				wr_burst_req <= wr_burst_req;
				wr_burst_len <= 10'd4;
			end
	end

//产生burst读请求信号
assign write_fifo=rd_burst_data_valid;
always@(posedge phy_clk)
	begin
		if(next_state == MEM_READ && state != MEM_READ)
			begin
				rd_burst_req <= 1'b1;      //产生ddr burst读请求  
				rd_burst_len <= 10'd4;
			end
		else if(rd_burst_data_valid)     //检测到data_valid信号,burst读请求变0
			begin
				rd_burst_req <= 1'b0;
				rd_burst_len <= 10'd4;
			end
		else
			begin
				rd_burst_req <= rd_burst_req;
				rd_burst_len <= 10'd4;
			end
	end
	
/*
//地址自增信号
reg [1:0] addr_state;
localparam addr_idle =2'b0;
localparam addr_w=2'd1;
localparam addr_r=2'b2;
reg [2:0] addr_c;
always@(posedge phy_clk )
begin
 case(addr_state)
 addr_idle:begin
 addr_c<=3'b0;
 wr_addr_up<=1'b0;
 rd_addr_up<=1'b0;
 if(rd_burst_data_valid)
 addr_state<=addr_r;
 else if(wr_burst_data_req)
 addr_state<=addr_w;
 end
 
 addr_r:begin
 if(addr_c==3'b0)
  rd_addr_up<=1'b1;
 else if(addr_c==3'd1)
  rd_addr_up<=1'b0;
 if(rd_burst_data_valid)
  addr_c<=addr_c+3'b1;
 if(addr_c==3'b11)
  addr_state<=idle;
 end
 
 addr_w:begin
  if(addr_c==3'b0)
  wr_addr_up<=1'b1;
 else if(addr_c==3'd1)
  wr_addr_up<=1'b0;
 if(wr_burst_data_req)
  addr_c<=addr_c+3'b1;
 if(addr_c==3'b11)
  addr_state<=idle;
 end
 
 default:begin
 addr_state<=idle;
 end
 endcase
 end
*/
//wire	[ADDR_WIDTH - 1:0]	local_address;   
//wire		local_write_req;
//wire		local_read_req;
//wire	[DATA_WIDTH - 1:0]	local_wdata;
//wire	[DATA_WIDTH/8 - 1:0]	local_be;   
//wire	[2:0]	local_size;
//wire		local_ready;
//wire	[DATA_WIDTH - 1:0]	local_rdata;
//wire		local_rdata_valid;
//wire		local_wdata_req;
//wire		local_init_done;
//wire		phy_clk;
wire		aux_full_rate_clk;
wire		aux_half_rate_clk;
wire     rd_burst_finish;
wire     wr_burst_finish;
//实例化mem_burst_v2
mem_burst_v2
#(
	.MEM_DATA_BITS(DATA_WIDTH)
)
mem_burst_m0(
	.rst_n(rst_n),
	.mem_clk(phy_clk),
	.rd_burst_req(rd_burst_req),
	.wr_burst_req(wr_burst_req),
	.rd_burst_len(rd_burst_len),
	.wr_burst_len(wr_burst_len),
	.rd_burst_addr(rd_burst_addr),
	.wr_burst_addr(wr_burst_addr),
	.rd_burst_data_valid(rd_burst_data_valid),
	.wr_burst_data_req(wr_burst_data_req),
	.rd_burst_data(rd_burst_data),
	.wr_burst_data(wr_burst_data),
	.rd_burst_finish(rd_burst_finish),
	.wr_burst_finish(wr_burst_finish),
	///////////////////
	.local_init_done(local_init_done),
	.local_ready(local_ready),
	.local_burstbegin(local_burstbegin),
	.local_wdata(local_wdata),
	.local_rdata_valid(local_rdata_valid),
	.local_rdata(local_rdata),
	.local_write_req(local_write_req),
	.local_read_req(local_read_req),
	.local_address(local_address),
	.local_be(local_be),
	.local_size(local_size),
	
	//地址增加
	.wr_addr_up(wr_addr_up),
	.rd_addr_up(rd_addr_up)
);

//实例化ddr2.v
ddr2 ddr_m0(
	.local_address(local_address),
	.local_write_req(local_write_req),
	.local_read_req(local_read_req),
	.local_wdata(local_wdata),
	.local_be(local_be),
	.local_size(local_size),
	.global_reset_n(rst_n),
	//.local_refresh_req(1'b0), 
	//.local_self_rfsh_req(1'b0),
	.pll_ref_clk(source_clk),
	.soft_reset_n(1'b1),
	.local_ready(local_ready),
	.local_rdata(local_rdata),
	.local_rdata_valid(local_rdata_valid),
	.reset_request_n(),
	.mem_cs_n(mem_cs_n),
	.mem_cke(mem_cke),
	.mem_addr(mem_addr),
	.mem_ba(mem_ba),
	.mem_ras_n(mem_ras_n),
	.mem_cas_n(mem_cas_n),
	.mem_we_n(mem_we_n),
	.mem_dm(mem_dm),
	.local_refresh_ack(),
	.local_burstbegin(local_burstbegin),
	.local_init_done(local_init_done),
	.reset_phy_clk_n(),
	.phy_clk(phy_clk),
	.aux_full_rate_clk(),
	.aux_half_rate_clk(),
	.mem_clk(mem_clk),
	.mem_clk_n(mem_clk_n),
	.mem_dq(mem_dq),
	.mem_dqs(mem_dqs),
	.mem_odt(mem_odt)
	);
	
endmodule 

