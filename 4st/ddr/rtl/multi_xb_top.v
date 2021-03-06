module multi_xb_top(
input [31:0] data,
input phy_clk_0,
input phy_clk_90,
input reset,
input wrreq,
output wrempty,
output rdfull,

//sim
//sim
output out_c_t,
output [15:0] reg_0_t,
output [3:0] cnt_t,
output [15:0] rd_data,
output rd_req_t,
output data_in_read_t,
//输出
output [15:0] data_out_1_h0,
output [15:0] data_out_1_l0,
output [15:0] data_out_2h_h0,
output [15:0] data_out_2h_l0,
output [15:0] data_out_2l_h0,
output [15:0] data_out_2l_l0,
output finish0,
output finish_g10,
output [15:0] data_out_1_h1,
output [15:0] data_out_1_l1,
output [15:0] data_out_2h_h1,
output [15:0] data_out_2h_l1,
output [15:0] data_out_2l_h1,
output [15:0] data_out_2l_l1,
output finish1,
output finish_g11,
output [15:0] data_out_1_h2,
output [15:0] data_out_1_l2,
output [15:0] data_out_2h_h2,
output [15:0] data_out_2h_l2,
output [15:0] data_out_2l_h2,
output [15:0] data_out_2l_l2,
output finish2,
output finish_g12,
output [15:0] data_out_1_h3,
output [15:0] data_out_1_l3,
output [15:0] data_out_2h_h3,
output [15:0] data_out_2h_l3,
output [15:0] data_out_2l_h3,
output [15:0] data_out_2l_l3,
output finish3,
output finish_g13,
output [15:0] data_out_1_h4,
output [15:0] data_out_1_l4,
output [15:0] data_out_2h_h4,
output [15:0] data_out_2h_l4,
output [15:0] data_out_2l_h4,
output [15:0] data_out_2l_l4,
output finish4,
output finish_g14,
output [15:0] data_out_1_h5,
output [15:0] data_out_1_l5,
output [15:0] data_out_2h_h5,
output [15:0] data_out_2h_l5,
output [15:0] data_out_2l_h5,
output [15:0] data_out_2l_l5,
output finish5,
output finish_g15,
output [15:0] data_out_1_h6,
output [15:0] data_out_1_l6,
output [15:0] data_out_2h_h6,
output [15:0] data_out_2h_l6,
output [15:0] data_out_2l_h6,
output [15:0] data_out_2l_l6,
output finish6,
output finish_g16,
output [15:0] data_out_1_h7,
output [15:0] data_out_1_l7,
output [15:0] data_out_2h_h7,
output [15:0] data_out_2h_l7,
output [15:0] data_out_2l_h7,
output [15:0] data_out_2l_l7,
output finish7,
output finish_g17
);

