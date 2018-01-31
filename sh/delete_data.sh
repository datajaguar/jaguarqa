#!/bin/bash

#: Script Name: delete_data.sh 
#: Authors: Andrew Zhang
#: Reviewers:
#: Date: 1/30/2018
#: Purpose:     Test deleting all data from the table.
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

FILE=delete_data

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

