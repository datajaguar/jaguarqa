#!/bin/bash

#: Script Name: data_load.sh
#: Authors: Andrew Zhang
#: Reviewers:
#: Date: 10/17/2017
#: Purpose:     Basic funtion to load data in a new database.
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
#: History:

# 12/4/2017 Andrew Zhang
#           Added test cases after the fix of bug 033 for version 2.8.3.1.1.1

# Test Name: dataLoad.sh  
# Test select:

# Need two system environments:
# JAGUAR_HOME and QA_HOME  

FILE=data_load
FILE1=data_load1
FILE2=data_load2

PORT=`cat $HOME/jaguar/conf/server.conf |grep PORT|grep -v oport|grep -v '#'|cut -d= -f2`
HOST=127.0.0.1
USER=admin
PASSWORD=jaguar

logf="$QA_HOME/work/${FILE}.log"

#clean old log
if [ -f $logf ]
    then rm $logf
fi

$JAGUAR_HOME/bin/jag  -u $USER -p $PASSWORD  -h $HOST:$PORT -v yes < $QA_HOME/sql/${FILE}1.sql 2>&1 | tee -a $logf

# Re-start Jaguar server
jaguarstart_on_all_hosts.sh
#wait
jaguarstart_on_all_hosts.sh

loginj <  $QA_HOME/sql/${FILE}2.sql 2>&1 | tee -a $logf
#wait

echo -e "Result:  \n" 2>&1 | tee -a $logf

export FILE=data_load1
compare_result  $QA_HOME/work/${FILE}.out  $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

export FILE=data_load2
compare_result  $QA_HOME/work/${FILE}.out  $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

