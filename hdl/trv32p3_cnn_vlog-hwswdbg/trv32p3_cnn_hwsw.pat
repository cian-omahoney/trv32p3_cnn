
# File generated by Go version U-2022.12#33f3808fcb#221128, Wed Feb 21 17:37:22 2024
# Copyright 2014-2022 Synopsys, Inc. All rights reserved.
# go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog-hwswdbg -cgo_options-hwswdbg.cfg -Itrv32p3_cnn_vlog-hwswdbg/tmp_pdg -updg -updg_controller trv32p3_cnn



# Pattern to parse Verdi HW/SW Debug's default format
# PARAMETERS: configName=trv32p3_cnn

# Comments: Ignore all lines starting with #
\#.*

# Instructions
%TIMESTAMP% PC %PC% %OPCODE_SIZE%

# Register assignments
%TIMESTAMP% Reg %REGNAME%(\[%REGBITRANGE%\])?(<%DEC%>)? %REGDATA%

# Memory accesses
%TIMESTAMP%  Mem %MEMSPACE% %RW%%MEMSIZE% %VADDR% %MEMDATA%
