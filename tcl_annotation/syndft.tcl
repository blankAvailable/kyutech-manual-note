# set variable
set TOP b20
set CLKPERIOD 70
echo ${TOP}
echo ${CLKPERIOD}


# set library
set DCLIBPATH ../../../16112011SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models
#set DCLIBPATH ../lib/Digital_Standard_cell_Library/synopsys/models
set DCLIB saed90nm_typ
set target_library ${DCLIB}.db
echo $target_library
set include_dir ../rtl/
set search_path [list . $DCLIBPATH $include_dir ]
set link_library "* $target_library "
set target_library [list ${DCLIB}.db]


# set 
set verilogout_no_tri true
set verilogout_equation false
set verilogout_single_bit false
set verilogout_show_unconnected_pins false
set exit_delete_filename_log_file false
set bus_naming_style {%s[%d]}


# set do not use 
source -echo -ver ./tcl/do_not_use.tcl
set_attribute [get_lib_pin ${DCLIB}/SDFF*/Q] max_fanout 0
#set_attribute [get_lib_pin ${DCLIB}/SDFF*/QN] max_fanout 1

set power_cg_flatten true


# read verilog
define_design_lib work -path ./work
set cache_read  "."
set cache_write "."
set search_path [list $search_path \
                         ../rtl   \
]


# rtl files
source -echo -ver ./tcl/readrtl.tcl
elaborate -library work $TOP
link

current_design $TOP
ungroup -all -flatten
uniquify


### compile
# set sdc
set_max_fanout    6  ${TOP}
set_fix_multiple_port_nets -feedthroughs -outputs -constants -buffer_constants
set_auto_disable_drc_nets -all

create_clock -name clock -period $CLKPERIOD [get_port clock]


set ins_wo_re_cl [remove_from_collection [all_inputs] [get_port reset] ]
set ins_wo_re_cl [remove_from_collection $ins_wo_re_cl [get_port clock] ]

set_input_delay   0.1      -clock {clock} $ins_wo_re_cl

set_output_delay  0.1      -clock {clock} [all_outputs]


set_load       1.1 [all_outputs]

#set_load       8 [all_outputs]
#set_resistance 1 [all_outputs]
#set_fanout_load 1.1 [all_outputs]


compile -scan  -incre 

# report
report_timing -delay max > report/report_timing_max.rep

# save design data
write -hier -f ddc     -output db/${TOP}.ddc
write_sdf  -version 2.1 -sig 3 sdf/${TOP}.sdf
write_sdc sdc/${TOP}.sdc


### dft
#set dft 
reset_scan_config
reset_dft_config
set test_default_delay 0
set test_default_bidir_delay 0

set test_default_strobe 4
set test_default_period 10

set test_default_scan_style multiplexed_flip_flop
create_port {Scan_Enable Scan_In} -direction in
create_port Scan_Out -direction out
set_dft_signal -view existing -type scanclock -timing { 5 7 } -port [get_port clock] 

set_scan_configuration -chain_count 10
set_scan_configuration -clock_mixing no_mix

set_dft_configuration -scan enable -fix_clock enable  -fix_set enable \
 -wrapper disable -connect_clock_gating enable -fix_bidirectional disable

set_dft_signal -view spec -port Scan_Enable -type ScanEnable
set_dft_signal -view spec -port Scan_In -type ScanDataIn
set_dft_signal -view spec -port Scan_Out -type ScanDataOut

# create spf file
create_test_protocol -infer_clock -infer_async

set_dft_insertion_configuration -preserve_design_name true
set_dft_insertion_configuration -synthesis_optimization none

# insert dft
insert_dft
compile -incre

# dft drc
dft_drc -verbose           > report/scan.dft_drc.rep

change_names -rules verilog -verbose -hierarchy  > report/change_name.rep


# report
report_timing -nosplit -delay max > report/scan_report_timing_max.rep


# save design data
write_test_protocol    -output netlist/${TOP}_scan.spf
write -hier -f ddc     -output db/${TOP}_scan.ddc
write -hier -f verilog -output netlist/${TOP}_scan.vg
write_sdc sdc/${TOP}_scan.sdc

#report scan chain
report_scan_path -view existing_dft -chain all > b20_scan_chain.scan_path
report_scan_path -view existing_dft -cell all > b20_scan_cell.scan_path

quit
