module top(
 input clk_50_0,
 input reset,
 
 //外部接口
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

	
	output locked,
	output wr_burst_req_out,
	output wr_burst_data_req,
	output [31:0] wr_burst_data_out,
	output wr_burst_finish,
	output rd_burst_req_out,
	output [31:0] rd_burst_data,
	output rd_burst_finish,
	output rd_burst_data_valid,
	
	output [2:0] state_out,
	
	output local_init_done,
	output phy_clk_150_0,
	output local_ready,
   output [2:0] state_out_2,
	output [24:0] burst_addr_out,
	
	//new_dd
	output wr_burst_data_rfifo,
	output rd_burst_data_wfifo,
	
	//sim
	output local_read_req
);

wire reset_syn=1'b0;
/*
wire clk_150_0_t;
wire clk_150;
pllip (
	.areset(),
	.inclk0(clk_50_0),
	.c0(clk_150_0_t),
	.c1(clk_150),
	.locked(locked)
	);
	*/
	
wire clk_150_0=phy_clk_150_0;


reg [2:0] state;
assign state_out=state;

localparam read=3'd4;
reg read_c;
reg rd_burst_req;
assign rd_burst_req_out=rd_burst_req;

localparam read_wait=3'd1;
reg [24:0] burst_addr;
assign burst_addr_out=burst_addr;
reg read_wait_c;

localparam read_data=3'd2;

localparam write_wait=3'd0;
reg wr_burst_req;
assign wr_burst_req_out=wr_burst_req;

localparam write_data=3'd3;
reg [3:0] write_data_c;
reg [31:0] wr_burst_data;
assign wr_burst_data_out=wr_burst_data;

localparam idle_f=3'd5;

always @ (posedge clk_150_0)
begin
 if(burst_addr>25'd30)
  burst_addr<=25'b0;

 if(reset==1'b0)
  state<=write_wait;

else if(local_init_done==1'b1)
begin
 case(state)
 read:begin
   state<=read_wait;
   rd_burst_req<=1'b1;
 end
 
 read_wait:begin

  if(rd_burst_data_valid==1'b1)
  begin
	state<=read_data;
	rd_burst_req<=0;
  end
  
 end
 
 read_data:begin
  if(rd_burst_finish==1'b1)
  begin
   state<=write_wait;
	burst_addr<=burst_addr+25'd4;
  end
 end
 
 write_wait:begin
  rd_burst_req<=1'b0;
  if(wr_burst_data_req==1'b1)
  begin
   state<=write_data;
	write_data_c<=3'd0;
	wr_burst_req<=1'b0;
  end
  else
    wr_burst_req<=1'b1;
 end
 
 write_data:begin
 if(wr_burst_finish==1'b1)
 begin
  state<=write_wait;
  //write_data_c<=3'd0;
 end
 else if(wr_burst_data_rfifo==1'b1)
  begin
  //write_data_c<=write_data_c+3'd1;
  wr_burst_data<=wr_burst_data+32'd1;
  end
 end
 

 
 endcase
 end
end






ddr_ctrl ddr_ctrl_1(
  .source_clk(clk_50_0),//50mhz
	.rst_n(reset),
	
	.phy_clk(phy_clk_150_0),

/*ddr读写用户接口信号*/	
   .local_init_done(local_init_done),         //ddr initial done

	.wr_burst_req(wr_burst_req),            //DDR Burst写请求         	
	.wr_burst_len(10'd5),	           //DDR Burst写长度
	.wr_burst_addr(burst_addr),           //DDR Burst写地址
   .wr_burst_data_req(wr_burst_data_req),	     //写入数据_写完成	
	.wr_burst_data(wr_burst_data),           //DDR Burst写数据
   .wr_burst_finish(wr_burst_finish),         //DDR Burst写完成信号
	
	.rd_burst_req(rd_burst_req),            //DDR Burst读请求 
	.rd_burst_len(10'd5),	           //DDR Burst读长度
	.rd_burst_addr(burst_addr),           //DDR Burst读地址		
   .rd_burst_data_valid(rd_burst_data_valid),     //DDR Burst读数据有效		
	.rd_burst_data(rd_burst_data),           //DDR Burst读数据
   .rd_burst_finish(rd_burst_finish),       //DDR Burst读完成信号
	.wr_burst_data_rfifo(wr_burst_data_rfifo),//读ad-ddr的fifo信号
	.rd_burst_data_wfifo(rd_burst_data_wfifo),
	.local_read_req(local_read_req),
/*ddr接口信号*/	
   .mem_addr(mem_addr),
   .mem_ba(mem_ba),
   . mem_cas_n(mem_cas_n ),
  .mem_cke(mem_cke),
   .mem_clk(mem_clk),
   .mem_clk_n(mem_clk_n),
  .mem_cs_n(mem_cs_n),
   .mem_dm(mem_dm),
   . mem_dq(mem_dq),
  . mem_dqs(mem_dqs),
  . mem_odt(mem_odt),
   . mem_ras_n(mem_ras_n),
   . mem_we_n(mem_we_n),
	.local_ready(local_ready),
	.state_out(state_out_2)
	);
	
endmodule
