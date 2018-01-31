#!/bin/bash

#: Script Name: carPlate.sh
#: Authors: Andrew Zhang
#: Reviewers:
#: Date: 1/30/2018
#: Purpose:     A test script to create and load data for new feature test.
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
#: SUC:  
#: Created for:
#: Retired for:
#: Test time: within 10 sec
#: History:


# Need two system environments:
# JAGUAR_HOME and QA_HOME  

FILE=carPlate

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



