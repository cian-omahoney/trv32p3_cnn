puts "RM-info (asip) : Running script [info script]\n"

switch ${RTL_SOURCE_LANGUAGE} {
   sverilog {
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

set_top_module ${DESIGN_NAME}

puts "RM-info (asip) : Completed script [info script]\n"

