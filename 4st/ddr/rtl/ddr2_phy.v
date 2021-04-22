// megafunction wizard: %altmemphy v13.1%
// GENERATION: XML

// ============================================================
// Megafunction Name(s):
// 			ddr2_phy_alt_mem_phy
// ============================================================
// Generated by altmemphy 13.1 [Altera, IP Toolbench 1.3.0 Build 162]
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
// ************************************************************
// Copyright (C) 1991-2021 Altera Corporation
// Any megafunction design, and related net list (encrypted or decrypted),
// support information, device programming or simulation file, and any other
// associated documentation or information provided by Altera or a partner
// under Altera's Megafunction Partnership Program may be used only to
// program PLD devices (but not masked PLD devices) from Altera.  Any other
// use of such megafunction design, net list, support information, device
// programming or simulation file, or any other related documentation or
// information is prohibited for any other purpose, including, but not
// limited to modification, reverse engineering, de-compiling, or use with
// any other silicon devices, unless such use is explicitly licensed under
// a separate agreement with Altera or a megafunction partner.  Title to
// the intellectual property, including patents, copyrights, trademarks,
// trade secrets, or maskworks, embodied in any such megafunction design,
// net list, support information, device programming or simulation file, or
// any other related documentation or information provided by Altera or a
// megafunction partner, remains with Altera, the megafunction partner, or
// their respective licensors.  No other licenses, including any licenses
// needed under any third party's intellectual property, are provided herein.


