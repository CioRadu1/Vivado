# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.cache/wt [current_project]
set_property parent.project_path D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo d:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/IFetch.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/InstructionDecoder.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Laborator_3/Laborator_3.srcs/sources_1/new/MPG.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/MainControlUnit.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Laborator_3/Laborator_3.srcs/sources_1/new/REG_FILE.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Laborator_3/Laborator_3.srcs/sources_1/new/ROM.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Laborator2/Laborator2.srcs/sources_1/new/SEGMENTE.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/UnitateaDeExecutie.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/UnitateaDeMemorie.vhd
  D:/LogisimEvolution/Proiecte/VivadoPr/Procesor/Procesor.srcs/sources_1/new/Procesor.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/LogisimEvolution/NexysA7_test_env.xdc
set_property used_in_implementation false [get_files D:/LogisimEvolution/NexysA7_test_env.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top Procesor -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Procesor.dcp
create_report "synth_2_synth_report_utilization_0" "report_utilization -file Procesor_utilization_synth.rpt -pb Procesor_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]