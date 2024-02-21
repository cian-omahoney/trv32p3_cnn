
set set_technology_cmd "set_technology -node"
if {$TECH_NODE != ""} {
              puts "RM-info : Setting technology node. \n"
              lappend set_technology_cmd $TECH_NODE
              echo $set_technology_cmd
              eval $set_technology_cmd
}

#Disabling AutoUngroup and BoundaryOptimization
set_app_options -name compile.flow.autoungroup -value false
set_app_options -name compile.flow.boundary_optimization -value false
set_app_options -name compile.flow.constant_and_unloaded_propagation_with_no_boundary_opt -value false


