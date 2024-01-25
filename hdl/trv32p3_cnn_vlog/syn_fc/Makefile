
# save current directory:
export ASIP_FC_DIR = $(abspath $(shell pwd))

FC_TARGET ?= all

ifneq ($(SAED32_HOME), $(null))
export ASIP_LIB_SETUP ?= $(ASIP_FC_DIR)/saed32
endif

#Configuration Variables for ASIP-flow
export ASIP_SCRIPTS ?= $(ASIP_FC_DIR)/asip_scripts
export UNIFIED_FLOW ?= true
export RTL_SOURCE_DIR ?= ../
export ASIP_SAIF_FILE
export ASIP_SAIF_INSTANCE
export ADDITIONAL_FC_SETUP

FC_EXEC ?= fc_shell

#Override enabled to used FC_EXEC, here exported
MAKEFLAGS += -e

## LOGS_DIR set to ./logs_fc
export LOGS_DIR ?= ./logs_fc

define list_errors
	@if test -d $(LOGS_DIR) ;\
	then \
		egrep -n "^Error" $(LOGS_DIR)/*.log* > $(LOGS_DIR)/list.error || true;\
		egrep -n -i "^RM-error" $(LOGS_DIR)/*.log* >> $(LOGS_DIR)/list.error || true;\
		echo "Peek at errors (max:40 lines):"; head -n 40 -v $(LOGS_DIR)/list.error;\
	fi
endef

default: asip

check_for_lib_setup:
	@if test -z ${ASIP_LIB_SETUP}; then \
		echo "Error: Please set (environment) variable ASIP_LIB_SETUP (or SAED32_HOME)"; exit 1;\
	fi

asip: check_for_lib_setup
	$(MAKE) -f rm_setup/Makefile $(FC_TARGET) ASIP_FLOW=1
	$(list_errors)

synthesis_only: check_for_lib_setup
	@echo "INFO: 'synthesis_only' forces FC_TARGET=compile and UNIFIED_FLOW=false, they can not be in this target overwritten."
	$(MAKE) -f rm_setup/Makefile compile ASIP_FLOW=1 UNIFIED_FLOW=false
	$(list_errors)

gui: check_for_lib_setup
	$(MAKE) -f rm_setup/Makefile console ASIP_FLOW=1 OPTIONS="-x \"source $(ASIP_SCRIPTS)/view_in_place.tcl; start_gui\" " | tee -i $(LOGS_DIR)/view_in_place.log

view_qor:
	$(FC_EXEC) $(OPTIONS) -batch -x "view_qor_data -location \"./compare_qor_data/index.html\" -no_web_server"

orig:
	$(MAKE) -f rm_setup/Makefile $(FC_TARGET)

clean:
	$(MAKE) -f rm_setup/Makefile clean
	-rm -rf HDL_LIBRARIES
	-rm -rf check_design*
	-rm -rf formality
	-rm -rf logs_fc
	-rm -rf outputs_fc
	-rm -rf rpts_fc
	-rm -rf *.nlib
	-rm -f *.svf
	-rm -f fc_command.log
	-rm -f fc_output.txt
	-rm -rf qor_data
	-rm -rf compare_qor_data
	-rm -f qor.csv

.PHONY: clean asip synthesis_only orig view_qor

