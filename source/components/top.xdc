## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_200M]
	set_property IOSTANDARD LVCMOS33 [get_ports clk_200M]
	create_clock -add -name sys_clk_pin -period 5.00 [get_ports clk_200M]


## LEDs
set_property PACKAGE_PIN U16 [get_ports {debug[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[0]}]
set_property PACKAGE_PIN E19 [get_ports {debug[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[1]}]
set_property PACKAGE_PIN U19 [get_ports {debug[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[2]}]
set_property PACKAGE_PIN V19 [get_ports {debug[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[3]}]
set_property PACKAGE_PIN W18 [get_ports {debug[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[4]}]
set_property PACKAGE_PIN U15 [get_ports {debug[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[5]}]
set_property PACKAGE_PIN U14 [get_ports {debug[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[6]}]
set_property PACKAGE_PIN V14 [get_ports {debug[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[7]}]
set_property PACKAGE_PIN V13 [get_ports {debug[8]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[8]}]
set_property PACKAGE_PIN V3 [get_ports {debug[9]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[9]}]
set_property PACKAGE_PIN W3 [get_ports {debug[10]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[10]}]
set_property PACKAGE_PIN U3 [get_ports {debug[11]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[11]}]
set_property PACKAGE_PIN P3 [get_ports {debug[12]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[12]}]
set_property PACKAGE_PIN N3 [get_ports {debug[13]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[13]}]
set_property PACKAGE_PIN P1 [get_ports {debug[14]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[14]}]
set_property PACKAGE_PIN L1 [get_ports {debug[15]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {debug[15]}]

##Buttons
set_property PACKAGE_PIN U18 [get_ports rst]
	set_property IOSTANDARD LVCMOS33 [get_ports rst]

## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]