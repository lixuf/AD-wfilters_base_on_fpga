transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/ramip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/fifoip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/pllip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/gen_defines.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/fifo_64_fe.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/gen {C:/intelFPGA_lite/workary/xiaobo/gen/sirv_gnrl_dffs.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/per/db {C:/intelFPGA_lite/workary/xiaobo/per/db/pllip_altpll.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/ram_control.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/top_xiaobo.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/clk_gen.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/stl {C:/intelFPGA_lite/workary/xiaobo/stl/out_fifo.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/xiaobo/per/../sim {C:/intelFPGA_lite/workary/xiaobo/per/../sim/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
