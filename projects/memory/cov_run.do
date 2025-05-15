#CODE COVERAGE


#compilation
vlog including_files.svh


#optimisation
vopt work.top +cover=fcbest -o multiple_wr_rd


#ellaboration
vsim -coverage  multiple_wr_rd -assertdebug


# +testcase=multiple_wr_rd 
# save coverage
coverage save -onexit multiple_wr_rd.ucdb


# adding wave
add wave -position insertpoint sim:/top/dut/*


#do wave.do
do exclusion.do


#run the simulation
run -all

