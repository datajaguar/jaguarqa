#!/bin/bash

#: Script Name: function1.sh
#: Authors: Andrew Zhang
#: Date: 1/16/2018
#: Purpose:     Test all the functions supported 
#: Test cases: 
#       Use case 1: 
#       -------------------------------------------------------------------
#
#: Component/Sub Comp: 
#: Owned by: Andrew Zhang 
#: Reviewed by:
#: Tag: #: Dependencies: QA_HOME framework and loginj 
#: Runnable: true
#: Arguments: none
#: Memory/Disk: 200MB/200MB
#: SUC:  1
#: Created for: 
#: Retired for:
#: Test time: within 10 sec
#: History:

# Note: In order to run test, we need to set two 
#
# Limitation of this test: The test will alwasy generate a diff file as the UUID will 
# create a different number everytime we run the script; check the log file for the 
# result.
# 

export FILE=function1
logf="$QA_HOME/work/${FILE}.log"

 
export ADMIN_PASSWORD=jaguar

if [ ! -d "$QA_HOME/work" ]; then
	echo "No work dir"
	mkdir $QA_HOME/work
	echo "$QA_HOME/work was created"

fi


# Clean old log:
if [ -f $logf ]; then
    rm $logf 
fi

# 1.Create table schema
echo -e "\n1. Create table and load data"  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $l
loginj < $QA_HOME/sql/${FILE}.sql 2>&1 | tee -a $logf 

wait

# 2. Check Correctness 
echo -e "\n2. Check Correctness..."  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $logf 

compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

echo "End of test ${FILE}.sh" 2>&1 | tee -a $logf


