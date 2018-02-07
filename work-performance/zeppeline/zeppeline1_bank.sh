#!/bin/bash

#: Script Name: zeppeline1_bank.sh 
#: Authors: Andrew Zhang
#: Reviewers:
#: Date: 1/30/2018
#: Purpose:     Prepare for testing data visualization in zeppeline.
#:              Create table load back data close to 30,000,000 row.
#       -------------------------------------------------------------------
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
# Run this test in command line:
# nohup zeppeline1_bank.sh  > zeppeline1_bank.sh.out & 


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

# 1) Create table with load 30,000,000 rows:

loginj < $QA_HOME/sql/zeppeline1_bank_createTable.sql 2>&1 | tee -a $logf

t1=`date +%s`
echo -e "\n==> Starting time is t1: $t1, `date` \n"


# 2) Data load:
# Decide how many load of the data for the bank.csv

# load about 100,006,732 rows 
num=2200
for i in $(seq "$num")
do
    echo "Load data for the number: ${i}th time" 2>&1 | tee -a $logf
    sleep 1
    loginj < $QA_HOME/sql/zeppeline1_bank_loadData.sql 
    echo "Done once"
    sleep 1
done

wait

# Calc the time required:
t2=`date +%s`
echo -e "\n\n ===> Ending time is t2: $t2, `date`"

let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds


# 3) Check the row counts