module ddr2_phy (
	pll_ref_clk,
	global_reset_n,
	soft_reset_n,
	ctl_dqs_burst,
	ctl_wdata_valid,
	ctl_wdata,
	ctl_dm,
	ctl_addr,
	ctl_ba,
	ctl_cas_n,
	ctl_cke,
	ctl_cs_n,
	ctl_odt,
	ctl_ras_n,
	ctl_we_n,
	ctl_rst_n,
	ctl_mem_clk_disable,
	ctl_doing_rd,
	ctl_cal_req,
	ctl_cal_byte_lane_sel_n,
	dbg_clk,
	dbg_reset_n,
	dbg_addr,
	dbg_wr,
	dbg_rd,
	dbg_cs,
	dbg_wr_data,
	reset_request_n,
	ctl_clk,
	ctl_reset_n,
	ctl_wlat,
	ctl_rdata,
	ctl_rdata_valid,
	ctl_rlat,
	ctl_cal_success,
	ctl_cal_fail,
	ctl_cal_warning,
	mem_addr,
	mem_ba,
	mem_cas_n,
	mem_cke,
	mem_cs_n,
	mem_dm,
	mem_odt,
	mem_ras_n,
	mem_we_n,
	mem_reset_n,
	dbg_rd_data,
	dbg_waitrequest,
	aux_half_rate_clk,
	aux_full_rate_clk,
	mem_clk,
	mem_clk_n,
	mem_dq,
	mem_dqs,
	mem_dqs_n);


	input		pll_ref_clk;
	input		global_reset_n;
	input		soft_reset_n;
	input	[1:0]	ctl_dqs_burst;
	input	[1:0]	ctl_wdata_valid;
	input	[31:0]	ctl_wdata;
	input	[3:0]	ctl_dm;
	input	[12:0]	ctl_addr;
	input	[2:0]	ctl_ba;
	input	[0:0]	ctl_cas_n;
	input	[0:0]	ctl_cke;
	input	[0:0]	ctl_cs_n;
	input	[0:0]	ctl_odt;
	input	[0:0]	ctl_ras_n;
	input	[0:0]	ctl_we_n;
	input	[0:0]	ctl_rst_n;
	input	[0:0]	ctl_mem_clk_disable;
	input	[1:0]	ctl_doing_rd;
	input		ctl_cal_req;
	input	[1:0]	ctl_cal_byte_lane_sel_n;
	input		dbg_clk;
	input		dbg_reset_n;
	input	[12:0]	dbg_addr;
	input		dbg_wr;
	input		dbg_rd;
	input		dbg_cs;
	input	[31:0]	dbg_wr_data;
	output		reset_request_n;
	output		ctl_clk;
	output		ctl_reset_n;
	output	[4:0]	ctl_wlat;
	output	[31:0]	ctl_rdata;
	output	[0:0]	ctl_rdata_valid;
	output	[4:0]	ctl_rlat;
	output		ctl_cal_success;
	output		ctl_cal_fail;
	output		ctl_cal_warning;
	output	[12:0]	mem_addr;
	output	[2:0]	mem_ba;
	output		mem_cas_n;
	output	[0:0]	mem_cke;
	output	[0:0]	mem_cs_n;
	output	[1:0]	mem_dm;
	output	[0:0]	mem_odt;
	output		mem_ras_n;
	output		mem_we_n;
	output		mem_reset_n;
	output	[31:0]	dbg_rd_data;
	output		dbg_waitrequest;
	output		aux_half_rate_clk;
	output		aux_full_rate_clk;
	inout	[0:0]	mem_clk;
	inout	[0:0]	mem_clk_n;
	inout	[15:0]	mem_dq;
	inout	[1:0]	mem_dqs;
	inout	[1:0]	mem_dqs_n;


	ddr2_phy_alt_mem_phy	ddr2_phy_alt_mem_phy_inst(
		.pll_ref_clk(pll_ref_clk),
		.global_reset_n(global_reset_n),
		.soft_reset_n(soft_reset_n),
		.ctl_dqs_burst(ctl_dqs_burst),
		.ctl_wdata_valid(ctl_wdata_valid),
		.ctl_wdata(ctl_wdata),
		.ctl_dm(ctl_dm),
		.ctl_addr(ctl_addr),
		.ctl_ba(ctl_ba),
		.ctl_cas_n(ctl_cas_n),
		.ctl_cke(ctl_cke),
		.ctl_cs_n(ctl_cs_n),
		.ctl_odt(ctl_odt),
		.ctl_ras_n(ctl_ras_n),
		.ctl_we_n(ctl_we_n),
		.ctl_rst_n(ctl_rst_n),
		.ctl_mem_clk_disable(ctl_mem_clk_disable),
		.ctl_doing_rd(ctl_doing_rd),
		.ctl_cal_req(ctl_cal_req),
		.ctl_cal_byte_lane_sel_n(ctl_cal_byte_lane_sel_n),
		.dbg_clk(dbg_clk),
		.dbg_reset_n(dbg_reset_n),
		.dbg_addr(dbg_addr),
		.dbg_wr(dbg_wr),
		.dbg_rd(dbg_rd),
		.dbg_cs(dbg_cs),
		.dbg_wr_data(dbg_wr_data),
		.reset_request_n(reset_request_n),
		.ctl_clk(ctl_clk),
		.ctl_reset_n(ctl_reset_n),
		.ctl_wlat(ctl_wlat),
		.ctl_rdata(ctl_rdata),
		.ctl_rdata_valid(ctl_rdata_valid),
		.ctl_rlat(ctl_rlat),
		.ctl_cal_success(ctl_cal_success),
		.ctl_cal_fail(ctl_cal_fail),
		.ctl_cal_warning(ctl_cal_warning),
		.mem_addr(mem_addr),
		.mem_ba(mem_ba),
		.mem_cas_n(mem_cas_n),
		.mem_cke(mem_cke),
		.mem_cs_n(mem_cs_n),
		.mem_dm(mem_dm),
		.mem_odt(mem_odt),
		.mem_ras_n(mem_ras_n),
		.mem_we_n(mem_we_n),
		.mem_reset_n(mem_reset_n),
		.dbg_rd_data(dbg_rd_data),
		.dbg_waitrequest(dbg_waitrequest),
		.aux_half_rate_clk(aux_half_rate_clk),
		.aux_full_rate_clk(aux_full_rate_clk),
		.mem_clk(mem_clk),
		.mem_clk_n(mem_clk_n),
		.mem_dq(mem_dq),
		.mem_dqs(mem_dqs),
		.mem_dqs_n(mem_dqs_n));

	defparam
		ddr2_phy_alt_mem_phy_inst.FAMILY = "Cyclone IV E",
		ddr2_phy_alt_mem_phy_inst.MEM_IF_MEMTYPE = "DDR2",
		ddr2_phy_alt_mem_phy_inst.DLL_DELAY_BUFFER_MODE = "LOW",
		ddr2_phy_alt_mem_phy_inst.DLL_DELAY_CHAIN_LENGTH = 12,
		ddr2_phy_alt_mem_phy_inst.DQS_DELAY_CTL_WIDTH = 6,
		ddr2_phy_alt_mem_phy_inst.DQS_OUT_MODE = "DELAY_CHAIN2",
		ddr2_phy_alt_mem_phy_inst.DQS_PHASE = 6000,
		ddr2_phy_alt_mem_phy_inst.DQS_PHASE_SETTING = 2,
		ddr2_phy_alt_mem_phy_inst.DWIDTH_RATIO = 2,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DWIDTH = 16,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_ADDR_WIDTH = 13,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_BANKADDR_WIDTH = 3,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_CS_WIDTH = 1,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_CS_PER_RANK = 1,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DM_WIDTH = 2,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DM_PINS_EN = 1,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DQ_PER_DQS = 8,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DQS_WIDTH = 2,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_OCT_EN = 0,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_CLK_PAIR_COUNT = 1,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_CLK_PS = 5999,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_CLK_PS_STR = "5999 ps",
		ddr2_phy_alt_mem_phy_inst.MEM_IF_MR_0 = 1074,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_MR_1 = 1092,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_MR_2 = 0,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_MR_3 = 0,
		ddr2_phy_alt_mem_phy_inst.PLL_STEPS_PER_CYCLE = 56,
		ddr2_phy_alt_mem_phy_inst.SCAN_CLK_DIVIDE_BY = 2,
		ddr2_phy_alt_mem_phy_inst.MEM_IF_DQSN_EN = 0,
		ddr2_phy_alt_mem_phy_inst.DLL_EXPORT_IMPORT = "EXPORT",
		ddr2_phy_alt_mem_phy_inst.MEM_IF_ADDR_CMD_PHASE = 90,
		ddr2_phy_alt_mem_phy_inst.RANK_HAS_ADDR_SWAP = 0;
