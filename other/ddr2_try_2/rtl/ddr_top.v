module ddr_top
#(
	parameter MEM_DATA_BITS = 32,
	parameter ADDR_BITS = 25,
	parameter LOCAL_SIZE_BITS = 3
)
(
	input rst_n,                                 /*复位*/
	input mem_clk,                               /*接口时钟*/
	input rd_burst_req,                          /*读请求*/
	input wr_burst_req,                          /*写请求*/
	input[9:0] rd_burst_len,                     /*读数据长度*/
	input[9:0] wr_burst_len,                     /*写数据长度*/
	input[ADDR_BITS - 1:0] rd_burst_addr,        /*读首地址*/
	input[ADDR_BITS - 1:0] wr_burst_addr,        /*写首地址*/
	output reg rd_burst_data_valid,                  /*读出数据有效*/
	output reg wr_burst_data_req,                    /*写数据信号*/
	output[MEM_DATA_BITS - 1:0] rd_burst_data,   /*读出的数据*/
	input[MEM_DATA_BITS - 1:0] wr_burst_data,    /*写入的数据*///fifi的数据
	output reg rd_burst_finish,                      /*读完成*/
	output reg wr_burst_finish,                      /*写完成*/
	output burst_finish,                         /*读或写完成*/
   output reg wr_burst_data_rfifo,          //读FIFO信号
	output rd_burst_data_wfifo,
	///////////////////
	/*一下是altera ddr2 IP的接口，可参考altera相关文档*/
	input local_init_done,
	output ddr_rst_n,
	input local_ready,
	output  reg local_burstbegin,
	output  [MEM_DATA_BITS - 1:0] local_wdata,
	input local_rdata_valid,
	input[MEM_DATA_BITS - 1:0] local_rdata,
	output  reg local_write_req,
	output  reg local_read_req,
	output reg[23:0] local_address,
	output [MEM_DATA_BITS/8 - 1:0] local_be,
	output [LOCAL_SIZE_BITS - 1:0] local_size,
	
	//sim
	output [3:0] state_out

);

assign local_be=4'b1111;
assign rd_burst_data=local_rdata;
assign local_wdata=wr_burst_data;
assign  local_size=3'd4;
assign rd_burst_data_wfifo=local_rdata_valid&local_ready;

reg [3:0] state;
assign state_out=state;

localparam idle=4'd0;

localparam r_lock=4'd1;
reg [ADDR_BITS-1:0] r_addr;

localparam r_run=4'd2;
localparam r_wait=4'd3;
localparam r_finish=4'd4;
reg [1:0] r_finish_c;
 
localparam w_lock=4'd5;
reg [ADDR_BITS-1:0] w_addr;
localparam w_run=4'd6;
reg [2:0] w_run_c;

localparam idle_f=4'd7;
reg [4:0] time_f_c;

always @ (posedge mem_clk or negedge rst_n)
begin
 if(rst_n==1'b0)
 begin
  local_read_req<=1'b0;
  local_burstbegin<=1'b0;
  rd_burst_data_valid<=1'b0;
  state<=idle;
  r_finish_c<=2'b0;
  rd_burst_finish<=1'b0;
  w_run_c<=3'b0;
  wr_burst_finish<=1'b0;
  wr_burst_data_rfifo<=1'b0;
  local_write_req<=1'b1;
  local_address<=25'b0;
  time_f_c<=5'b0;
 end
 else if(local_init_done==1'b1)
 begin
  case(state)
  
  idle:begin
  time_f_c<=5'b0;
  local_read_req<=1'b0;
  local_burstbegin<=1'b0;
  rd_burst_data_valid<=1'b0;
  r_finish_c<=2'b0;
  rd_burst_finish<=1'b0;
  w_run_c<=3'b0;
  wr_burst_finish<=1'b0;
  wr_burst_data_rfifo<=1'b0;
  local_write_req<=1'b1;
  local_address<=25'b0;
  wr_burst_data_req<=1'b0;
   if(wr_burst_req&local_ready)
   begin
    state<=w_lock;
	end
	else if(rd_burst_req&local_ready)
	begin
	 state<=r_lock;
	end
  end
  
  r_lock:begin
	r_addr<=rd_burst_addr;
	rd_burst_data_valid<=1'b1;
	state<=r_run;
  end
  
  r_run:begin
  rd_burst_data_valid<=1'b0;
  if(local_ready==1'b1)
  begin
   local_address<=r_addr;
   //local_size<=3'd4;
   local_burstbegin<=1'b1;
   local_read_req<=1'b1;
   state<=r_wait;
  end 
  end
  
  r_wait:begin
  local_burstbegin<=1'b0;
  local_read_req<=1'b0;
  if(local_rdata_valid&local_ready)//引入fifo中
  begin
   state<=r_finish;
  end
  end
  
  r_finish:begin
  if(r_finish_c==2'b10)
  begin
   rd_burst_finish<=1'b1;
	state<=idle;//
  end
  else if(local_ready)
  begin
   r_finish_c<=r_finish_c+2'b1;
  end
  end
  
  w_lock:begin
	local_address<=wr_burst_addr;
	wr_burst_data_rfifo<=1'b1;
	state<=w_run;
	wr_burst_data_req<=1'b1;
  end

  
  w_run:begin
  wr_burst_data_req<=1'b0;
  local_write_req<=1'b1;
   wr_burst_data_rfifo<=local_ready;
	
	if(w_run_c==3'b11)
	begin
	 local_write_req<=1'b0;
	 wr_burst_data_rfifo<=1'b0;
	 state<=idle;//
	 wr_burst_finish<=1'b1;
	end
	else if(local_ready)
	begin
	 w_run_c=w_run_c+3'd1;
	end
  end
  
  idle_f:begin
   if(time_f_c==5'b11111)
	begin
	 state<=idle;
	end
	if(local_ready==1'b1)
	begin
	 time_f_c<=time_f_c+5'b1;
	end
  end
  

  endcase
  
 end
end
endmodule





