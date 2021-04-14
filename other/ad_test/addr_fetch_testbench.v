`timescale 1ns/1ps
module addr_fetch_testbench;
reg clk;
reg st;
initial
begin
clk<=1'b0;
st<=1'b0;
#1000
st<=1'b1;
end
always#1 clk<=~clk&st;




reg rd_addr_up;
reg wr_addr_up;
reg frist_block;
wire [24:0] rd_addr;
wire [24:0] wr_addr;
wire read_en;
reg reset;
addr_fetch addr_f(
   .reset(reset),
	.clk(clk),
	
	.rd_addr_up(rd_addr_up),//地址自增信号，来自mem brush
	.wr_addr_up(wr_addr_up),//严格控制 自增时才为1
	
	.frist_block(frist_block),//表示刚刚开始写，等该信号为1才可开始读
	
 	.rd_addr(rd_addr),
	.wr_addr(wr_addr),
	.read_en(read_en)
	);
	

reg [3:0] cnt;
initial begin
rd_addr_up<=1'b0;
wr_addr_up<=1'b0;
frist_block<=1'b1;
reset<=1'b1;
cnt<=4'b0;
end

initial
begin
#2
reset<=1'b0;
#20
reset<=1'b1;
end
reg st2;
reg st3;
initial
begin
 st2<=1'b0;
 st3<=1'b1;
 #1
 $stop;
 rd_addr_up<=1'b1;
 wr_addr_up<=1'b1;
 #654396
 $stop;
 frist_block<=1'b0;
 #1000
 $stop;
 wr_addr_up<=1'b0;
 rd_addr_up<=1'b1;
 #654396
 $stop;
 wr_addr_up<=1'b1;
 rd_addr_up<=1'b0;
 #654396
 st2<=1'b1;
 $stop;
  wr_addr_up<=1'b1;
 rd_addr_up<=1'b1;
 #654396;
 $stop;
end

reg wr_a;
reg rd_a;
always @(posedge clk)
begin
 if(wr_addr[18])
  wr_a<=1'b1;
 else
  wr_a<=1'b0;
 if(rd_addr[18])
  rd_a<=1'b1;
 else
  rd_a<=1'b0;
end


endmodule

 
 