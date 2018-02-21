#!/bin/bash

# Note: This test is not currently updated!

# Main test to control the batch sql
# Script Name: jaguarMainFunc.sh
# Created by: Andrew Zhang
# Date: NovJune 27, 2015
#

# Note:
# Need two system environments:
# JAGUAR_HOME and QA_HOME

# env settings
FILE=jaguar_accept_main
PORT=`cat $JAGUAR_HOME/conf/server.conf |grep PORT|grep -v oport|grep -v '#'|cut -d= -f2`
HOST=127.0.0.1
USER=admin
PASSWORD=jaguar


# Test 1:
# Create database and grant ussers; 

#if [ ! -d "jaguarMainFunc_log" ]; then
 #   /bin/mkdir -p jaguarMainFunc_log
#fi

logf="$QA_HOME/work/${FILE}.log"

if [ -f $logf ]; then
    rm $logf
fi

echo "##### Jaguar Acceptance Function Test #####" 2>&1 | tee -a $logf
echo "##############################" 2>&1 | tee -a $logf

echo "Part 1: Now Running: Use jadmin to create user, db, etc" 2>&1 | tee -a $logf
echo "#########################################################" 2>&1 | tee -a $logf
echo " "  >> $logf

# 
$JAGUAR_HOME/bin/jag -u $USER -p $PASSWORD  -e "dropdb myJaguar1" -h $HOST:$PORT -v yes 2>&1 | tee -a $logf
echo "dropdb myJaguar1" 2>&1 | tee -a $logf

#$HOME/jaguar/bin/jag -u $USER -p $PASSWORD -e  "createdb myJaguar1" -h $HOST:$PORT -v yes 2>&1 | tee -a $logf
#echo "createdb myJaguar1" 2>&1 | tee -a $logf

exit

$HOME/jaguar/bin/jag -u $USER -p $PASSWORD -e "createdb myJaguar2" -h $HOST $HOST:$port -v yes
echo "createdb myJaguar2"

$HOME/jaguar/bin/jag -u admin -p jaguar -e "createuser user_myJaguar1:password" -h :$port -v yes
echo "createuser user_myJaguar1:password"

$HOME/jaguar/bin/jag -u admin -p jaguar -e "createuser user_myJaguar2:password" -h :$port -v yes
echo "jadmin createuser user_myJaguar2:password"

$HOME/jaguar/bin/jag -u admin -p jaguar -e "dropdb myJaguar2" -h :$port -v yes
echo "dropdb myJaguar2"

$HOME/jaguar/bin/jag -u admin -p jaguar -e "dropuser user_myJaguar2" -h :$port -v yes
echo "dropuser user_myJaguar2"

$HOME/jaguar/bin/jag -u admin -p jaguar -e "createuser test:test" -h :$port -v yes
echo "createuser test:test"

echo "Now run jaguarFunc.sql:" 2>&1 | tee -a $logf
echo "#####################" 2>&1 | tee -a $logf

echo "$HOME/jaguar/bin/jag -u user_myJaguar1 -p password -d myJaguar1  -h 127.0.0.1:$port  -v yes"
$HOME/jaguar/bin/jag -u user_myJaguar1 -p password -d myJaguar1  -h 127.0.0.1:$PORT  -v yes < $QA_HOME/sql/${FILE}.sql 2>&1 | tee -a $logf

