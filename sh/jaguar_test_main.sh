#!/bin/bash

#: Script Name: jaguar_test_main.sh
#: Authors: Andrew Zhang
#: Reviewers: 
#: Date: 09/19/2017
#: Purpose:     Batch control datajaguar's regression tests.
#: Test cases: 
#       Use case 1: 
#       -------------------------------------------------------------------
#
#: Component/Sub Comp: 
#: Owned by: 
#: Tag: 
#: Dependencies: sql scriptscilab, python, etc
#: Runnable: true
#: Arguments: none
#: Memory/Disk: 200MB/200MB
#: SUC: 
#: Created for: 
#: Retired for:
#: Test time: within 10 sec
#: History:

# Note: In order to run test, we need to set the following system variables: 
# 1. QA_HOME 
# 2. JAGUAR_HOME 
# 3. ADMIN_PASSWORD 
# 

export ADMIN_PASSWORD=jaguar

FILE=jaguar_test_main
logf="$JAGUAR_TEST_HOME/work/${FILE}.log"

# Clean old log and work direcry::
rm  $QA_HOME/work/*.*

if [ -f $logf ]
    then rm $logf
fi

echo "Runing data_load.sh " 2>&1 | tee -a $logf
echo "========================="  2>&1 | tee -a $logf
echo "" 2>&1 | tee -a $logf
data_load.sh  2>&1 | tee -a $logf

echo "Runing create_db1_egift.sh now "     2>&1 | tee -a $logf
echo "=================================="  2>&1 | tee -a $logf
create_db1_egift.sh 2>&1 | tee -a $logf


echo ""  2>&1 | tee -a $logf
echo "Runing import_export_csv.sh now " 2>&1 | tee -a $logf
echo "============================"  2>&1 | tee -a $logf
import_export_csv.sh  2>&1 | tee -a $logf

echo ""  2>&1 | tee -a $logf
echo "Runing import_export_sql.sh  now " 2>&1 | tee -a $logf
echo "============================"  2>&1 | tee -a $logf
import_export_sql.sh 2>&1 | tee -a $logf

#echo ""  2>&1 | tee -a $logf
echo -e "\nNew Feature in 2.8.2.3 " 2>&1 | tee -a $logf
echo "Runing column_default.sh  now " 2>&1 | tee -a $logf
echo "============================"  2>&1 | tee -a $logf
column_default.sh 2>&1 | tee -a $logf

#  time_stamp.sh  2>&1 | tee -a $logf








