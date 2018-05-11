#!/bin/bash

#: Script Name: image.sh
#: Authors: Andrew Zhang
#: Date: 2/20/2018
#: Purpose:     Test the loading and download media files: image(jpg)
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
# Limitation of this test: The test will alwasy generate a diff file as the UUID will 
# create a different number everytime we run the script; check the log file for the 
# result.
# 

export FILE=image
logf="$QA_HOME/work/${FILE}.log"

# 
export ADMIN_PASSWORD=jaguar

# Clean old log:
if [ -f $logf ]
    then mv $logf ${logf}_old
fi

# 1.Create table schema
echo -e "\n1. Create table and load data"  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $l
loginj < $QA_HOME/sql/${FILE}.sql 2>&1 | tee -a $logf 

wait

# 2. Check Correctness 
echo -e "\n\n2. Check Correctness..."  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $logf 

cd $QA_HOME/work
cksum IMG_4M.jpg req.jpg shanghai1.jpg > image2.out 

export FILE=image1
compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

export FILE=image2
compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

echo -e "\nEnd of test!"  2>&1 | tee -a $logf


