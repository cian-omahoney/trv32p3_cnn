
CURRENTDIR=$(abspath $(shell pwd))
DESIGN_NAME=trv32p3_cnn

ifndef ASIP_SETUP
ASIP_SETUP=$(CURRENTDIR)/asip_setup
endif

ifneq ($(SAED32_HOME), $(null))
export ASIP_LIB_SETUP ?= $(ASIP_SETUP)/saed32
endif

export RTL_SOURCE_DIR ?= ../../

ASIP_LIB_SETUP_SAED32=$(ASIP_SETUP)/saed32

# DC_SHELL maybe dcnxt_shell or dc_shell; just specify on the commandline with 'make DC_SHELL=<shell>'
DC_SHELL=dcnxt_shell

define list_errors
	egrep -n -r "^Error" logs/ > list.error || true
	@echo "Peek at errors (max:40 lines):"; head -n 40 -v list.error
endef

default: asip

# If ASIP_LIB_SETUP is not defined, then using SAED32 setup as default (only if SAED32_HOME is set)
check_for_lib_setup:
	@if test -z ${ASIP_LIB_SETUP} ; then \
		echo "Error: Please set (environment) variable ASIP_LIB_SETUP (or SAED32_HOME)"; exit 1; \
	fi

asip: check_for_lib_setup
	mkdir -p logs/dc
	export ASIP_SETUP=$(abspath $(ASIP_SETUP)); \
	cd scripts_block; $(DC_SHELL) -topo -f rm_dc_scripts/dc.tcl | tee ../logs/dc/dc.log
	$(list_errors)

de: check_for_lib_setup
	mkdir -p logs/de
	export ASIP_SETUP=$(abspath $(ASIP_SETUP)); \
	cd scripts_block; de_shell -topo -f rm_dc_scripts/dc.tcl | tee ../logs/de/de.log
	$(list_errors)

dv: check_for_lib_setup
	export ASIP_SETUP=$(abspath $(ASIP_SETUP)); \
	cd scripts_block; \
	design_vision-xg -topo -x "source $(ASIP_SETUP)/asip_dc_setup.tcl; read_file -format ddc {results/$(DESIGN_NAME).mapped.ddc}";

orig:
	mkdir -p logs/dc
	export -n ASIP_SETUP; \
	cd scripts_block; $(DC_SHELL) -topo -f rm_dc_scripts/dc.tcl | tee ../logs/dc/dc.log

clean:
	-rm -rf logs/*
	-rm -rf list.error
	-rm -rf scripts_block/WORK_autoread
	-rm -rf scripts_block/__tmp_*
	-rm -rf scripts_block/alib-*
	-rm -rf scripts_block/reports
	-rm -rf scripts_block/results
	-rm -rf scripts_block/*.log

.PHONY: clean orig dv de asip default

