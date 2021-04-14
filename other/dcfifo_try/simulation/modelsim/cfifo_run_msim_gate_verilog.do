transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {cfifo.vo}

vlog -vlog01compat -work work +incdir+C:/intelFPGA_lite/workary/dcfifo_try {C:/intelFPGA_lite/workary/dcfifo_try/testbench1.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  testbench1

add wave *
view structure
view signals
run -all