endmodule

// =========================================================
// altmemphy Wizard Data
// ===============================
// DO NOT EDIT FOLLOWING DATA
// @Altera, IP Toolbench@
// Warning: If you modify this section, altmemphy Wizard may not be able to reproduce your chosen configuration.
// 
// Retrieval info: <?xml version="1.0"?>
// Retrieval info: <MEGACORE title="ALTMEMPHY"  version="13.1"  build="198"  iptb_version="1.3.0 Build 162"  format_version="120" >
// Retrieval info:  <NETLIST_SECTION class="altera.ipbu.flowbase.netlist.model.DDRPHYMVCModel"  active_core="ddr2_phy_alt_mem_phy" >
// Retrieval info:   <STATIC_SECTION>
// Retrieval info:    <PRIVATES>
// Retrieval info:     <NAMESPACE name = "parameterization">
// Retrieval info:      <PRIVATE name = "pipeline_commands" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "debug_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "export_debug_port" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "use_generated_memory_model" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dedicated_memory_clk_phase_label" value="Dedicated memory clock phase:"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_clk_mhz" value="166.7"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "quartus_project_exists" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "local_if_drate" value="Full"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "enable_v72_rsu" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "local_if_clk_mhz_label" value="166.7"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "new_variant" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_memtype" value="DDR2 SDRAM"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "pll_ref_clk_mhz" value="50.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_clk_ps_label" value="(5999 ps)"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "family" value="Cyclone IV E"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "project_family" value="Cyclone IV E"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "speed_grade" value="8"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dedicated_memory_clk_phase" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "pll_ref_clk_ps_label" value="(20000 ps)"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "avalon_burst_length" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_clk_pair_count" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_cs_per_dimm" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "pre_latency_label" value="Fix read latency at:"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dedicated_memory_clk_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mirror_addressing" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_bankaddr_width" value="3"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_9" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_rowaddr_width" value="13"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_dyn_deskew_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "post_latency_label" value="cycles (0 cycles=minimum latency, non-deterministic)"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_dm_pins_en" value="Yes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "local_if_dwidth_label" value="32"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_7" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_8" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_preset" value="Micron MT47H64M16-3IT"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_pchaddr_bit" value="10"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "WIDTH_RATIO" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "vendor" value="Micron"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_3" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_4" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "chip_or_dimm" value="Discrete Device"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_5" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_6" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_fmax" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_0" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_size" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_1" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_2" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_11" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_10" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_cs_width" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_preset_rlat" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_cs_per_rank" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "fast_simulation_en" value="FAST"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_15" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_14" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_dwidth" value="16"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_dq_per_dqs" value="8"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_coladdr_width" value="10"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_13" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "register_control_word_12" value="0000"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tiha_ps" value="600"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdsh_ck" value="0.2"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_trfc_ns" value="105.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tqh_ck" value="0.36"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tisa_ps" value="600"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdss_ck" value="0.2"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_trtp_ns" value="7.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_tinit_us" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_trcd_ns" value="15.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_twtr_ck" value="2"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_trrd_ns" value="10.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdqss_ck" value="0.25"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tqhs_ps" value="450"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdsa_ps" value="445"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tac_ps" value="600"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdha_ps" value="385"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_tras_ns" value="40.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_twr_ns" value="15.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdqsck_ps" value="500"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_trp_ns" value="15.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tdqsq_ps" value="350"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_tmrd_ns" value="10.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tfaw_ns" value="50.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_trefi_us" value="7.8"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_40_fmax" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_odt" value="50"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_WLH_percent" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_drv_str" value="Normal"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DH_percent" value="0.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "input_period" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_QH_percent" value="0.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_QHS_percent" value="0.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_30_fmax" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ac_clk_select" value="90"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DQSQ_percent" value="0.65"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DS_percent" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "pll_reconfig_ports_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_btype" value="Sequential"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_IS_percent" value="0.7"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl" value="3.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DQSS_percent" value="0.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "export_bank_info" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DSS_percent" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_dll_en" value="Yes"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ac_phase" value="90"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_oct_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_60_fmax" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DSH_percent" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_if_dqsn_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "enable_mp_calibration" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_IH_percent" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_15_fmax" value="533.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dll_external" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_bl" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_WLS_percent" value="0.7"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_50_fmax" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mp_DQSCK_percent" value="0.5"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_25_fmax" value="533.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_20_fmax" value="533.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "cfg_reorder_data" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_ecc_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_hrb_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ref_clk_source" value="XX"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "cfg_data_reordering_type" value="INTER_BANK"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_powerdn_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "multicast_wr_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "auto_powerdn_cycles" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_self_refresh_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "cfg_starve_limit" value="10"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "shared_sys_clk_source" value="XX"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_latency" value="0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "tool_context" value="STANDALONE"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_addr_mapping" value="CHIP_ROW_BANK_COL"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "burst_merge_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "user_refresh_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "qsys_mode" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "clk_source_sharing_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_lookahead_depth" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_autopch_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_dynamic_bank_allocation" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_dynamic_bank_num" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "local_if_type_avalon" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "csr_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ctl_auto_correct_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "auto_powerdn_en" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "phy_if_type_afi" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "controller_type" value="ngv110_ctl"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "max_local_size" value="4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_srtr" value="Normal"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_mpr_loc" value="Predefined Pattern"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dss_tinit_rst_us" value="200.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_90_fmax" value="400.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_rtt_wr" value="Dynamic ODT off"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_100_fmax" value="400.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_pasr" value="Full Array"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_asrm" value="Manual SR Reference (SRT)"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_mpr_oper" value="Predefined Pattern"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_80_fmax" value="400.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_drv_impedance" value="RZQ/7"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_rtt_nom" value="ODT Disabled"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_tcl_70_fmax" value="400.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_wtcl" value="5.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_dll_pch" value="Fast Exit"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "mem_atcl" value="Disabled"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_settings_valid" value="true"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_IH" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_intra_DQS_group_skew" value="0.02"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "isi_DQS" value="0.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "addr_cmd_slew_rate" value="1.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_tpd_inter_DIMM" value="0.05"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_addresscmd_CK_skew" value="0.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_DS_calculated" value="0.400"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "isi_addresscmd_hold" value="0.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_IS" value="0.6"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "restore_default_toggle" value="false"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dqs_dqsn_slew_rate" value="2.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "dq_slew_rate" value="1.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_inter_DQS_group_skew" value="0.02"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "isi_addresscmd_setup" value="0.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_minCK_DQS_skew" value="-0.01"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_IS_calculated" value="0.600"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "num_slots_or_devices" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_maxCK_DQS_skew" value="0.01"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "board_skew_ps" value="20"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_DH" value="0.4"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "ck_ckn_slew_rate" value="2.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "isi_DQ" value="0.0"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_IH_calculated" value="0.600"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_DH_calculated" value="0.400"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "t_DS" value="0.4"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "simgen">
// Retrieval info:      <PRIVATE name = "use_alt_top" value="1"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "alt_top" value="ddr2_phy_alt_mem_phy_seq_wrapper"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "family" value="Cyclone IV E"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "filename" value="ddr2_phy_alt_mem_phy_seq_wrapper.vo"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "simgen2">
// Retrieval info:      <PRIVATE name = "family" value="Cyclone IV E"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "command" value="--simgen_arbitrary_blackbox=+ddr2_phy_alt_mem_phy_seq_wrapper;+ddr2_phy_alt_mem_phy_reconfig;+ddr2_phy_alt_mem_phy_pll;+ddr2_phy_alt_mem_phy_delay --ini=simgen_tri_bus_opt=on"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "parameter" value="SIMGEN_INITIALIZATION_FILE=C:\intelFPGA_lite\workary\ddr_office\rtl/ddr2_phy_simgen_init.txt"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "simgen_enable">
// Retrieval info:      <PRIVATE name = "language" value="Verilog HDL"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "enabled" value="1"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "qip">
// Retrieval info:      <PRIVATE name = "gx_libs" value="1"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "greybox">
// Retrieval info:      <PRIVATE name = "filename" value="ddr2_phy_syn.v"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "quartus_settings">
// Retrieval info:      <PRIVATE name = "DEVICE" value="EP4CE15F23C8"  type="STRING"  enable="1" />
// Retrieval info:      <PRIVATE name = "FAMILY" value="Cyclone IV E"  type="STRING"  enable="1" />
// Retrieval info:     </NAMESPACE>
// Retrieval info:     <NAMESPACE name = "serializer"/>
// Retrieval info:    </PRIVATES>
// Retrieval info:    <FILES/>
// Retrieval info:    <PORTS/>
// Retrieval info:    <LIBRARIES/>
// Retrieval info:   </STATIC_SECTION>
// Retrieval info:  </NETLIST_SECTION>
// Retrieval info: </MEGACORE>
// =========================================================
// IPFS_FILES: ddr2_phy_alt_mem_phy_seq_wrapper.vo;
// =========================================================