reg data_in_read[7:0];
assign data_in_read_t=data_in_read[7];
wire [15:0] data_out_1_h[7:0];
wire [15:0]data_out_1_l[7:0];
wire [15:0]data_out_2h_h[7:0];
wire [15:0]data_out_2h_l[7:0];
wire [15:0]data_out_2l_h[7:0];
wire [15:0]data_out_2l_l[7:0];
wire finish[7:0];
wire finish_g1[7:0];
assign data_out_1_h0=data_out_1_h[0];
assign data_out_1_l0=data_out_1_l[0];
assign data_out_2h_h0=data_out_2h_h[0];
assign data_out_2h_l0=data_out_2h_l[0];
assign data_out_2l_h0=data_out_2l_h[0];
assign data_out_2l_l0=data_out_2l_l[0];
assign finish0=finish[0];
assign finish_g10=finish_g1[0];
assign data_out_1_h1=data_out_1_h[1];
assign data_out_1_l1=data_out_1_l[1];
assign data_out_2h_h1=data_out_2h_h[1];
assign data_out_2h_l1=data_out_2h_l[1];
assign data_out_2l_h1=data_out_2l_h[1];
assign data_out_2l_l1=data_out_2l_l[1];
assign finish1=finish[1];
assign finish_g11=finish_g1[1];
assign data_out_1_h2=data_out_1_h[2];
assign data_out_1_l2=data_out_1_l[2];
assign data_out_2h_h2=data_out_2h_h[2];
assign data_out_2h_l2=data_out_2h_l[2];
assign data_out_2l_h2=data_out_2l_h[2];
assign data_out_2l_l2=data_out_2l_l[2];
assign finish2=finish[2];
assign finish_g12=finish_g1[2];
assign data_out_1_h3=data_out_1_h[3];
assign data_out_1_l3=data_out_1_l[3];
assign data_out_2h_h3=data_out_2h_h[3];
assign data_out_2h_l3=data_out_2h_l[3];
assign data_out_2l_h3=data_out_2l_h[3];
assign data_out_2l_l3=data_out_2l_l[3];
assign finish3=finish[3];
assign finish_g13=finish_g1[3];
assign data_out_1_h4=data_out_1_h[4];
assign data_out_1_l4=data_out_1_l[4];
assign data_out_2h_h4=data_out_2h_h[4];
assign data_out_2h_l4=data_out_2h_l[4];
assign data_out_2l_h4=data_out_2l_h[4];
assign data_out_2l_l4=data_out_2l_l[4];
assign finish4=finish[4];
assign finish_g14=finish_g1[4];
assign data_out_1_h5=data_out_1_h[5];
assign data_out_1_l5=data_out_1_l[5];
assign data_out_2h_h5=data_out_2h_h[5];
assign data_out_2h_l5=data_out_2h_l[5];
assign data_out_2l_h5=data_out_2l_h[5];
assign data_out_2l_l5=data_out_2l_l[5];
assign finish5=finish[5];
assign finish_g15=finish_g1[5];
assign data_out_1_h6=data_out_1_h[6];
assign data_out_1_l6=data_out_1_l[6];
assign data_out_2h_h6=data_out_2h_h[6];
assign data_out_2h_l6=data_out_2h_l[6];
assign data_out_2l_h6=data_out_2l_h[6];
assign data_out_2l_l6=data_out_2l_l[6];
assign finish6=finish[6];
assign finish_g16=finish_g1[6];
assign data_out_1_h7=data_out_1_h[7];
assign data_out_1_l7=data_out_1_l[7];
assign data_out_2h_h7=data_out_2h_h[7];
assign data_out_2h_l7=data_out_2h_l[7];
assign data_out_2l_h7=data_out_2l_h[7];
assign data_out_2l_l7=data_out_2l_l[7];
assign finish7=finish[7];
assign finish_g17=finish_g1[7];
//wire [15:0] rd_data;sim
genvar i;
generate //改
 for(i=0;i<8;i=i+1)
 begin:verr1
  xb_top_2_grade  lv_11(
   .phy_clk_0(phy_clk_0),
   .reset(reset),
   .rd_data(rd_data),
   .data_in_read(data_in_read[i]),//写入有效信号
	.data_out_1_h(data_out_1_h[i]),
.data_out_1_l(data_out_1_l[i]),
.data_out_2h_h(data_out_2h_h[i]),
.data_out_2h_l(data_out_2h_l[i]),
.data_out_2l_h(data_out_2l_h[i]),
.data_out_2l_l(data_out_2l_l[i]),

.finish(finish[i]),
.finish_g1(finish_g1[i])
);
 
 end
endgenerate



reg rdreq;
assign rd_req_t=rdreq;
//wire rdfull;sim

fifo_1667_1667 fifo_1667_166711(
	.data(data),
	.rdclk(phy_clk_90),
	.rdreq(rdreq),
	.wrclk(phy_clk_90),
	.wrreq(wrreq),
	.q(rd_data),
	.rdfull(rdfull),
	.wrempty(wrempty)
	);
	
reg [3:0] cnt;
assign cnt_t=cnt;
reg read_fifo;
always @(posedge phy_clk_0 or negedge reset)
begin
 if(~reset)
  cnt<=4'b0;
 else if(cnt==4'b1000)
  cnt<=4'b0;
 else if(read_fifo)
  cnt<=cnt+4'b1;
end
always@(posedge phy_clk_0 or negedge reset)
begin
 if(~reset)
  read_fifo<=1'b0;
 else if(rdfull)
  read_fifo<=1'b1;
 else if(cnt==4'b1000)
  read_fifo<=1'b0;
end

always@(posedge phy_clk_0 )
begin
 if(read_fifo)
 case(cnt)
 4'b0000:begin
 rdreq<=1'b0;
 data_in_read[0]<=1;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0001:begin
 rdreq<=1'b1;
 data_in_read[0]<=0;
 data_in_read[1]<=1;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0010:begin
 rdreq<=1'b1;
 data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=1;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0011:begin
 rdreq<=1'b1;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=1;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0100:begin
 rdreq<=1'b1;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=1;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0101:begin
 rdreq<=1'b1;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=1;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 4'b0110:begin
 rdreq<=1'b1;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=1;
 data_in_read[7]<=0;
 end
 
 4'b0111:begin
 rdreq<=1'b1;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=1;
 end
 
 4'b1000:begin
 rdreq<=1'b1;
   data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
 default:begin
 rdreq<=1'b0;
  data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 endcase
 else
 begin
  rdreq<=1'b0;
 data_in_read[0]<=0;
 data_in_read[1]<=0;
 data_in_read[2]<=0;
 data_in_read[3]<=0;
 data_in_read[4]<=0;
 data_in_read[5]<=0;
 data_in_read[6]<=0;
 data_in_read[7]<=0;
 end
 
end

endmodule

