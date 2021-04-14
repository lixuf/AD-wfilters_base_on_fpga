`timescale 1ns/1ps
module testbench;
reg clk_50;
reg pll_reset;
initial begin
clk_50<=1'b0;

end
always #10 clk_50<=~clk_50;
wire clk_50_90;
wire clk_150_0;
wire clk_150_90;
wire clk_50_0;







reg [1:0] state=2'b00;
reg [3:0] wait_4=4'b000;
reg wreq=1'b0;
reg rreq=1'b0;
reg [15:0] w_data=15'b0;
always @(posedge clk_50_0)
begin
 case(state)
 2'b00:begin
  if(wait_4==4'b1000)
   begin
	 wait_4<=4'b000;
	 state<=2'b01;
	end
  else
   wait_4=wait_4+4'b001;
  end
  2'b01:begin
  if(wait_4==4'b1000)
   begin
	 wait_4<=4'b000;
	 state<=2'b10;
	 wreq<=1'b0;
	end
  else
   begin
	 wreq<=1'b1;
	 w_data<=w_data+15'd1;
	 wait_4<=wait_4+4'b001;
   end
  end
  2'b10:begin
  if(wait_4==4'b1000)
   begin
	 wait_4<=4'b000;
	 state<=2'b11;
	end
  else
   wait_4=wait_4+4'b001;
  end
  2'b11:begin
  if(wait_4==4'b1000)
   begin
	 wait_4<=4'b000;
	 state<=2'b00;
	 rreq<=1'b0;
	end
  else
   begin
	 wait_4<=wait_4+4'b001;
   end 
	end
  default:begin
	state<=2'b00;
   wait_4<=4'b000;
  end
  endcase
end

reg [3:0] count=4'b0;
always @(posedge clk_150_0)
begin
 if(state==2'b11)
 begin
  if(count==4'b1000)
   begin
	 state<=2'b10;
    wait_4<=4'b0;
	 count<=4'b0;
	 rreq<=1'b0;
	end
 else
 begin
  rreq<=1'b1;
  count=count+4'b0001;
  end
 end
end


reg aclr=1'b0;
initial begin
pll_reset<=1'b1;
#30
pll_reset<=1'b0;
#1000000
aclr<=1'b1;
#1
aclr<=1'b0;
#100
aclr<=1'b1;
#10
aclr<=1'b0;
end

wire [15:0] data_out;
wire rempty;
wire wempty;
wire rfull;
wire wfull;
wire [2:0] ruse;
wire [2:0] wuse;

top top11(
	.aclr(aclr),
	.data(w_data),
	.rdclk(clk_150_90),
	.rdreq(rreq),
	.wrclk(clk_50_90),
	.wrreq(wreq),
	.q(data_out),
	.rdempty(rempty),
	.rdfull(rfull),
	.rdusedw(ruse),
	.wrempty(wempty),
	.wrfull(wfull),
	.wrusedw(wuse),
	.clk_50(clk_50),
	.clk_50_0(clk_50_0),
	.clk_150_0(clk_150_0),
	.clk_150_90(clk_150_90),
	.clk_50_90(clk_50_90),
	.pll_reset(pll_reset)
	);
	
endmodule
