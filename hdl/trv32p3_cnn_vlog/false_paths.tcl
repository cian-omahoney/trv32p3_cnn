# These files contain Synopsys Confidential Information as governed by a
# Synopsys End User Software License Agreement ('Agreement') between
# Synopsys, Inc. and recipient. Recipient will use the files solely in
# connection with exercising recipient's rights under the Agreement.
# Recipient will protect the files from unauthorized use or dissemination to
# third parties. THE FILES ARE PROVIDED 'AS IS', WITHOUT ANY WARRANTIES,
# WHETHER EXPRESS, IMPLIED OR OTHERWISE. SYNOPSYS SPECIFICALLY DISCLAIMS
# ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE.


set_false_path -through inst_cnn/cnn_R_out -through inst_mux_x_w1/x_w1_out -through inst_mux_x_w1_dead/x_w1_dead_out

set_false_path -through inst_lx/lxB_in -through inst_lx/lxR_out -through inst_reg_X/x_w4_in

set_false_path -through inst_lx/lxH_in -through inst_lx/lxR_out -through inst_reg_X/x_w4_in

set_false_path -through inst_mux_pcaB/of21_in -through inst_mux_pcaB/pcaB_out -through inst_pca/pcaR_out -through inst_mux___pidTGT_w/__pidTGT_w_out

set_false_path -through inst_reg_X/x_r4_out -through inst_mux_aguA/aguA_out -through inst_agu/aguR_out -through inst_mux_dm_addr/dm_addr_out

set_false_path -through inst_mux_pcaB/__CTt13s_s2_cstP31_12P7_11P25_10_5P8_4_1_ID_in -through inst_mux_pcaB/pcaB_out -through inst_pca/pcaR_out -through inst_mux_jmp_tgt_ID/jmp_tgt_ID_out

set_false_path -through inst_reg_X/x_r3_out -through inst_mux_aguA/aguA_out -through inst_agu/aguR_out -through inst_reg_X/x_w3_in

set_false_path -through inst_mux_pcaB/__CTt12s_cstP20_ID_in -through inst_mux_aguB/aguB_out -through inst_agu/aguR_out -through inst_reg_X/x_w3_in

set_false_path -through inst_mux_aguB/__CTt12s_cstP25_11_5P7_4_0_ID_in -through inst_mux_aguB/aguB_out -through inst_agu/aguR_out -through inst_reg_X/x_w3_in

