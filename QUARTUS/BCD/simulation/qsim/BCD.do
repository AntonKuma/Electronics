onerror {exit -code 1}
vlib work
vcom -work work BCD.vho
vcom -work work BCD_Wave.vwf.vht
vsim -novopt -c -t 1ps -L cycloneive -L altera -L altera_mf -L 220model -L sgate -L altera_lnsim work.BCD_AGUNG_07111640000087_vhd_vec_tst
vcd file -direction BCD.msim.vcd
vcd add -internal BCD_AGUNG_07111640000087_vhd_vec_tst/*
vcd add -internal BCD_AGUNG_07111640000087_vhd_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
