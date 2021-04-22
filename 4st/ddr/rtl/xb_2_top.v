module xb_2_top(
input clk,
input reset,
input [15:0]data_in,
input data_in_read,//写入有效信号
output [15:0] data_out_1_h,
output [15:0] data_out_1_l,
output reg ready,//输出使能
input vaild
);


//分开奇偶
reg cnt;
reg data_in_readyh1;
reg data_in_readyh2;
reg data_in_readyl1;
reg data_in_readyl2;
always@(posedge clk or negedge reset)
begin
 if(~reset)
 begin
  cnt<=1'b0;
  data_in_readyh1<=1'b0;
  data_in_readyh2<=1'b0;
  data_in_readyl1<=1'b0;
  data_in_readyl2<=1'b0;
 end
 else if(cnt==1'b0&data_in_read)//奇数,低通分解 高通重构
 begin
  data_in_readyh1<=1'b1;
  data_in_readyh2<=1'b0;
  data_in_readyl1<=1'b1;
  data_in_readyl2<=1'b0;
  cnt<=1'b1;
  end
 else if(cnt==1'b1&data_in_read)//偶数,高通分解 低通重构
 begin
   data_in_readyh1<=1'b0;
  data_in_readyh2<=1'b1;
  data_in_readyl1<=1'b0;
  data_in_readyl2<=1'b1;
  cnt<=1'b0;
  end
 else begin
  data_in_readyh1<=1'b0;
  data_in_readyh2<=1'b0;
  data_in_readyl1<=1'b0;
  data_in_readyl2<=1'b0;
 end
end


wire data_out_flagh2;
wire data_out_flagl2;
wire data_out_flagh1;
wire data_out_flagl1;
wire [27:0] data_outh1;
wire [27:0] data_outh2;
wire [27:0] data_outl1;
wire [27:0] data_outl2;
high lb_h_1_1(
  .clk(clk),
  .reset(reset),
 
  .data_in(data_in),
  .data_in_ready(data_in_readyh1),

 
  .data_out(data_outh1),
  .data_out_flag(data_out_flagh1)
  );
  
  
high lb_h_2_1(
  .clk(clk),
  .reset(reset),
 
  .data_in(data_in),
  .data_in_ready(data_in_readyh2),
 
  .data_out(data_outh2),
  .data_out_flag(data_out_flagh2)
  );
  
  
low lb_l_1_1(
  .clk(clk),
  .reset(reset),
 
  .data_in(data_in),
  .data_in_ready(data_in_readyl1),

  .data_out(data_outl1),
  .data_out_flag(data_out_flagl1)
  );
  
  
low lb_l_2_1(
  .clk(clk),
  .reset(reset),
 
  .data_in(data_in),
  .data_in_ready(data_in_readyl2),
 
  .data_out(data_outl2),
  .data_out_flag(data_out_flagl2)
  );
  





//wire [15:0] data_out_1_h;
//wire [15:0] data_out_1_l;
add_end addh(
.data1(data_outh1),
.data2(data_outh2),
.datao(data_out_1_h)
 );
 
add_end addl(
.data1(data_outl1),
.data2(data_outl2),
.datao(data_out_1_l)
);

reg data_out_flagh2_o;
reg data_out_flagl2_o;
reg data_out_flagh1_o;
reg data_out_flagl1_o;
always @(posedge clk or negedge reset)
begin
 if((~reset))
 begin
  data_out_flagh2_o<=1'b0;
  data_out_flagl2_o<=1'b0;
  data_out_flagh1_o<=1'b0;
  data_out_flagl1_o<=1'b0;
 end
 else if(vaild)
  begin
  data_out_flagh2_o<=1'b0;
  data_out_flagl2_o<=1'b0;
  data_out_flagh1_o<=1'b0;
  data_out_flagl1_o<=1'b0;
 end
 else begin
 if(data_out_flagh2)
 data_out_flagh2_o<=1'b1;
 if(data_out_flagl2)
 data_out_flagl2_o<=1'b1;
 if(data_out_flagh1)
 data_out_flagh1_o<=1'b1;
 if(data_out_flagl1)
 data_out_flagl1_o<=1'b1;
 end
end


always @(posedge clk or negedge reset)
begin
 if(~reset)
  ready<=1'b0;
 else if(data_out_flagl1_o&data_out_flagh1_o&data_out_flagl2_o&data_out_flagh2_o)
  ready<=1'b1;
 else
  ready<=1'b0;
end

endmodule


