# save current directory:
export ASIP_RTLA_DIR = $(abspath $(shell pwd))

#Setting a default target
RTLA_TARGET ?= all

ifneq ($(SAED32_HOME), $(null))
export ASIP_LIB_SETUP ?= $(ASIP_RTLA_DIR)/saed32
endif

#Configuration Variables for ASIP-flows
export ASIP_SCRIPTS ?= $(ASIP_RTLA_DIR)/asip_scripts
export FLOW ?= flat
export RTL_SOURCE_DIR ?= ../

#Hierarchical
export PARTITION_LIST
export ABSTRACT_BLOCK_LIST

#Exploration
export UTILIZATION_LIST
export ASPECT_RATIO_LIST
export MAX_ROUTING_LAYER_LIST
export LIBRARY_LIST
export FREQ_LIST
export RTL_ID_LIST
export RTL_ID

#RTL-SAIF
export ASIP_SAIF_FILE
export ASIP_SAIF_INSTANCE

export RTL_EXEC ?= rtl_shell
export LOGS_DIR ?= logs_rtl
export ADDITIONAL_RTL_SETUP

HDL_PROJECT_BASENAME ?= $(shell sh -c "basename $(shell dirname $(ASIP_RTLA_DIR)) | rev | cut -d "_" -f1 --complement | rev")

init_designs := $(addprefix init_design_, $(RTL_ID_LIST))

#Override enabled to used RTL_EXEC, here exported
MAKEFLAGS += -e

default: flat

######### Checks of required variables for some flows ##########

check_for_lib_setup:
	@if test -z ${ASIP_LIB_SETUP}; then \
		echo "Error: Please set (environment) variable ASIP_LIB_SETUP (or SAED32_HOME)"; exit 1;\
	fi

check_for_partitions:
	@if test -z ${PARTITION_LIST} ; then \
		echo "Error: A non-empty partition list is required by the hierarchical flow."; \
		echo "Use: export PARTITION_LIST=\"<list_of_instances_to_be_physical_blocks>\" to define it."; exit 1;\
	fi

check_for_sweeping_parameters:
	@if [ -z "${UTILIZATION_LIST}" ] && \
	    [ -z "${ASPECT_RATIO_LIST}" ] && \
        [ -z "${MAX_ROUTING_LAYER_LIST}" ] && \
        [ -z "${FREQ_LIST}" ] && \
        [ -z "${RTL_ID_LIST}" ] ; then \
		echo "Error: At least one sweeping parameter is required by the exploration flow."; \
		echo "Sweeping parameters supported: UTILIZATION_LIST, ASPECT_RATIO_LIST, MAX_ROUTING_LAYER_LIST, FREQ_LIST and RTL_ID_LIST"; exit 1;\
	fi

########################## ASIP-Flows ##########################

flat: check_for_lib_setup
	$(MAKE) -f rm_setup/Makefile_rtla_flat $(RTLA_TARGET) ASIP_FLOW=1 FLOW="flat"

hier: check_for_lib_setup check_for_partitions
	$(MAKE) -f rm_setup/Makefile_rtla_hier $(RTLA_TARGET) ASIP_FLOW=1 FLOW="hier"

explore: check_for_lib_setup check_for_sweeping_parameters ${init_designs}
	$(MAKE) -f rm_setup/Makefile_rtla_explore $(RTLA_TARGET) ASIP_FLOW=1 FLOW="explore"

gui: check_for_lib_setup
	echo "start_gui" > start_gui
	$(MAKE) -f rm_setup/Makefile_rtla_$(FLOW) view_in_place ASIP_FLOW=1 OPTIONS="-f start_gui"

######################## Original-Flows ########################

org_flat:
	$(MAKE) -f rm_setup/Makefile_rtla_flat $(RTLA_TARGET)

org_hier:
	$(MAKE) -f rm_setup/Makefile_rtla_hier $(RTLA_TARGET)

org_explore:
	$(MAKE) -f rm_setup/Makefile_rtla_explore $(RTLA_TARGET)

############ Exploration of Different RTL versions #############

${init_designs}: init_design_%: setup
	@echo "Using as HDL project basename: $(HDL_PROJECT_BASENAME) and rtl_id:_$*";
	$(MAKE) -f rm_setup/Makefile_rtla_explore init_design ASIP_FLOW=1 FLOW="explore" \
	ASIP_SCRIPTS=../../$(HDL_PROJECT_BASENAME)_$*/syn_rtla/asip_scripts RTL_ID=_$* \
	RTL_SOURCE_DIR=../../$(HDL_PROJECT_BASENAME)_$* | tee -i $(LOGS_DIR)/$@.log
	@rm -f init_design

view_qor:
	$(RTL_EXEC) $(OPTIONS) -batch -x "view_qor_data -location \"./compare_qor_data/qorsum/index.html\" -no_web_server"

# setup: Make sure LOGS_DIR exists for 'init_designs' logging
setup:
	$(MAKE) -f rm_setup/Makefile_rtla_explore setup

################################################################
clean:
	$(MAKE) -f rm_setup/Makefile_rtla_flat clean
	$(MAKE) -f rm_setup/Makefile_rtla_hier clean
	$(MAKE) -f rm_setup/Makefile_rtla_explore clean
	@rm -rf HDL_LIBRARIES
	@rm -rf RTLA_WORKSPACE
	@rm -rf logs_rtl
	@rm -rf outputs_rtl
	@rm -rf rpts_rtl
	@rm -rf *.nlib
	@rm -rf work
	@rm -rf work_dir
	@rm -rf compare_qor_data
	@rm -rf qor_data
	@rm -rf block_budgets
	@rm -f rtl_architect.cfg
	@rm -f rtl_command.log
	@rm -f pwr_shell_command.log
	@rm -f parasitics_command.log
	@rm -f rtl_output.txt
	@rm -f *.svf
	@rm -f check_design*
	@rm -f init_design_*
	@rm -f splits
	@rm -f split_constraints.ems
	@rm -f start_gui
	@rm -f asip_dist_env

.PHONY: clean flat explore hier org_flat org_hier org_explore view_qor

