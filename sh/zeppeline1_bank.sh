#!/bin/bash

#: Script Name: zeppeline1_bank.sh  
#: Authors: Andrew Zhang
#: Reviewers:
#: Date: 1/30/2018
#: Purpose:     Prepare for testing datavisualization in zeppeline.
#: Test cases:
#       Use case 1:
#       -------------------------------------------------------------------
#
#: Component/Sub Comp:
#: Owned by: Andrew Zhang
#: Reviewed by:
#: Tag:
#: Dependencies: 
#: Runnable: true
#: Arguments: none
#: Memory/Disk: 200MB/200MB
#: SUC:  2
#: Created for:
#: Retired for:
#: Test time: within 10 sec

# Note: currently this is a bug


# Need two system environments:
# JAGUAR_HOME and QA_HOME  

FILE=zeppeline1_bank

PORT=`cat $HOME/jaguar/conf/server.conf |grep PORT|grep -v oport|grep -v '#'|cut -d= -f2`
HOST=127.0.0.1
USER=admin
PASSWORD=jaguar

logf="$QA_HOME/work/${FILE}.log"

#clean old log
if [ -f $logf ]
    then rm $logf
fi

# 1) Create table:

login < $QA_HOME/sql/zeppeline1_bank_createTable.sql 2>&1 | tee -a $logf

# 2) Data load:
# Decide how many load of the data for the bank.csv
num=1;
for i in $(seq "$num")
do
    echo "Load data for the number: ${i}th time" 2>&1 | tee -a $logf
    loginj < $QA_HOME/sql/zeppeline1_bank_loadData.sql 
done


# 3) Check the row counts

