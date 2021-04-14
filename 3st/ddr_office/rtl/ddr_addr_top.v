module ddr_addr_top(
//gen
input reset,
input clk_50_0,
output phy_clk,

//sim
output read_en,


//pin
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
	
	
//sim	output local_ready,
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
	
//来自adtop
output rd_fifo_req,
input [31:0] data_out,
input full,

//与小波top
input empty,
output write_fifo,
//sim
output rd_addr_up,
output wr_addr_up,
output [24:0] rd_addr,
output [24:0] wr_addr
);
parameter DATA_WIDTH = 32;           //总线数据宽度
parameter ADDR_WIDTH = 25;           //总线地址宽度

parameter IDLE = 3'd0;
parameter MEM_READ = 3'd1;
parameter MEM_WRITE  = 3'd2; 



//wire [24:0] rd_addr;
//wire [24:0] wr_addr;
//wire read_en;//读准许信号，由于读完了一块下一块未写完
addr_fetch  addr_fetch11(
   .reset(reset),
	.clk(phy_clk),
	.rd_addr_up(rd_addr_up),//地址自增信号，来自mem brush
	.wr_addr_up(wr_addr_up),//严格控制 自增时才为1
	
	//input frist_block,//表示刚刚开始写，等该信号为1才可开始读
	
 	.rd_addr(rd_addr),
	.wr_addr(wr_addr),
	.read_en(read_en)
	);




	
ddr_test2  ddr_test211(

	.source_clk(clk_50_0),        //输入系统时钟50Mhz
	.rst_n(reset),
	
   .mem_addr(mem_addr),
   .mem_ba(mem_ba),
   .mem_cas_n(mem_cas_n),
   .mem_cke(mem_cke),
   .mem_clk(mem_clk),
   .mem_clk_n(mem_clk_n),
   .mem_cs_n(mem_cs_n),
   .mem_dm(mem_dm),
   .mem_dq(mem_dq),
   .mem_dqs(mem_dqs),
   .mem_odt(mem_odt),
   .mem_ras_n(mem_ras_n),
   .mem_we_n(mem_we_n) ,
   
   .phy_clk(phy_clk)	,
	
	//sim
	.local_ready(local_ready),
	.local_address(local_address),
	.local_burstbegin(local_burstbegin),
	.local_init_done(local_init_done),
	.local_rdata(local_rdata),
	.local_rdata_valid(local_rdata_valid),
	.local_read_req(local_read_req),
	.local_wdata(local_wdata),
	.local_wdata_req(local_wdata_req),
	.local_write_req(local_write_req),
	.local_size(local_size),
	
	
	//ad-ram的fifo  50mhz-166.7mhz
	/*full信号做为写入请求，写信号被接收后，由local ready充当fifo读取信号*/
	.w_req(full),
   .read_fifo(rd_fifo_req),
	.read_fifo_data(data_out),
	//ram-xiaobo的fifo 166.7mhz
	/*用r vaild做为fifo写入信号
	  empty做为ddr的读1信号*/
	.r_req(empty),
	.write_fifo(write_fifo),
	//addr生成模块
	/*当接受读时更新addr 控制是否可读
	  当接受写时更新写addr*/
	.rd_addr(rd_addr),
	.wr_addr(wr_addr),
	.read_en(read_en),//读使能信号
	.rd_addr_up(rd_addr_up),//地址自增信号，来自mem brush
	.wr_addr_up(wr_addr_up)//严格控制 自增时才为1//未加
);
	
	
endmodule
