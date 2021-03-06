# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a15tftg256-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.cache/wt [current_project]
set_property parent.project_path C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo.xci
set_property is_locked true [get_files c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1 -new_name bram_fifo -ip [get_ips bram_fifo]]

if { $cached_ip eq {} } {

synth_design -top bram_fifo -part xc7a15tftg256-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix bram_fifo_ bram_fifo.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bram_fifo_stub.v
 lappend ipCachedFiles bram_fifo_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bram_fifo_stub.vhdl
 lappend ipCachedFiles bram_fifo_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bram_fifo_sim_netlist.v
 lappend ipCachedFiles bram_fifo_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ bram_fifo_sim_netlist.vhdl
 lappend ipCachedFiles bram_fifo_sim_netlist.vhdl

 config_ip_cache -add -dcp bram_fifo.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips bram_fifo]
}

rename_ref -prefix_all bram_fifo_

write_checkpoint -force -noxdef bram_fifo.dcp

catch { report_utilization -file bram_fifo_utilization_synth.rpt -pb bram_fifo_utilization_synth.pb }

if { [catch {
  file copy -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo.dcp c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo.dcp c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo_stub.v c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo_stub.vhdl c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo_sim_netlist.v c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.runs/bram_fifo_synth_1/bram_fifo_sim_netlist.vhdl c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.ip_user_files/ip/bram_fifo]} {
  catch { 
    file copy -force c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.v C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.ip_user_files/ip/bram_fifo
  }
}

if {[file isdir C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.ip_user_files/ip/bram_fifo]} {
  catch { 
    file copy -force c:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.srcs/sources_1/ip/bram_fifo_1/bram_fifo_stub.vhdl C:/Users/Keon/Dropbox/Senior_Design_3/Senior_Design_Built_In_FIFO/Senior_Design_Built_In_FIFO.ip_user_files/ip/bram_fifo
  }
}
