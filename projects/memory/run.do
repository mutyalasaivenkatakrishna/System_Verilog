#functional coverage 
vlog including_files.svh
vsim -novopt -suppress 12110 top  -assertdebug 

add wave -position insertpoint sim:/top/pif/*

#do wave.do

run -all



