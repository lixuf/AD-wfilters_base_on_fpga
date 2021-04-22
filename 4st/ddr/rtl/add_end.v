module add_end(
input [27:0] data1,
input [27:0] data2,
output [15:0] datao
);

wire [28:0] data1t=data1[19]?{1'b1,~data1+20'b1}:{1'b0,data1};
wire [28:0] data2t=data2[19]?{1'b1,~data2+20'b1}:{1'b0,data2};
wire [28:0] dataot=data1t+data2t;
wire [15:0] dataott=dataot[28:13];
assign datao=dataott[15]?{1'b1,~dataott[14:0]+15'b1}:dataott;

endmodule
