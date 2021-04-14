module ddr_ctrl
#(
	parameter DATA_WIDTH = 32,        //数据宽度
	parameter ADDR_WIDTH = 25         //地址宽度
)
(
	input  wire  source_clk,
	input  rst_n,
	
	output phy_clk,

/*ddr读写用户接口信号*/	
   output                   local_init_done,         //ddr initial done

	input                    wr_burst_req,            //DDR Burst写请求         	
	input  [9:0]             wr_burst_len,	           //DDR Burst写长度
	input [ADDR_WIDTH - 1:0] wr_burst_addr,           //DDR Burst写地址
   output                   wr_burst_data_req,	     //写入数据请求	
	input [DATA_WIDTH - 1:0] wr_burst_data,           //DDR Burst写数据
   output                   wr_burst_finish,         //DDR Burst写完成信号
	
	input                    rd_burst_req,            //DDR Burst读请求 
	input  [9:0]             rd_burst_len,	           //DDR Burst读长度
	input [ADDR_WIDTH - 1:0] rd_burst_addr,           //DDR Burst读地址		
   output                   rd_burst_data_valid,     //DDR Burst读数据有效		
	output[DATA_WIDTH - 1:0] rd_burst_data,           //DDR Burst读数据
   output                   rd_burst_finish,         //DDR Burst读完成信号
	output wr_burst_data_rfifo,//读ad-dddr的fifo的信号
	output rd_burst_data_wfifo,//写小波fifo信号
/*ddr接口信号*/	
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
   output           mem_we_n,
	//sim
  output local_ready	,
  output [2:0] state_out,
  output local_read_req
  
);


wire	[ADDR_WIDTH - 1:0]	local_address;   
wire		local_write_req;
//wire		local_read_req;
wire	[DATA_WIDTH - 1:0]	local_wdata;
wire	[DATA_WIDTH/8 - 1:0]	local_be;   
wire	[2:0]	local_size;
//wire		local_ready;
wire	[DATA_WIDTH - 1:0]	local_rdata;
wire		local_rdata_valid;
wire		local_wdata_req;
wire		aux_full_rate_clk;
wire		aux_half_rate_clk;
wire     local_burstbegin;


ddr_top
#(
	.MEM_DATA_BITS(DATA_WIDTH),
	.ADDR_BITS(ADDR_WIDTH)
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
	.state_out(state_out),
	.wr_burst_data_rfifo(wr_burst_data_rfifo),//读ad-ddr fifo
	.rd_burst_data_wfifo(rd_burst_data_wfifo)//写xiaobo fifo信号
);

//实例化ddr2.v IP
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

