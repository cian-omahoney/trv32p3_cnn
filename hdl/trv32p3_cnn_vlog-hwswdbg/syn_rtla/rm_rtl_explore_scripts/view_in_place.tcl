##########################################################################################
# Tool: RTL Architect
# Script: view_in_place.tcl
# Version: T-2022.06
# Copyright (C) 2019-2022 Synopsys, Inc. All rights reserved.
##########################################################################################
source -echo ./rm_setup/rtl_setup.tcl > /dev/null

echo ""

open_lib ${WORK_DIR}/${DESIGN_LIBRARY} -read > /dev/null
set COPY_LABEL_NAME copy

set COPY_VALUE			""
set INIT_DESIGN_VALUE 		""	
set CONDITIONING_VALUE 		""	
set ESTIMATION_VALUE 		""
set SPLIT_CONSTRAINTS_VALUE 	""	
set COMMIT_VALUE 		""			
set BLOCK_CONDITIONING_VALUE 	""
set TOP_CONDITIONING_VALUE 	""
set FLOORPLANNING_VALUE 	""
set BLOCK_ESTIMATION_VALUE 	""
set TOP_ESTIMATION_VALUE 	""
set METRICS_VALUE 		""
set RTL_OPT_VALUE		""
set SPLITS_VALUE		""
set EXPLORE_DESIGN_VALUE		""

set stage_list 			""
set i 0
foreach stage "$COPY_LABEL_NAME  $INIT_DESIGN_LABEL_NAME  $CONDITIONING_LABEL_NAME  $ESTIMATION_LABEL_NAME  $SPLIT_CONSTRAINTS_LABEL_NAME  $COMMIT_LABEL_NAME  $BLOCK_CONDITIONING_LABEL_NAME  $TOP_CONDITIONING_LABEL_NAME  $FLOORPLANNING_LABEL_NAME  $BLOCK_ESTIMATION_LABEL_NAME  $TOP_ESTIMATION_LABEL_NAME $METRICS_LABEL_NAME  $RTL_OPT_LABEL_NAME  $SPLITS_LABEL_NAME $EXPLORE_DESIGN_LABEL_NAME" {
   if {[sizeof_collection [get_blocks -quiet -all $DESIGN_LIBRARY:$DESIGN_NAME/$stage.*]]} {
      incr i
      switch $stage \
	$COPY_LABEL_NAME                 	{echo "   $i. $COPY_LABEL_NAME"			;      	set stage_list [lappend stage_list  $i]; set COPY_VALUE 		$i}    \
 	$INIT_DESIGN_LABEL_NAME    		{echo "   $i. $INIT_DESIGN_LABEL_NAME"		; 	set stage_list [lappend stage_list  $i]; set INIT_DESIGN_VALUE       	$i}    \
 	$CONDITIONING_LABEL_NAME   		{echo "   $i. $CONDITIONING_LABEL_NAME"		;      	set stage_list [lappend stage_list  $i]; set CONDITIONING_VALUE      	$i}    \
 	$ESTIMATION_LABEL_NAME     		{echo "   $i. $ESTIMATION_LABEL_NAME"		;    	set stage_list [lappend stage_list  $i]; set ESTIMATION_VALUE        	$i}    \
 	$SPLIT_CONSTRAINTS_LABEL_NAME    	{echo "   $i. $SPLIT_CONSTRAINTS_LABEL_NAME"	;    	set stage_list [lappend stage_list  $i]; set SPLIT_CONSTRAINTS_VALUE 	$i}    \
 	$COMMIT_LABEL_NAME    			{echo "   $i. $COMMIT_LABEL_NAME"		;    	set stage_list [lappend stage_list  $i]; set COMMIT_VALUE 	    	$i}    \
 	$BLOCK_CONDITIONING_LABEL_NAME    	{echo "   $i. $BLOCK_CONDITIONING_LABEL_NAME"	;    	set stage_list [lappend stage_list  $i]; set BLOCK_CONDITIONING_VALUE 	$i}    \
 	$TOP_CONDITIONING_LABEL_NAME    	{echo "   $i. $TOP_CONDITIONING_LABEL_NAME"	;    	set stage_list [lappend stage_list  $i]; set TOP_CONDITIONING_VALUE 	$i}    \
 	$FLOORPLANNING_LABEL_NAME    		{echo "   $i. $FLOORPLANNING_LABEL_NAME"	;    	set stage_list [lappend stage_list  $i]; set FLOORPLANNING_VALUE    	$i}    \
 	$BLOCK_ESTIMATION_LABEL_NAME    	{echo "   $i. $BLOCK_ESTIMATION_LABEL_NAME"	;    	set stage_list [lappend stage_list  $i]; set BLOCK_ESTIMATION_VALUE 	$i}    \
 	$TOP_ESTIMATION_LABEL_NAME    		{echo "   $i. $TOP_ESTIMATION_LABEL_NAME"	;      	set stage_list [lappend stage_list  $i]; set TOP_ESTIMATION_VALUE    	$i}    \
	$METRICS_LABEL_NAME    			{echo "   $i. $METRICS_LABEL_NAME"		;  	set stage_list [lappend stage_list  $i]; set METRICS_VALUE           	$i}    \
	$RTL_OPT_LABEL_NAME			{echo "   $i. $RTL_OPT_LABEL_NAME"		;	set stage_list [lappend stage_list  $i]; set RTL_OPT_VALUE		$i}    \
	$SPLITS_LABEL_NAME			{echo "   $i. $SPLITS_LABEL_NAME"		;	set stage_list [lappend stage_list  $i]; set SPLITS_VALUE		$i}    \
	$EXPLORE_DESIGN_LABEL_NAME	{echo "   $i. $EXPLORE_DESIGN_LABEL_NAME"		;	set stage_list [lappend stage_list  $i]; set EXPLORE_DESIGN_VALUE		$i}    \

    }
}

