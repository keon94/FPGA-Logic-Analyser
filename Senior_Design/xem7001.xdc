############################################################################
# XEM7001 - Xilinx constraints file
#
# Pin mappings for the XEM7001.  Use this as a template and comment out 
# the pins that are not used in your design.  (By default, map will fail
# if this file contains constraints for signals not in your design).
#
# Copyright (c) 2004-2016 Opal Kelly Incorporated
############################################################################

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS True [current_design]

set_property PACKAGE_PIN K12 [get_ports {hi_muxsel}]
set_property IOSTANDARD LVCMOS33 [get_ports {hi_muxsel}]

############################################################################
## FrontPanel Host Interface
############################################################################
#set_property PACKAGE_PIN N11 [get_ports {hi_in[0]}]
#set_property PACKAGE_PIN R13 [get_ports {hi_in[1]}]
#set_property PACKAGE_PIN R12 [get_ports {hi_in[2]}]
#set_property PACKAGE_PIN P13 [get_ports {hi_in[3]}]
#set_property PACKAGE_PIN T13 [get_ports {hi_in[4]}]
#set_property PACKAGE_PIN T12 [get_ports {hi_in[5]}]
#set_property PACKAGE_PIN P11 [get_ports {hi_in[6]}]
#set_property PACKAGE_PIN R10 [get_ports {hi_in[7]}]

#set_property SLEW FAST [get_ports {hi_in[*]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hi_in[*]}]

#set_property PACKAGE_PIN R15 [get_ports {hi_out[0]}]
#set_property PACKAGE_PIN N13 [get_ports {hi_out[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hi_out[*]}]

#set_property PACKAGE_PIN T15 [get_ports {hi_inout[0]}]
#set_property PACKAGE_PIN T14 [get_ports {hi_inout[1]}]
#set_property PACKAGE_PIN R16 [get_ports {hi_inout[2]}]
#set_property PACKAGE_PIN P16 [get_ports {hi_inout[3]}]
#set_property PACKAGE_PIN P15 [get_ports {hi_inout[4]}]
#set_property PACKAGE_PIN N16 [get_ports {hi_inout[5]}]
#set_property PACKAGE_PIN M16 [get_ports {hi_inout[6]}]
#set_property PACKAGE_PIN M12 [get_ports {hi_inout[7]}]
#set_property PACKAGE_PIN L13 [get_ports {hi_inout[8]}]
#set_property PACKAGE_PIN K13 [get_ports {hi_inout[9]}]
#set_property PACKAGE_PIN M14 [get_ports {hi_inout[10]}]
#set_property PACKAGE_PIN L14 [get_ports {hi_inout[11]}]
#set_property PACKAGE_PIN K16 [get_ports {hi_inout[12]}]
#set_property PACKAGE_PIN K15 [get_ports {hi_inout[13]}]
#set_property PACKAGE_PIN J14 [get_ports {hi_inout[14]}]
#set_property PACKAGE_PIN J13 [get_ports {hi_inout[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hi_inout[*]}]

#set_property PACKAGE_PIN M15 [get_ports {hi_aa}]
#set_property IOSTANDARD LVCMOS33 [get_ports {hi_aa}]


create_clock -name okHostClk -period 20.83 [get_ports fpga_clk]

#set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  11.000 [get_ports {hi_inout[*]}]
#set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000  [get_ports {hi_inout[*]}]
set_multicycle_path -setup -from [get_ports {fpga_clk}] 2

#set_input_delay -add_delay -max -clock [get_clocks {okHostClk}]  6.700 [get_ports {hi_in[*]}]
#set_input_delay -add_delay -min -clock [get_clocks {okHostClk}]  0.000 [get_ports {hi_in[*]}]
#set_multicycle_path -setup -from [get_ports {hi_in[*]}] 2

#set_output_delay -add_delay -clock [get_clocks {okHostClk}]  8.900 [get_ports {hi_out[*]}]

#set_output_delay -add_delay -clock [get_clocks {okHostClk}]  9.200 [get_ports {hi_inout[*]}]


#set_property IOSTANDARD LVCMOS33 [get_ports {clk1}]
#set_property PACKAGE_PIN N14 [get_ports {clk1}]

#set_property IOSTANDARD LVCMOS33 [get_ports {clk2}]
#set_property PACKAGE_PIN F4 [get_ports {clk2}]

#set_property IOSTANDARD LVCMOS33 [get_ports {clk3}]
#set_property PACKAGE_PIN F5 [get_ports {clk3}]



