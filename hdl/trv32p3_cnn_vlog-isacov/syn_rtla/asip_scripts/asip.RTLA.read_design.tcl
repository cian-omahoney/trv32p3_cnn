puts "RM-info (asip) : Running script [info script]\n"

switch ${RTL_SOURCE_LANGUAGE} {
   sverilog {
      # Generated RTL by ASIP Designer contains System Verilog features in .v files
      set_app_options -name hdlin.autoread.sverilog_extensions -value ".sv .v"
      set_app_options -name hdlin.autoread.verilog_extensions -value ""
      puts "RM-info (asip) : Reading ${RTL_SOURCE_LANGUAGE} - RTL file(s)"
      analyze -autoread -top ${DESIGN_NAME} -rebuild -recursive ${RTL_SOURCE_FILES}
      elaborate ${DESIGN_NAME}
   }
   verilog {
      puts "RM-info (asip) : Reading ${RTL_SOURCE_LANGUAGE} - RTL file(s) using auto-read"
      analyze -autoread -top ${DESIGN_NAME} -rebuild -recursive ${RTL_SOURCE_FILES}
      elaborate ${DESIGN_NAME}
   }
   vhdl {
      puts "RM-info (asip) : Reading ${RTL_SOURCE_LANGUAGE} - RTL file(s) using auto-read"
      analyze -hdl_library ${DESIGN_NAME}_lib -autoread -top ${DESIGN_NAME} -rebuild -recursive ${RTL_SOURCE_FILES}
      elaborate -hdl_library ${DESIGN_NAME}_lib ${DESIGN_NAME}
   }
   default {
      puts "RM-error (asip) : Unknown RTL_SOURCE_LANGUAGE (${RTL_SOURCE_LANGUAGE})"
      exit 
   }
}
if {$EARLY_DATA_CHECK_POLICY != "none"} {
   puts "RM-info (asip) : Enabling Design check manager(DCM) setting"
	set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
}

set_top_module ${DESIGN_NAME}

if {$EARLY_DATA_CHECK_POLICY != "none"} {
   ## Report Early Data Check Results
	redirect -file ./${REPORTS_DIR}/${DESIGN_NAME}.report_early_data_checks.list_of_checks {report_early_data_checks -policy}
	redirect -file ./${REPORTS_DIR}/${DESIGN_NAME}.report_early_data_checks.rpt {report_early_data_checks -verbose}
} else {
   puts " RM-Info (asip) : Design check manager(DCM) is not enabled"
}
puts "RM-info (asip) : Completed script [info script]\n"

