puts "RM-info (asip) : Running script [info script]\n"
##########################################################################################
# Tool: RTL Architect
# Script: init_design.read_parasitic_tech_example.tcl (template)
# Version: T-2022.06-SP4
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

##############################################################################################
# The following is a sample script to read two TLU+ files, 
# which you can expand to accomodate your design.
##############################################################################################

########################################
## Variables
########################################
## Parasitic tech files for read_parasitic_tech command; expand the section as needed
set tluplus_file($parasitic1)           "$G_MAX_TLUPLUS_FILE" ;# TLU+ files to read for parasitic 1
set layer_map_file($parasitic1)         "$G_TLUPLUS_MAP_FILE" ;# layer mapping file between ITF and tech for parasitic 1

set tluplus_file($parasitic2)           "$G_MIN_TLUPLUS_FILE" ;# TLU+ files to read for parasitic 2
set layer_map_file($parasitic2)         "$G_TLUPLUS_MAP_FILE" ;# layer mapping file between ITF and tech for parasitic 2

########################################
## Read parasitic files
########################################
## Read in the TLUPlus files first.
#  Later on in the corner constraints, you can then refer to these parasitic models.
foreach p [array name tluplus_file] {  
	puts "RM-info: read_parasitic_tech -tlup $tluplus_file($p) -layermap $layer_map_file($p) -name $p"
	read_parasitic_tech -tlup $tluplus_file($p) -layermap $layer_map_file($p) -name $p
}

puts "RM-info (asip) : Completed script [info script]\n"

