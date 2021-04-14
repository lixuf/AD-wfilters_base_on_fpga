transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try {C:/intelFPGA_lite/workary/dcfifo_try/fifoip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try {C:/intelFPGA_lite/workary/dcfifo_try/pllip.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try {C:/intelFPGA_lite/workary/dcfifo_try/top.v}
vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try/db {C:/intelFPGA_lite/workary/dcfifo_try/db/pllip_altpll.v}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try {C:/intelFPGA_lite/workary/dcfifo_try/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
