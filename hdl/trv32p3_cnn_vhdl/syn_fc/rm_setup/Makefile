##########################################################################################
# Tool: Fusion Compiler
# Script: Makefile
# Version: T-2022.06
# Copyright (C) 2014-2022 Synopsys, Inc. All rights reserved.
##########################################################################################

FC_EXEC = fc_shell 
FM_EXEC = fm_shell
VC_LP_EXEC = vc_static_shell
OPTIONS =

## LOGS_DIR value comes from rm_setup/design_setup.tcl; default is logs_fc
LOGS_DIR := $(subst $\",,$(shell expand rm_setup/design_setup.tcl | grep "^set LOGS_DIR" | awk '{print $$3}'))

# Parse configuration script and remove quotes
UNIFIED_FLOW := $(subst $\",,$(shell expand rm_setup/fc_setup.tcl | grep "^set UNIFIED" | awk '{print $$3}'))

## Optional: Specify design library if you want backup step and clean step to use it
## CAUTION: if added, the clean step will delete it
DESIGN_LIB =

console:
	$(FC_EXEC) $(OPTIONS)

config:
	echo "UNIFIED_FLOW = ${UNIFIED_FLOW}"

setup:
	test -d $(LOGS_DIR) || mkdir $(LOGS_DIR)
	date > setup

init_design: setup
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/init_design.tcl | tee -i $(LOGS_DIR)/init_design.log

compile: setup init_design 
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/compile.tcl |tee -i $(LOGS_DIR)/compile.log

place_opt: setup compile
ifeq ($(UNIFIED_FLOW),false)
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/place_opt.tcl | tee -i $(LOGS_DIR)/place_opt.log
else
	date > place_opt
endif

clock_opt_cts: setup place_opt
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/clock_opt_cts.tcl | tee -i $(LOGS_DIR)/clock_opt_cts.log

clock_opt_opto: setup clock_opt_cts
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/clock_opt_opto.tcl | tee -i $(LOGS_DIR)/clock_opt_opto.log

route_auto: setup clock_opt_opto
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/route_auto.tcl | tee -i $(LOGS_DIR)/route_auto.log

route_opt: setup route_auto
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/route_opt.tcl | tee -i $(LOGS_DIR)/route_opt.log

chip_finish: setup route_opt
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/chip_finish.tcl | tee -i $(LOGS_DIR)/chip_finish.log

icv_in_design: setup chip_finish
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/icv_in_design.tcl | tee -i $(LOGS_DIR)/icv_in_design.log

all: icv_in_design
	date > all

# Remember to also set WRITE_DATA_FROM_BLOCK_NAME to your desired step as input; default is icv_in_design
write_data: setup 
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/write_data.tcl | tee -i $(LOGS_DIR)/write_data.log

################################################################################################################
## Optional for Flat Synthesis and P&R 
################################################################################################################
# route_opt PBA-CCD targeted optimization
endpoint_opt: route_opt
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/endpoint_opt.tcl | tee -i $(LOGS_DIR)/endpoint_opt.log

# Timing Closure ECO flow
# The timing closure ECO target supports both eco_opt and a user provided change file.  This is controlled via
# the PT_ECO_CHANGE_FILE variable in fc_setup.tcl.  If filler cells or metal fill exists in the source design,
# they are automatically reinserted after the ECO.
timing_eco: setup
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/timing_eco.tcl | tee -i $(LOGS_DIR)/timing_eco.log

# Functional ECO flow
# The functional ECO target supports both freeze_silicon and MPI.  If filler cells or metal fill exists in the 
# source design, they are automatically reinserted after the ECO.  It is recommended that functional ECOs are 
# followed by a timing closure ECO.
functional_eco: setup
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/functional_eco.tcl | tee -i $(LOGS_DIR)/functional_eco.log

# Redhawk in-design analysis
# Specify the starting block using the REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME variable in design_setup.tcl
redhawk_in_design_pnr: setup
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/redhawk_in_design_pnr.tcl | tee -i $(LOGS_DIR)/redhawk_in_design_pnr.log

# RedHawk-SC in-design analysis
# Specify the starting block using the REDHAWK_IN_DESIGN_PNR_FROM_BLOCK_NAME variable in design_setup.tcl
rhsc_in_design_pnr: setup
	$(FC_EXEC) $(OPTIONS) -f ./rm_fc_scripts/rhsc_in_design_pnr.tcl | tee -i $(LOGS_DIR)/rhsc_in_design_pnr.log

# Formality
fm_r2g: setup write_data
	$(FM_EXEC) $(OPTIONS) -f ./rm_fc_scripts/fm_r2g.tcl | tee -i $(LOGS_DIR)/fm_r2g.log

fm_g2g: setup write_data
	$(FM_EXEC) $(OPTIONS) -f ./rm_fc_scripts/fm_g2g.tcl | tee -i $(LOGS_DIR)/fm_g2g.log

# Verification Compiler Low Power Static Signoff (VC LP)
vc_lp: setup write_data
	$(VC_LP_EXEC) -f ./rm_fc_scripts/vc_lp.tcl | tee -i $(LOGS_DIR)/vc_lp.log

################################################################################################################
# Utilities
################################################################################################################
##Backup
BACKUP  = BACKUP.`date "+%m_%d_%H_%M"`
backup:
	rm -rf $(BACKUP)
	mkdir -p $(BACKUP)
	cp -rf $(DESIGN_LIB) $(LOGS_DIR) $(BACKUP)

##Clean
clean:
	rm -f setup init_design compile place_opt clock_opt_cts clock_opt_opto route_auto route_opt chip_finish icv_in_design write_data all endpoint_opt timing_eco functional_eco redhawk_in_design_pnr rhsc_in_design_pnr fm_g2g fm_r2g vc_lp

clean_all: clean
	rm -rf $(LOGS_DIR) $(DESIGN_LIB)

