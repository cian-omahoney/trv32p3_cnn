puts "RM-info (asip) : Running script [info script]\n"

if {${EXPLORE_RTL_ID_LIST} != ""} {
    #Sweep of RTL blocks can only be done if all blocks are closed
    close_lib  -purge -force -all

    set EXPLORE_RTL_BLOCKS_LIST [list]
    set EXPLORE_INCLUDE_LIST [list]

    foreach ID ${EXPLORE_RTL_ID_LIST} {
        set RTL_BLOCK ${DESIGN_NAME}_${ID}.nlib:${DESIGN_NAME}/${INIT_DESIGN_LABEL_NAME}
        lappend EXPLORE_RTL_BLOCKS_LIST [list $RTL_BLOCK ${ID}]
        lappend EXPLORE_INCLUDE_LIST [list [list  var_list rtl_id ${ID}] [list block $RTL_BLOCK]]
    }
}

if {${EXPLORE_RTL_FREQ_LIST} != "" || ${EXPLORE_RTL_ID_LIST} != "" } {
    set EXPERT_EXPLORE_VARIABLE_MODE   true
    set EXPLORE_DESIGN_VARIABLE_LIST   "{ freq {$EXPLORE_RTL_FREQ_LIST} } { rtl_id {$EXPLORE_RTL_ID_LIST} }"
}

if { ${DISTRIBUTED} } {
    echo "#[date]" > asip_dist_env
    echo "set ASIP_LIB_SETUP  \"$::env(ASIP_LIB_SETUP)\"" >> asip_dist_env
    echo "set ASIP_SCRIPTS  \"$::env(ASIP_SCRIPTS)\"" >> asip_dist_env
}


puts "RM-info (asip) : Completed script [info script]\n"