echo "\n   0. exit\n"; set stage_list [lappend stage_list 0]

while 1 {
   echo -n "Please enter a number to select an existing design library: "
   set answer [gets stdin]
   if {[lsearch -all $stage_list $answer] >= 0} {
      break
   } else {
      echo "The number you extered does not exist."
   }
}

if {$answer == 0}                               {exit} 
if {$answer == $COPY_VALUE         	 }      {set LABEL_NAME $COPY_LABEL_NAME		}
if {$answer == $INIT_DESIGN_VALUE        }      {set LABEL_NAME $INIT_DESIGN_LABEL_NAME		}      	
if {$answer == $CONDITIONING_VALUE       }      {set LABEL_NAME $CONDITIONING_LABEL_NAME	}     	
if {$answer == $ESTIMATION_VALUE         }      {set LABEL_NAME $ESTIMATION_LABEL_NAME		}               
if {$answer == $SPLIT_CONSTRAINTS_VALUE  }      {set LABEL_NAME $SPLIT_CONSTRAINTS_LABEL_NAME	} 	
if {$answer == $COMMIT_VALUE             }      {set LABEL_NAME $COMMIT_LABEL_NAME		}			
if {$answer == $BLOCK_CONDITIONING_VALUE }      {set LABEL_NAME $BLOCK_CONDITIONING_LABEL_NAME	}      
if {$answer == $TOP_CONDITIONING_VALUE   }      {set LABEL_NAME $TOP_CONDITIONING_LABEL_NAME	}         
if {$answer == $FLOORPLANNING_VALUE      }      {set LABEL_NAME $FLOORPLANNING_LABEL_NAME	}            
if {$answer == $BLOCK_ESTIMATION_VALUE   }      {set LABEL_NAME $BLOCK_ESTIMATION_LABEL_NAME	}         
if {$answer == $TOP_ESTIMATION_VALUE     }      {set LABEL_NAME $TOP_ESTIMATION_LABEL_NAME	}   
if {$answer == $METRICS_VALUE            }      {set LABEL_NAME $METRICS_LABEL_NAME		} 
if {$answer == $RTL_OPT_VALUE            }      {set LABEL_NAME $RTL_OPT_LABEL_NAME		}
if {$answer == $SPLITS_VALUE             }      {set LABEL_NAME $SPLITS_LABEL_NAME		} 
if {$answer == $EXPLORE_DESIGN_VALUE     }      {set LABEL_NAME $EXPLORE_DESIGN_LABEL_NAME		}

######### BEGIN CHANGED FOR ASIP SCRIPTS ############
# Also EXPLORE_DESIGN_VALUE and EXPLORE_DESIGN_LABEL_NAME
# added in previous lines to enable the view in place of
# the explore_design stage
set explore_work_dir "./work_dir/run_explore_design/"
if {$LABEL_NAME == $EXPLORE_DESIGN_LABEL_NAME &&
    [file exists $explore_work_dir]} {
   try {
      set result [exec -- grep -r "open_block" $explore_work_dir --include=*one_run.tcl -h]
   } on error {e} {
      # typically, pattern not found
      set result ""
      echo "No explore designs found in $explore_work_dir: $e"
      exit
   }
   echo "\n Explored designs:"
   set i 1; array set blocks {}
   set wd [file join [pwd] work ]
   foreach {open_block block} $result {
      regsub ***=${wd}/ $block "" block
      echo "   $i. $block"
      set blocks($i) $block; incr i
   }
   echo "\n   0. exit\n"
   while 1 {
      echo -n "Please enter a number to select an existing block: "
      set answer [gets stdin]
      if {$answer == 0} { exit }
      if {[info exists blocks($answer)]} {
         close_lib
         puts "RM-info (asip): Opening block ${wd}/$blocks($answer)"
         open_block ${wd}/$blocks($answer) -ref_libs_for_edit
         break
      } else {
         echo "The number you selected does not exist."
      }
   }
} else {
######### END CHANGED FOR ASIP SCRIPTS ##############
   if {[sizeof_collection [get_blocks -quiet ${DESIGN_NAME}/${LABEL_NAME}.design -all]]} {
      puts "RM-info : Opening block ${DESIGN_NAME}/${LABEL_NAME}.design"
      open_block ${DESIGN_NAME}/${LABEL_NAME} -ref_libs_for_edit
   } else {
      puts "RM-info : Opening block ${DESIGN_NAME}/${LABEL_NAME}.outline"
      open_block ${DESIGN_NAME}/${LABEL_NAME}.outline
   }
}
# execute a couple commands to make the GUI work without delay
puts "RM-info : Running link_block"
link_block

