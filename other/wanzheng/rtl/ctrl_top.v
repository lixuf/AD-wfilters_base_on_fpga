module ctrl_top(
input clk_150_0,
input clk_150_90,
input reset_1_50_0,

input w_req,//来自full
input r_req,//来自empty

output r_fifo_req,//8个时钟
output w_fifo_req,

input [15:0] w_fifo_data,//连续读8个，在请求信号之后的90°
output [15:0] r_fifo_data
);
endmodule
