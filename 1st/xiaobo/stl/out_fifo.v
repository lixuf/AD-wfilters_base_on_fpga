`include "gen_defines.v"
module out_fifo(
output r_o_vaild,
input r_o_ready,
input [`rdata_width-1:0] rdata,

input clk,
input reset,

input filter_vaild,
output filter_ready,
output [`rdata_width-1:0] filter_data

);

wire fifo_full;
wire fifo_empty;

//与RAM
assign r_o_vaild=~fifo_full;
wire ram_hsk=r_o_vaild&r_o_ready;

//与小波滤波器
assign filter_ready=~fifo_empty;
wire filter_hsk=filter_vaild&filter_ready;

//fifo

fifo_64_fe fifo_64_out(
	.clock(clk),
	.data(rdata),
	.rdreq(filter_hsk),
	.wrreq(ram_hsk),
	.full(fifo_full),
	.empty(fifo_empty),
	.q(filter_data)
	);
	
endmodule
