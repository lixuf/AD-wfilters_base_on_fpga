module xb_top_2_grade(
input phy_clk_0,
input reset,
input [15:0] rd_data,
input data_in_read,

output [15:0] data_out_1_h,
output [15:0] data_out_1_l,
output [15:0] data_out_2h_h,
output [15:0] data_out_2h_l,
output [15:0] data_out_2l_h,
output [15:0] data_out_2l_l,

output reg finish,
output finish_g1
);



wire ready_g1;
assign finish_g1=ready_g1;
wire ready_g2_l;
wire ready_g2_h;
xb_2_top g1(
 .clk(phy_clk_0),
 .reset(reset),
 .data_in(rd_data),
 .data_in_read(data_in_read),
.data_out_1_h(data_out_1_h),
.data_out_1_l(data_out_1_l),
.ready(ready_g1),
.vaild(ready_g1)
);


xb_2_top g2_h(
 .clk(phy_clk_0),
 .reset(reset),
 .data_in(data_out_1_h),
 .data_in_read(ready_g1),
 
.data_out_1_h(data_out_2h_h),
.data_out_1_l(data_out_2h_l),
.ready(ready_g2_h),
.vaild(finish_flag)
);

xb_2_top g2_l( 
 .clk(phy_clk_0),
 .reset(reset),
 .data_in(data_out_1_l),
 .data_in_read(ready_g1),
 
.data_out_1_h(data_out_2l_h),
.data_out_1_l(data_out_2l_l),
.ready(ready_g2_l),
.vaild(finish_flag)
);
assign finish_flag=ready_g2_l&ready_g2_h;

always@(posedge phy_clk_0 or negedge reset)
begin
 if(~reset)
  finish<=1'b0;
 else if(finish_flag)
  finish<=1'b1;
end

endmodule
