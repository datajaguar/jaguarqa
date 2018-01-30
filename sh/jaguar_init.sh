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
#: History
#: 1/29/2018, Updated for windows 

#: Note: 
#: Please be cautious when run this script: it will delete all the previouse data
#: and logs file.

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

echo "##################################" 2>&1 | tee -a $logf
echo "##### Jaguar Initialization  #####" 2>&1 | tee -a $logf
echo "##################################" 2>&1 | tee -a $logf

echo -e "\n# Part 1: Stop jaguar database " 2>&1 | tee -a $logf
echo "##################################" 2>&1 | tee -a $logf

# Shutdown servers 
un=`uname -o`
if [[ "x$un" = "xMsys" ]]; then
	exec $JAGUAR_HOME/bin/jaguarstop 	2>&1 | tee -a $logf
elif	[[ "x$un" = "xCygwin" ]]; then 		2>&1 | tee -a $logf
	exec $JAGUAR_HOME/bin/jaguarstop
else 
	exec $JAGUAR_HOME/bin/jaguarstop_on_all_hosts.sh 2>&1 | tee -a $logf

fi

wait 

# clean up

echo -e "\n# Part 2: Clean data and logs " 2>&1 | tee -a $logf
echo "########################################" 2>&1 | tee -a $logf


if [[ "x$un" = "xMsys" ]]; then
        $QA_HOME/sh/clean_all_windows.sh        2>&1 | tee -a $logf
elif    [[ "x$un" = "xCygwin" ]]; then     2>&1 | tee -a $logf
	$QA_HOME/sh/clean_all_windows.sh
else
      $QA_HOME/sh/clean_all.sh 2>&1 | tee -a $logf
fi 


# Start servers
echo -e "\n# Part 3: Start jaguar database" 2>&1 | tee -a $logf
echo "#######################################" 2>&1 | tee -a $logf

un=`uname -o`
if [[ "x$un" = "xMsys" ]]; then
	exec $JAGUAR_HOME/bin/jaguarstart 	2>&1 | tee -a $logf
elif    [[ "x$un" = "xCygwin" ]]; then
        exec exec $JAGUAR_HOME/bin/jaguarstart	2>&1 | tee -a $logf
else
        exec $JAGUAR_HOME/bin/jaguarstart_on_all_hosts.sh 2>&1 | tee -a $logf
fi

	
wait



