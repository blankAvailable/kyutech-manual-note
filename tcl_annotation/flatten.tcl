 %show the date
sh date

%set circuit name
set design b20
%set the length of one clock period, in ps/ns unit
set clockperiod 20

%set the file path to search the circuit file (xxxx.v)
#set search_path { . /opt/LIB/synthesis/sc }
set search_path { . }


#set link_path { ../nangate/NangateOpenCellLibrary_PDKv1.2_v2008_05.typical.nldm.db }
#set target_library "../nangate/NangateOpenCellLibrary_PDKv1.2_v2008_05.typical.nldm.db"
#set synthetic_library ""
#set physical_library ""

%set cell type lib
set target_library saed90nm_typ.db
%set the design ware lib, it implements some complex functions (e.g. adders, multipliers)
set synthetic_library dw_foundation.sldb

set physical_library ""

set symbol_library saed90nm.sdb

set link_library "* $target_library		\
                    $synthetic_library  \
		    		$physical_library	\
                 "

define_design_lib work -path ./work
#analyze -format verilog -lib work ../othercells.v
analyze -format verilog -lib work ${design}.v
elaborate -library work $design
current_design $design
link

ungroup -all -flatten
uniquify

set verilogout_single_bit true
set bus_inference_style {%s_%d_}
set bus_naming_style {%s_%d_}
#set hdlout_internal_busses true
define_name_rules name_rule -allowed "A-Z a-z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "A-Z a-z 0-9 _" -max_length 255 -type net
define_name_rules name_rule -allowed "A-Z a-z 0-9 _" -max_length 255 -type port
define_name_rules name_rule -type port -map { {{"hold", "halt"}} }
define_name_rules name_rule -type net -map { {{"hold", "halt"}} }
define_name_rules name_rule -case_insensitive
define_name_rules name_rule -target_bus_naming_style {%s_%d_} -type net
change_names -hierarchy -rules verilog
change_names -hierarchy -rules name_rule

write -hier -f ddc     -output ${design}_flat.ddc
write -hier -f verilog -output ${design}_flat.v
#write -hier -f vhdl -output ${design}_flat.vhdl

quit
