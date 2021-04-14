`timescale 1ns/1ps
//寄存器都是0复位
//其他一般为1复位
module testbench;
reg clk;
reg reset;
reg [15:0] ad_data;
reg ad_busy;
reg first_data;
reg start;

//test
wire empty;
wire full;
wire [31:0] data_ar;
reg rdreq_ar;
wire clk_50_0;
wire clk_50_90;
wire clk_150_90;
wire clk_150_0;
wire reset_1_50_0;
wire reset_1_50_90;
wire outflag;
wire ad_reset;


top u11(
.clk(clk),
.reset(reset),
.ad_data(ad_data),
.ad_busy(ad_busy),
.first_data(first_data),
.start(start),

//test
.empty_ar(empty),
.full_ar(full),
.data_ar(data_ar),
.rdreq_ar(rdreq_ar),
.clk_50_0(clk_50_0),
.clk_50_90(clk_50_90),
.clk_150_90(clk_150_90),
.clk_150_0(clk_150_0),
.reset_1_50_0(reset_1_50_0),
.reset_1_50_90(reset_1_50_90),
. data_flag(dataflag),
. ad_reset(ad_reset)

);


initial begin
$stop;
clk<=1'b0;
reset<=1'b1;
ad_data<=16'b0;
ad_busy<=1'b0;
first_data<=1'b0;
start<=1'b0;
rdreq_ar=1'b0;
end

always #10 clk=~clk;

initial begin
#20
start<=1'b1;
#100000
reset<=1'b0;
#10
reset<=1'b1;
end

reg state_ad=1'b0;
always @(posedge clk_50_0)
begin
 case(state_ad)
 1'b0:begin
  
  if(ad_reset==0)
   state_ad<=1'b1;
 end
 1'b1:begin
  ad_busy<=1'b0;
  if(dataflag==1'b1)
   ad_data<=ad_data+1;
 end
 endcase

end


reg sta=1'b0;
reg [2:0] stat=3'b00;
always @(posedge clk_150_0)
begin
 case(sta)
 1'b0:begin
 if(full==1'b1)
  begin 
  sta<=1'b1;
  rdreq_ar<=1'b0;
  end
 end
 1'b1:begin
 if(stat==3'b101)
 begin
  stat<=3'b000;
  sta<=1'b0;
  rdreq_ar<=1'b0;
 end
 else
  begin
  stat<=stat+3'b001;
  rdreq_ar<=1'b1;
  end
 end
 endcase
end
 
  


   
 

endmodule 
  
