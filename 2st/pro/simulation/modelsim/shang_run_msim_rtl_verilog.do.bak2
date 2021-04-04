transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/gen {C:/intelFPGA_lite/workary/ram2_1/gen/sirv_gnrl_dffs.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/rtl {C:/intelFPGA_lite/workary/ram2_1/rtl/ad7606.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/rtl {C:/intelFPGA_lite/workary/ram2_1/rtl/top.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/rtl {C:/intelFPGA_lite/workary/ram2_1/rtl/clk_manger.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/rtl {C:/intelFPGA_lite/workary/ram2_1/rtl/fifoip_50_150.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/rtl {C:/intelFPGA_lite/workary/ram2_1/rtl/pllip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/pre/db {C:/intelFPGA_lite/workary/ram2_1/pre/db/pllip_altpll.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/ram2_1/pre/../sim {C:/intelFPGA_lite/workary/ram2_1/pre/../sim/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
