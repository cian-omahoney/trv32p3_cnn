
#################################################################################
##           Copyright (c) 1988 - 2020 Synopsys, Inc. All rights reserved.      #
##                                                                              #
##     This Synopsys TestMAX product and all associated documentation are       #
##     proprietary to Synopsys, Inc. and may only be used pursuant to the       #
##     terms and conditions of a written license agreement with Synopsys, Inc.  #
##     All other use, reproduction, modification, or distribution of the        #
##     Synopsys Testmax product or associated documentation is                  #
##     strictly prohibited.                                                     #
##                                                                              #
#################################################################################
##                                                                              #
##                                                                              #
##                                                                              #
## DEFAULT DFT SCRIPT FOR RTLA                                                                              #
#################################################################################

#create a port for TestMode if not exists and use it as TestMode port for DFT
create_port -dir in {TM }
set_dft_signal -view spec -type TestMode -port TM

#create ports for ScanDataIn and ScanDataOut and use them for DFT
#Default numbers of SI/SO is 32
for {set i 0} {$i < 32} {incr i} {
create_port -dir in si$i
create_port -dir out so$i
set_dft_signal -view spec -type ScanDataIn -port si$i 
set_dft_signal -view spec -type ScanDataOut -port so$i 
}


#DFT port for ScanEnable Signal
create_port scan_enable -direction in
set_dft_signal -view spec -type ScanEnable -port scan_enable

#DFT port for ScanClock
create_port -dir in clk_a 
set_dft_signal -view existing -type ScanClock -port clk_a -timing {45 75}

#Enable DFT client for SCAN
set_dft_configuration -scan enable

#Enable DFT client for Compression
set_dft_configuration -scan_compression enable

#Specify Scan Configuration
set_scan_configuration -max_length 300

#Specify Compression Configuration
#set_scan_compression_configuration -input 32 -output 32 

