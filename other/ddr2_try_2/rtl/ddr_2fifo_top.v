/*-------------------------------------------------------------------------
Filename			:		ddr_2fifo_top.v
Description		:		ddr read and write with fifo controller.
==========================================================================*/
`timescale 1ns/1ns
module	ddr_2fifo_top
(
	//global clock
	input         source_clk,	     //ddr reference clock
	input			  clk_read,			  //fifo data read clock	
	input			  clk_write,		  //fifo data write clock	
	
	input         rst_n,	
   output        ddr_init_done,    //ddr initial done	
	
	//ddr control
   output  [ 14: 0] mem_addr,			//ddr address
   output  [  2: 0] mem_ba,			//ddr bank address
   output           mem_cas_n,		//ddr column address strobe
   output  [  0: 0] mem_cke,		   //ddr clock enable
   inout   [  0: 0] mem_clk,		   //ddr positive clock
   inout   [  0: 0] mem_clk_n, 	   //ddr negative clock  
   output  [  0: 0] mem_cs_n,			//ddr chip select
   output  [  1: 0] mem_dm,	      //ddr data enable (H:8)
   inout   [ 15: 0] mem_dq,         //ddr data
   inout   [  1: 0] mem_dqs,        //ddr data clock
   output  [  0: 0] mem_odt,        //ddr On-Die Termination
   output           mem_ras_n,		//ddr row address strobe
   output           mem_we_n,  		//ddr write enable
	
	//user interface
	output			  frame_write_done,	//ddr write one frame
	output			  frame_read_done,	//ddr read one frame
	input				  sys_we,				//fifo write enable
	input	  [ 31: 0] sys_data_in,		   //fifo data input
	input				  sys_rd,				//fifo read enable
	output  [ 31: 0] sys_data_out,		//fifo data output
	input            wr_load,           //ddr write address reset
	input            rd_load,           //ddr read address reset
	input				  data_valid			//system data output enable		
);

//-----------------------------------------------
wire			   wr_burst_req;				//ddr write request
wire	[24:0]	wr_burst_addr;				//ddr write address 
wire           wr_burst_data_req;      //ddr write data request
wire  [31:0]   wr_burst_data;	    	   //fifo 2 ddr data input	
wire           wr_burst_finish;        //ddr write burst finish	

wire           rd_burst_req;	         //ddr read request
wire  [24:0]   rd_burst_addr;          //ddr read address
wire           rd_burst_data_valid;    //ddr read data valid
wire  [31:0]   rd_burst_data;  	      //ddr 2 fifo data input
wire           rd_burst_finish;        //ddr read burst finish	

wire  [9:0]   wr_burst_len;            //ddr write burst length
wire  [9:0]   rd_burst_len;  		      //ddr read burst length

//------------------------------------------------
//ddr control module instantiation
ddr_ctrl		ddr_ctrl_inst
(
	//global clock
	.source_clk			   (source_clk),		      //ddr reference clock
	.phy_clk			      (phy_clk),		         //ddr control clock	

	.rst_n				   (rst_n),			         //global reset
	.local_init_done	   (ddr_init_done),        //ddr init done		
	//ddr read&write internal interface		
	.wr_burst_req		   (wr_burst_req), 	      //ddr write request
	.wr_burst_addr		   (wr_burst_addr),      	//ddr write address 	
	.wr_burst_data_req   (wr_burst_data_req), 	//ddr write data request
	.wr_burst_data		   (wr_burst_data),     	//fifo 2 ddr data input	
	.wr_burst_finish	   (wr_burst_finish),      //ddr write burst finish	
	
	.rd_burst_req		   (rd_burst_req), 	      //ddr read request
	.rd_burst_addr			(rd_burst_addr), 	      //ddr read address
	.rd_burst_data_valid	(rd_burst_data_valid),	//ddr read data valid
	.rd_burst_data		   (rd_burst_data),   	   //ddr 2 fifo data input
	.rd_burst_finish		(rd_burst_finish),      //ddr read burst finish	

	//burst length
	.wr_burst_len		   (10'd256),	           //ddr write burst length
	.rd_burst_len			(10'd256),		        //ddr read burst length
	
	//ddr interface
	.mem_addr			   (mem_addr),		         //ddr address	
	.mem_ba			      (mem_ba),			      //ddr bank address
	.mem_cas_n		      (mem_cas_n),		      //ddr column address strobe
	.mem_cke			      (mem_cke),		         //ddr clock enable 	
	.mem_clk			      (mem_clk),		         //ddr positive clock	
	.mem_clk_n			   (mem_clk_n),		      //ddr negative clock 	
	.mem_cs_n			   (mem_cs_n),		         //ddr chip select		
	.mem_dm			      (mem_dm),		         //ddr data enable 	
	.mem_dq			      (mem_dq),		         //ddr data	
	.mem_dqs			      (mem_dqs),		         //ddr data clock	
	.mem_odt			      (mem_odt),		         //ddr On-Die Termination
	.mem_ras_n		      (mem_ras_n),		      //ddr row address strobe	
	.mem_we_n			   (mem_we_n)		         //ddr write enable

);

					
//------------------------------------------------
//dcfifo_ctrl module instantiation
dcfifo_ctrl u_dcfifo_ctrl
(
	//global clock
	.clk_ref			      (phy_clk),			     //sdram	reference clock
	.rst_n				   (rst_n),			        //global reset
	.clk_read			   (clk_read),     	     //fifo data read clock	
	.clk_write			   (clk_write),     	     //fifo data write clock		
	
	//brust length	
	.wr_length			   (10'd256),		        //ddr write burst length
	.rd_length			   (10'd256),		        //ddr read burst length
	.wr_addr			      (25'd0),			        //ddr start write address
	.wr_max_addr		   (25'd393216),		     //ddr max write address 1024*768 *16bit/32bit
	.rd_addr			      (25'd0),			        //ddr start read address
	.rd_max_addr		   (25'd393216),		     //sdram max read address 1024*768 *16bit/32bit
	.wr_load			      (wr_load),			     //sdram write address reset	
	.rd_load			      (rd_load),			     //sdram read address reset
	
	//wrfifo:  fifo 2 sdram
	.wrf_wrreq			   (sys_we),			     //fifo write enable		
	.wrf_din			      (sys_data_in),		     //fifo data input
	.ddr_wr_req		      (wr_burst_req),	     //ddr write request
	.ddr_wr_ack          (wr_burst_data_req),   //ddr write data request
	.ddr_din		         (wr_burst_data),		  //fifo 2 ddr data input	
	.ddr_wraddr		      (wr_burst_addr),		  //ddr write address
	.ddr_wr_finish	      (wr_burst_finish),     //ddr write burst finish	
	
	//rdfifo: sdram 2 fifo
	.rdf_rdreq			   (sys_rd),			     //fifo read enable	
	.rdf_dout			   (sys_data_out),		  //fifo data output
	.ddr_rd_req		      (rd_burst_req),		  //ddr read request
	.ddr_rd_ack	         (rd_burst_data_valid), //ddr read data valid
	.ddr_dout			   (rd_burst_data),		  //ddr 2 fifo data input	
	.ddr_rdaddr		      (rd_burst_addr),		  //sdram read address
	.ddr_rd_finish		   (rd_burst_finish),     //ddr read burst finish	
	
	//sdram address control	
	.ddr_init_done	     (ddr_init_done),        //ddr init done	
	.frame_write_done	  (frame_write_done),	  //sdram write one frame
	.frame_read_done	  (frame_read_done),	     //sdram read one frame
	.data_valid			  (data_valid)		        //system data output enable
);



endmodule
