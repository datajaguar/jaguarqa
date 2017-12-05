#!/bin/bash

#: Script Name: column_default.sh
#: Authors: Andrew Zhang
#: Reviewers: 
#: Date: 11/10/2017
#: Purpose:     Test the default column for bit, int, and UUID
#: Test cases: 
#       Use case 1: 
#       -------------------------------------------------------------------
#
#: Component/Sub Comp: 
#: Owned by: Andrew Zhang 
#: Reviewed by:
#: Tag: 
#: Dependencies: QA_HOME framework and loginj 
#: Runnable: true
#: Arguments: none
#: Memory/Disk: 200MB/200MB
#: SUC:  2
#: Created for: 
#: Retired for:
#: Test time: within 10 sec
#: History:

# Note: In order to run test, we need to set two 
# 

FILE=column_default
logf="$QA_HOME/work/${FILE}.log"

# 
export ADMIN_PASSWORD=jaguar

# Clean old log:
if [ -f $logf ]
    then mv $logf ${logf}_old
fi

# Clean up the database and log files

# 1.Create table and load data
echo -e "\n1. Create table and load data"  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $logf 
loginj < $QA_HOME/sql/${FILE}.sql 2>&1 | tee -a $logf  2>&1 | tee -a $logf 

sleep 3 

# 2. Compare results
echo -e "\n\n2. Compare results "  2>&1 | tee -a $logf
echo -e "================================ "  2>&1 | tee -a $logf  

compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

echo "End of test: ${FILE}.sh! " 2>&1 | tee -a $logf 


