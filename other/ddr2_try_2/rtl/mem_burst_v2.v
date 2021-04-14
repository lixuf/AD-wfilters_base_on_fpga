/*本模块完成对ddr2 IP的包装，方便后续模块使用，也方便程序的移植，如果更换平台，更新这个文件即可
*/
module mem_burst_v2
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
	output rd_burst_data_valid,                  /*读出数据有效*/
	output wr_burst_data_req,                    /*写数据信号*/
	output[MEM_DATA_BITS - 1:0] rd_burst_data,   /*读出的数据*/
	input[MEM_DATA_BITS - 1:0] wr_burst_data,    /*写入的数据*/
	output rd_burst_finish,                      /*读完成*/
	output wr_burst_finish,                      /*写完成*/
	output burst_finish,                         /*读或写完成*/

	///////////////////
	/*一下是altera ddr2 IP的接口，可参考altera相关文档*/
	input local_init_done,
	output ddr_rst_n,
	input local_ready,
	output  local_burstbegin,
	output[MEM_DATA_BITS - 1:0] local_wdata,
	input local_rdata_valid,
	input[MEM_DATA_BITS - 1:0] local_rdata,
	output  local_write_req,
	output  local_read_req,
	output reg[23:0] local_address,
	output[MEM_DATA_BITS/8 - 1:0] local_be,
	output reg[LOCAL_SIZE_BITS - 1:0] local_size,
	output [2:0] state_out,
	output last_wr_burst_data_req_out
);

parameter IDLE = 3'd0;
parameter MEM_READ = 3'd1;
parameter MEM_READ_WAIT = 3'd2;
parameter MEM_WRITE  = 3'd3;
parameter MEM_WRITE_BURST_BEGIN = 3'd4;
parameter MEM_WRITE_FIRST = 3'd5;
parameter burst_size = 10'd4;             
reg[2:0] state = 3'd0;
reg[2:0] next_state = 3'd0;	
reg[9:0] rd_addr_cnt = 10'd0;
reg[9:0] rd_data_cnt = 10'd0;

reg[9:0] length = 10'd0;
reg[11:0] cnt_timer = 12'd0;
reg[11:0] ddr_reset_timer = 12'd0;
reg ddr_rst_n_reg = 1'b1;


reg [LOCAL_SIZE_BITS - 1:0] burst_remain;
reg last_wr_burst_data_req;
reg[9:0] wr_remain_len;
/*数据变化的条件*/
assign wr_burst_data_req = (state == MEM_WRITE_FIRST ) || ( 
                                                          (
																			 (state == MEM_WRITE_BURST_BEGIN) 
																			 ||  (state == MEM_WRITE)
																			 ) 
																			 && local_ready && ~last_wr_burst_data_req 
																			 );
assign local_write_req = ((state == MEM_WRITE_BURST_BEGIN) ||  (state == MEM_WRITE));
assign burst_finish = rd_burst_finish | wr_burst_finish;
always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		cnt_timer <= 12'd0;
	else if(state == IDLE || ~local_init_done)
		cnt_timer <= 12'd0;
	else
		cnt_timer <= cnt_timer + 12'd1;
end