## JP1-1 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP1-2 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP1-3 
#set_property PACKAGE_PIN H1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-4 
#set_property PACKAGE_PIN H2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-5 
#set_property PACKAGE_PIN G1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-6 
#set_property PACKAGE_PIN G2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-7 
#set_property PACKAGE_PIN F2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-8 
#set_property PACKAGE_PIN E1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-9 
#set_property PACKAGE_PIN E2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-10 
#set_property PACKAGE_PIN D1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-11 
#set_property PACKAGE_PIN C1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-12 
#set_property PACKAGE_PIN C2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-13 
#set_property PACKAGE_PIN B1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-14 
#set_property PACKAGE_PIN B2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-15 
#set_property PACKAGE_PIN A2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-16 
#set_property PACKAGE_PIN A3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-17 
#set_property PACKAGE_PIN D4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-18 
#set_property PACKAGE_PIN C4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP1-19 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP1-20 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-1 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-2 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-3 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-4 
#set_property PACKAGE_PIN P10 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-5 
#set_property PACKAGE_PIN J1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-6 
#set_property PACKAGE_PIN J3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-7 
#set_property PACKAGE_PIN K2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-8 
#set_property PACKAGE_PIN K1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-9 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-10 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-11 
#set_property PACKAGE_PIN L2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-12 
#set_property PACKAGE_PIN K3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-13 
#set_property PACKAGE_PIN L3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-14 
#set_property PACKAGE_PIN M1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-15 
#set_property PACKAGE_PIN M2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-16 
#set_property PACKAGE_PIN L4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-17 
#set_property PACKAGE_PIN M4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-18 
#set_property PACKAGE_PIN N1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-19 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-20 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-21 
#set_property PACKAGE_PIN N2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-22 
#set_property PACKAGE_PIN N3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-23 
#set_property PACKAGE_PIN P1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-24 
#set_property PACKAGE_PIN R1 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-25 
#set_property PACKAGE_PIN R2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-26 
#set_property PACKAGE_PIN P3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-27 
#set_property PACKAGE_PIN T2 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-28 
#set_property PACKAGE_PIN R3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-29 
#set_property PACKAGE_PIN T3 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-30 
#set_property PACKAGE_PIN N4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-31 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-32 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-33 
#set_property PACKAGE_PIN P4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-34 
#set_property PACKAGE_PIN T4 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-35 
#set_property PACKAGE_PIN P5 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-36 
#set_property PACKAGE_PIN N6 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-37 
#set_property PACKAGE_PIN R5 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-38 
#set_property PACKAGE_PIN P8 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-39 
#set_property PACKAGE_PIN T5 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-40 
#set_property PACKAGE_PIN R6 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-41 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-42 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-43 
#set_property PACKAGE_PIN T9 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-44 
#set_property PACKAGE_PIN R7 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-45 
#set_property PACKAGE_PIN T7 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-46 
#set_property PACKAGE_PIN R8 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-47 
#set_property PACKAGE_PIN T8 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-48 
#set_property PACKAGE_PIN T10 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP2-49 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP2-50 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-1 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-2 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-3 
#set_property PACKAGE_PIN A8 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-4 
#set_property PACKAGE_PIN D9 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-5 
#set_property PACKAGE_PIN C8 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-6 
#set_property PACKAGE_PIN D10 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-7 
#set_property PACKAGE_PIN A9 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-8 
#set_property PACKAGE_PIN C9 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-9 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-10 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-11 
#set_property PACKAGE_PIN B9 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-12 
#set_property PACKAGE_PIN A10 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-13 
#set_property PACKAGE_PIN B10 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-14 
#set_property PACKAGE_PIN C11 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-15 
#set_property PACKAGE_PIN B12 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-16 
#set_property PACKAGE_PIN A12 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-17 
#set_property PACKAGE_PIN C12 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-18 
#set_property PACKAGE_PIN F13 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-19 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-20 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-21 
#set_property PACKAGE_PIN A13 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-22 
#set_property PACKAGE_PIN A14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-23 
#set_property PACKAGE_PIN E13 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-24 
#set_property PACKAGE_PIN B14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-25 
#set_property PACKAGE_PIN C14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-26 
#set_property PACKAGE_PIN A15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-27 
#set_property PACKAGE_PIN B15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-28 
#set_property PACKAGE_PIN B16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-29 
#set_property PACKAGE_PIN C16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-30 
#set_property PACKAGE_PIN D15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-31 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-32 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-33 
#set_property PACKAGE_PIN D16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-34 
#set_property PACKAGE_PIN D14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-35 
#set_property PACKAGE_PIN E16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-36 
#set_property PACKAGE_PIN E15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-37 
#set_property PACKAGE_PIN G15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-38 
#set_property PACKAGE_PIN F14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-39 
#set_property PACKAGE_PIN H14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-40 
#set_property PACKAGE_PIN G16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-41 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-42 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-43 
#set_property PACKAGE_PIN H13 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-44 
#set_property PACKAGE_PIN H16 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-45 
#set_property PACKAGE_PIN F15 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-46 
#set_property PACKAGE_PIN G14 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-47 
#set_property PACKAGE_PIN E12 [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-48 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD LVCMOS33 [get_ports {}]

## JP3-49 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

## JP3-50 
#set_property PACKAGE_PIN  [get_ports {}]
#set_property IOSTANDARD  [get_ports {}]

# LEDs #####################################################################
set_property PACKAGE_PIN H5 [get_ports {divided_clk}]
#set_property PACKAGE_PIN F3 [get_ports {led[1]}]
#set_property PACKAGE_PIN E3 [get_ports {led[2]}]
#set_property PACKAGE_PIN H4 [get_ports {led[3]}]
#set_property PACKAGE_PIN D3 [get_ports {led[4]}]
#set_property PACKAGE_PIN C3 [get_ports {led[5]}]
#set_property PACKAGE_PIN H3 [get_ports {led[6]}]
#set_property PACKAGE_PIN A4 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}]

# Buttons ##################################################################
set_property PACKAGE_PIN A5 [get_ports {clk_sel[0]}]
set_property PACKAGE_PIN B4 [get_ports {clk_sel[1]}]
set_property PACKAGE_PIN B7 [get_ports {clk_sel[2]}]
set_property PACKAGE_PIN A7 [get_ports {clk_sel[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {button[*]}]

# Flash ####################################################################
#set_property PACKAGE_PIN L12 [get_ports {spi_cs}]
#set_property PACKAGE_PIN M6 [get_ports {spi_clk}]
#set_property PACKAGE_PIN N9 [get_ports {spi_din}]
#set_property PACKAGE_PIN P9 [get_ports {spi_dout}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_cs}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_din}]
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_dout}]

