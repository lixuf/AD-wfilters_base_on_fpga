module uart(
input phy_clk,
input clk_50_0,
input reset_ayn,

input [15:0] datain,
input wrreq,
output wrfull,
output tx//uart发送接口
);

clkdiv clk_uart(clk_50_0, reset_ayn, clkout);

wire rdempty;
wire datain_uart;
reg rdreq;
always@(posedge clkout or negedge reset_ayn)
begin
 if(~reset_ayn)
  rdreq<=1'b0;
 else if(idle_uart|rdreq)
  rdreq<=1'b0;
 else if(~rdempty)
  rdreq<=1'b1;
end

reg wrsig;
always@(posedge clkout or negedge reset_ayn)
begin
 if(~reset_ayn)
  wrsig<=1'b0;
 else if(rdreq)
  wrsig<=1'b1;
 else
  wrsig<=1'b0;
end

fifo_1667_50 fifo_1667_50_1(
	.data(datain),
	.rdclk(clkout),
	.rdreq(rdreq),
	.wrclk(phy_clk),
	.wrreq(wrreq),
	.q(datain_uart),
	.rdempty(rdempty),
	.wrfull(wrfull)
	);


	
uarttx uart_out(clkout, reset_ayn, datain_uart,wrsig,idle_uart,tx);
endmodule
