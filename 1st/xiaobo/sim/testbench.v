`timescale 1ns/1ps

module testbench;

reg clk;
reg reset;

always #10 clk=~clk;//50Mhz

initial begin
$stop;
clk=0;
reset=0;
#10000
#10000000
#10000000
#10000000
$stop;
end

reg [15:0] men_in;
reg men_vaild;
initial begin
men_in=16'b0;
men_vaild=1'b1;
end

always @ (posedge clk)
begin
 men_in<=men_in+1;
end

wire out_ready;
wire [63:0] out_data;
reg out_vaild;
initial begin
out_vaild=1'b1;
end


top_xiaobo top_xiaobotest(
.clk_50(clk),
.reset_in(reset),

.ad_data(men_in),
.ad_vaild(men_vaild),

.out_vaild(out_vaild),
.out_ready(out_ready),
.out_data(out_data)
);

endmodule
