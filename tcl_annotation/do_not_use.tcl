%this a black list of cell types which should not be used while synthesizing

set_dont_use [get_lib_cells ${DCLIB}/*DFF*]

remove_attribute [get_lib_cells ${DCLIB}/SDFFARX1] dont_use
remove_attribute [get_lib_cells ${DCLIB}/SDFFARX2] dont_use

remove_attribute [get_lib_cells ${DCLIB}/SDFFASRX1] dont_use
remove_attribute [get_lib_cells ${DCLIB}/SDFFASRX2] dont_use

remove_attribute [get_lib_cells ${DCLIB}/SDFFX1] dont_use
remove_attribute [get_lib_cells ${DCLIB}/SDFFX2] dont_use

set_dont_use [get_lib_cells ${DCLIB}/DELL*]
set_dont_use [get_lib_cells ${DCLIB}/AO*]
set_dont_use [get_lib_cells ${DCLIB}/OA*]
set_dont_use [get_lib_cells ${DCLIB}/*3*]
set_dont_use [get_lib_cells ${DCLIB}/*4*]
set_dont_use [get_lib_cells ${DCLIB}/XNOR*]
set_dont_use [get_lib_cells ${DCLIB}/XOR*]
set_dont_use [get_lib_cells ${DCLIB}/MUX*]
set_dont_use [get_lib_cells ${DCLIB}/*ADD*]
#set_dont_use [get_lib_cells ${DCLIB}/TIE*]
set_dont_use [get_lib_cells ${DCLIB}/ANTENNA]
set_dont_use [get_lib_cells ${DCLIB}/DCAP]

remove_attribute [get_lib_cells ${DCLIB}/INV*] dont_use
remove_attribute [get_lib_cells ${DCLIB}/NBUF*] dont_use

