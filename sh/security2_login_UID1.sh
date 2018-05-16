#!/bin/bash

#: Script Name: security2_login_UID1.sh
#: Authors: Andrew Zhang
#: Date: 5/4/2018
#: Purpose:   Login as UID1 and change password. 
#: Test cases: 
#       Use case 1: 
#       -------------------------------------------------------------------
#
#: Component/Sub Comp: 
#: Owned by: Andrew Zhang 
#: Reviewed by:
#: Tag: 
#: Dependencies: QA_HOME framework and login_UID1 
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

export FILE=security2_login_UID1
logf="$QA_HOME/work/${FILE}.log"

# 
export ADMIN_PASSWORD=jaguar

# Clean old log:
if [ -f $logf ]
    then mv $logf ${logf}_old
fi

CMD_LOG=2>&1 | tee -a $logf

# 1.Create table schema

echo -e "\n1. Create table and load data\n" $CMD_LOG  
echo -e "\n============================== \n" 2>&1 | tee -a $logf

login_UID1 < $QA_HOME/sql/${FILE}.sql 2>&1 | tee -a $logf 

wait


# 2. Check Correctness 
echo -e "\n\n2. Check Correctness..."  $CMD_LOG
echo -e "=========================== \n" $CMD_LOG


compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas  $CMD_LOG 

echo -e "\nEnd of test ${FILE}.sh"  $CMD_LOG


