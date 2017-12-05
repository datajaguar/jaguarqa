#!/bin/bash

#: Script name: jaguar_init.sh 
#: Authors: Andrew Zhang
#: Reviewers: 
#: Date: 10/02/2017
#: Purpose:     Cleanup the jaguar db and setup a cleaned test environment.
#: Test cases: 
#       Use case 1: 
#       -------------------------------------------------------------------
#
#: Component/Sub Comp: 
#: Owned by: 
#: Tag: 
#: Dependencies: JAGUAR_HOME and QA_HOME 
#: Runnable: true
#: Arguments: none
#: Memory/Disk: 200MB/200MB
#: SUC: 
#: Created for: 
#: Retired for:
#: Test time: within 
#: History:

#: 10/23/2017 Andrew
#  Modified on ssd

# env settings
PORT=`cat $JAGUAR_HOME/conf/server.conf |grep PORT|grep -v oport|grep -v '#'|cut -d= -f2`
HOST=127.0.0.1
USER=admin
PASSWORD=jaguar


FILE=jaguar_init
logf="$QA_HOME/work/${FILE}.log"

if [ -f $logf ]; then
    rm $logf
fi

echo "##### Jaguar Initialization  #####" 2>&1 | tee -a $logf
echo "##############################" 2>&1 | tee -a $logf

echo "Part 1: jaguarstop_on_all_hosts.sh " 2>&1 | tee -a $logf
echo "#########################################################" 2>&1 | tee -a $logf
echo " "  >> $logf

# Shutdown servers 
jaguarstop_on_all_hosts.sh 2>&1 | tee -a $logf

wait 2>&1 | tee -a $logf

jaguarstatus_on_all_hosts.sh 2>&1 | tee -a $logf

wait

# clean up
echo "Part 3: jaguarstart_on_all_hosts.sh " 2>&1 | tee -a $log 

# Start:

echo "Part 4: Run clean_all.sh " 2>&1 | tee -a $logf
echo "#########################################################" 2>&1 | tee -a $logf
echo " "  >> $logf

clean_all.sh 2>&1 | tee -a $logf


jaguarstart_on_all_hosts.sh 2>&1 | tee -a $logf

wait 2>&1 | tee -a $logf


