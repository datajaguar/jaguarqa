#!/bin/bash

#: Script Name: security.sh
#: Authors: Andrew Zhang
#: Date: 6/5/2018
#: Purpose:     Security test 1: Create users. 
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
#: SUC:  1
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
# Features:
# Create use 


export FILE=security
logf="$QA_HOME/work/${FILE}.log"

# 
export ADMIN_PASSWORD=jaguarjaguarjaguar

# Clean old log:
if [ -f $logf ]
    then mv $logf ${logf}_old
fi

echo "Create user"

PORT=`grep PORT $JAGUAR_HOME/conf/server.conf |grep -v '#' | awk -F= '{print $2}'`
HOST=localhost

UID1=User1
UID2=User2
UID_g1=User_g1
UID_g2=User_g2

PASSWORD1=Pawd5678901234
PASSWORD2='Pawd56789012 34'

# $JAGUAR_HOME/bin/jag -u admin -p jaguarjaguarjaguar -h $HOST:$PORT


# 1.Create table schema
echo -e "\n1. Create table and load data"  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $l
$JAGUAR_HOME/bin/jag -u admin -p jaguarjaguarjaguar -h $HOST:$PORT  << EOF > security.out 
show databases;

createuser $UID1:$PASSWORD1;




EOF

exit

# 2. Check Correctness 
echo -e "\n2. Check Correctness..."  2>&1 | tee -a $logf
echo -e "============================== \n"  2>&1 | tee -a $logf 

compare_result $QA_HOME/work/${FILE}.out $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

echo -e "\nEnd of test ${FILE}.sh" 2>&1 | tee -a $logf


