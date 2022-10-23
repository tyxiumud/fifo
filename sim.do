set rtl rtl/*.v
set tb tb/*.v
set testbench_name TB_FIFO
vlib work
vmap work work
vlog $rtl
vlog $tb
vsim -t ns -novopt +notimingchecks work.$testbench_name
add wave -position insertpoint sim:/TB_FIFO/U_FIFO_0/*
add wave -position insertpoint sim:/TB_FIFO/U_FIFO_0/U_FIFO_MEM_0/*
run -all