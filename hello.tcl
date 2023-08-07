#!/usr/bin/tclsh

puts "HALF ADDER USING TCL IN VIVADO AND AUTOMATION WITH JENKINS "

set project_name "halfadder_tcl"

set source_file "adder1.v" 
set testbench_file "adder_tb.v"

create_project $project_name ./using_tcl/$project_name -part xc7z020clg484-1

add_files -fileset sources_1 $source_file
add_files -fileset sim_1 $testbench_file


set_property top adder_tb [current_fileset]

current_project $project_name

set_property target_simulator "XSim" [current_project]

set_property top adder_tb [get_filesets sim_1]

launch_simulation 
create_wave_config waveform
save_wave_config waveform
close_wave_config waveform
close_sim

set_property top adder1 [current_fileset]

synth_design -top adder1

#set_property target_simulator "XSim" [current_project]
#launch_simulation -mode "post-synthesis" -type "functional"

set_property IOSTANDARD LVCMOS33 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports b]
set_property IOSTANDARD LVCMOS33 [get_ports c]
set_property IOSTANDARD LVCMOS33 [get_ports s]
set_property PACKAGE_PIN U7 [get_ports a]
set_property PACKAGE_PIN W5 [get_ports b]
set_property PACKAGE_PIN W6 [get_ports c]
set_property PACKAGE_PIN W7 [get_ports s]

#or read_xdc $filename.xdc

opt_design
place_design
route_design

#report_timing_summary
write_bitstream -force ./using_tcl/output.bit

close_project

exit

