module ddr(
input clk_150_0,
input burstbegin,
input write_req,
output read_req,
input [9:0] addr,
input [15:0] w_data,
output [15:0] r_data,
output rdata_vaild
);

endmodule
