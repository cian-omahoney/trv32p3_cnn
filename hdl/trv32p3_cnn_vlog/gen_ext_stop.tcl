
# File generated by Go version U-2022.12#33f3808fcb#221128, Tue Mar 19 17:13:41 2024
# Copyright 2014-2022 Synopsys, Inc. All rights reserved.
# go -I../lib -F -DSYNTHESIS_NO_UNGROUP -D__tct_patch__=0 -Verilog -otrv32p3_cnn_vlog -cgo_options.cfg -Itrv32p3_cnn_vlog/tmp_pdg -updg -updg_controller trv32p3_cnn



while 1 {
    run 10us
    # check for stop token in actual directory:
    if { [file exists ./.EXT_STOP] } {
        finish
        break
    }
}