always@(posedge mem_clk or negedge rst_n)
begin
	if(~rst_n)
		ddr_reset_timer <= 12'd0;
	else if(state == MEM_READ_WAIT)
		ddr_reset_timer <= ddr_reset_timer + 12'd1;
	else
		ddr_reset_timer <= 12'd0;	
	ddr_rst_n_reg <= (ddr_reset_timer !=12'd200);
end
assign ddr_rst_n = ddr_rst_n_reg;


always@(posedge	mem_clk or negedge rst_n)
	begin
		if(~rst_n)
			state <= IDLE;
		else if(~local_init_done )
			state <= IDLE;
		else
			state <= next_state;
	end
	
	
always@(*)
	begin
		case(state)
			IDLE:
				begin
					if(rd_burst_req && rd_burst_len != 10'd0)         /*接收到burst读请求*/
						next_state <= MEM_READ;
					else if(wr_burst_req && wr_burst_len != 10'd0)    /*接收到burst写请求*/
						next_state <= MEM_WRITE_FIRST;
					else
						next_state <= IDLE;
				end
			MEM_READ:                         /*burst读命令*/
				begin
					if( (rd_addr_cnt + burst_size >= length) && local_read_req && local_ready)
						next_state <= MEM_READ_WAIT;
					else
						next_state <= MEM_READ;
				end
			MEM_READ_WAIT:                   /*等待burst数据读完成*/
				begin 
					if(rd_data_cnt == length - 10'd1 && local_rdata_valid)
						next_state <= IDLE;
					else
						next_state <= MEM_READ_WAIT;
				end
			MEM_WRITE_FIRST:                /*第一次写状态, 用于准备写入的数据*/
				next_state <= MEM_WRITE_BURST_BEGIN;
			MEM_WRITE_BURST_BEGIN:         /*产生burst begin信号*/                      
				begin
					if(local_ready && wr_remain_len == 10'd1)     /*外部Burst写结束*/
						next_state <= IDLE;
					else if(burst_remain == 1 && local_ready)     /*一次local burst写完成*/   
						next_state <= MEM_WRITE_BURST_BEGIN;
					else if(local_ready)
						next_state <= MEM_WRITE;
					else
						next_state <= MEM_WRITE_BURST_BEGIN;
				end
			MEM_WRITE:
				begin
					if(wr_remain_len == 10'd1 && local_ready)     /*外部Burst写结束*/
						next_state <= IDLE;
					else if(burst_remain == 1 && local_ready)     /*一次local burst写完成*/   
						next_state <= MEM_WRITE_BURST_BEGIN;
					else 
						next_state <= MEM_WRITE;
				end
			default:
				next_state <= IDLE;
		endcase
	end
	assign local_burstbegin = ((state == MEM_WRITE_BURST_BEGIN) ||  (state == MEM_READ));

always@(posedge	mem_clk)
	begin
		if(state == MEM_WRITE_BURST_BEGIN || state == MEM_WRITE)
			if(wr_remain_len == 10'd2 && local_ready)
				last_wr_burst_data_req <= 1'b1;
			else
				last_wr_burst_data_req <= last_wr_burst_data_req;
		else
			last_wr_burst_data_req <= 1'b0;
	end
	
/*计算外部burst写的剩余数据长度*/
always@(posedge	mem_clk)
	begin
		case(state)
			IDLE:
				if(wr_burst_req)
					wr_remain_len <= wr_burst_len;
				else
					wr_remain_len <= wr_remain_len;
			MEM_WRITE_BURST_BEGIN:
				if(local_ready)
					wr_remain_len <= wr_remain_len - 10'd1;
				else
					wr_remain_len <= wr_remain_len;
			MEM_WRITE:
				if(local_ready)
					wr_remain_len <= wr_remain_len - 10'd1;
				else
					wr_remain_len <= wr_remain_len;
			default:
				wr_remain_len <= wr_remain_len;
		endcase
	end

/*计算一次local burst的剩余数*/	
always@(posedge	mem_clk)
	begin
		if(next_state == MEM_WRITE_BURST_BEGIN)
			burst_remain <= burst_size;
		else if( ((state == MEM_WRITE_BURST_BEGIN) || (state == MEM_WRITE)) && local_ready)      /*一次数据写入有效*/
			burst_remain <= burst_remain - 1;
		else
			burst_remain <= burst_remain;
	end	
	
/*计算local size*/	
always@(posedge	mem_clk)
	begin
		if(state == IDLE && rd_burst_req)
			local_size <= (rd_burst_len >= burst_size) ?  burst_size : rd_burst_len ;
		else if(state == IDLE && wr_burst_req)
			local_size <= (wr_burst_len >= burst_size) ?  burst_size : wr_burst_len;
		else if(state == MEM_WRITE && (next_state == MEM_WRITE_BURST_BEGIN))
			if((wr_remain_len - 1) > burst_size)
				local_size <= burst_size;
			else
				local_size <= wr_remain_len - 1;
		else if(state == MEM_WRITE_BURST_BEGIN && (next_state == MEM_WRITE_BURST_BEGIN) && local_ready)
			if((wr_remain_len - 1) > burst_size)
				local_size <= burst_size;
			else
				local_size <= wr_remain_len - 1;
		else if(state == MEM_READ && local_ready )
			local_size <= (rd_addr_cnt + burst_size > length) ? 1 : burst_size;
		else
			local_size <= local_size;
	end

/*计算地址*/
always@(posedge	mem_clk)
	begin
		case(state)
			IDLE:
				begin
					if(rd_burst_req)
						begin
							local_address <= rd_burst_addr;
							rd_addr_cnt <= 10'd0;
						end
					else if(wr_burst_req)
						begin
							local_address <= wr_burst_addr;
							rd_addr_cnt <= 10'd0;
						end
					else
						begin
							local_address <= local_address;
							rd_addr_cnt <= 10'd0;
						end
				end
			MEM_READ:
				begin
					if(local_ready)
						begin
							local_address <= local_address + {14'd0,burst_size};   /*Bust读,地址加burst_size*/
							rd_addr_cnt <= rd_addr_cnt + burst_size;
						end
					else
						begin
							local_address <= local_address;
							rd_addr_cnt <= rd_addr_cnt;
						end		
				end
			MEM_WRITE_BURST_BEGIN:
				begin
					if(local_ready && (next_state == MEM_WRITE_BURST_BEGIN))
						begin
							local_address <= local_address + {14'd0,burst_size};
						end
					else
						begin
							local_address <= local_address;
						end	
				end	
			MEM_WRITE: 
				begin
					if(local_ready && (next_state == MEM_WRITE_BURST_BEGIN))
						begin
							local_address <= local_address + {14'd0,burst_size};
						end
					else
						begin
							local_address <= local_address;
						end	
				end
			default:
				begin
					local_address <= local_address;
					rd_addr_cnt <= 10'd0;
				end
		endcase
	end
	
always@(posedge	mem_clk)
	begin
		if(state == IDLE && rd_burst_req)
			length <= rd_burst_len;
		else
			length <= length; 
	end
	
/*统计读出的数据*/
always@(posedge	mem_clk)
	begin
		if(state == MEM_READ || state == MEM_READ_WAIT)
			if(local_rdata_valid)
				rd_data_cnt <= rd_data_cnt + 10'd1;
			else
				rd_data_cnt <= rd_data_cnt;
		else
			rd_data_cnt <= 10'd0;
	end

assign rd_burst_data_valid = local_rdata_valid;
assign rd_burst_data = local_rdata;
assign local_wdata = wr_burst_data;
assign local_read_req = (state == MEM_READ);
assign rd_burst_finish = (state == MEM_READ_WAIT) && (next_state == IDLE);
assign wr_burst_finish = (local_ready && wr_remain_len == 10'd1);
assign local_be = {MEM_DATA_BITS/8{1'b1}};


assign state_out=state;
endmodule 