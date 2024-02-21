#!/bin/bash

SPY_REP_DIR=$1
SPY_PRJ=$2
SPY_GOAL=$3
SPY_REP_GOAL=`echo $SPY_GOAL | sed s,\/,_,g`
SPY_REPORT=${SPY_REP_DIR}/${SPY_PRJ}/consolidated_reports/${SPY_REP_GOAL}/moresimple.rpt

echo "Errors in ${SPY_REPORT}:"
echo "--------------------------------------"
rules=`grep Error ${SPY_REPORT} | awk '{print $2}' | uniq`
for rule in $rules ; do
    count=`grep $rule ${SPY_REPORT} | grep Error | wc -l`
    printf "Errors %-23s : %5s\n" $rule $count
done
echo "======================================"
count=`grep Error ${SPY_REPORT} | wc -l`
printf "Total Errors                   : %5s\n\n" $count

echo "Warnings in ${SPY_REPORT}:"
echo "--------------------------------------"
rules=`grep Warning ${SPY_REPORT} | awk '{print $2}' | uniq`
for rule in $rules ; do
    count=`grep $rule ${SPY_REPORT} | grep Warning | wc -l`
    printf "Warnings %-21s : %5s\n" $rule $count
done
echo "======================================"
count=`grep Warning ${SPY_REPORT} | wc -l`
printf "Total Warnings                 : %5s\n" $count
