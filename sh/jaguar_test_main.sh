#!/bin/bash

#: Script Name: jaguar_test_main.sh
#: Authors: Andrew Zhang
#: Reviewers: 
#: Date: 09/19/2017
#: Purpose:     Batch control datajaguar's regression tests.
#: Test cases: 
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
#: Test time: dependent on the total number of test cases
#: History:

# Note: In order to run test, we need to set the following system variables: 
# 1. QA_HOME 
# 2. JAGUAR_HOME 
# 3. ADMIN_PASSWORD 
# 

# Starting time
t1=`date +%s`
echo -e "\n==> Starting time is t1: $t1, `date` \n"


export ADMIN_PASSWORD=jaguar

FILE=jaguar_test_main
logf="$QA_HOME/work/${FILE}.log"

# Back up and Clean old log and work direcry:
rm  $QA_HOME/work/*.*

if [ -f $logf ]

    then rm $logf
fi

if [ ! -f jaguar_test_list.txt ]
    then
        echo "File not existed: jaguar_test_list.txt"
fi

export VER=`cat $JAGUAR_HOME/conf/version.txt`
echo "##################################################################" 2>&1 | tee -a $logf
echo "#" 2>&1 | tee -a $logf
echo "# Automated regression test for jaguar database version $VER"     2>&1 | tee -a $logf
echo "# Date: `date`" 2>&1 | tee -a $logf
echo "#" 2>&1 | tee -a $logf
echo -e "#################################################################\n" 2>&1 | tee -a $logf

i=0
cat jaguar_test_list.txt |
while read line
do
    i=$(($i+1))
    
    echo "#################################################" 2>&1 | tee -a $logf
    echo "# Starting Test Case $i `ls  $line`"  2>&1 | tee -a $logf
    echo -e "#################################################\n" 2>&1 | tee -a $logf

    $line 2>&1 | tee -a $logf 
    wait
    
    echo -e "#################################################" 2>&1 | tee -a $logf
    echo " Test Case $i `ls  $line` is done" 2>&1 | tee -a $logf
    echo -e "#################################################\n" 2>&1 | tee -a $logf
    echo -e "\n Move to the next test cases, if this is not the last one. \n" 2>&1 | tee -a $logf
done

echo -e "\n\n#################################################\n" 2>&1 | tee -a $logf
echo -e "\n# Summary:\n" 2>&1 | tee -a $logf
echo -e "# Total excuted tests:   \n"  2>&1 | tee -a $logf
echo -e "`ls $QA_HOME/work/*.log` \n"  2>&1 | tee -a $logf

# Check suc and dif files:

echo -e "Total suc files: \n "  2>&1 | tee -a $logf
echo "`ls $QA_HOME/work/*.suc` \n"  2>&1 | tee -a $logf

echo -e "Total dif files: \n" 2>&1 | tee -a $logf
echo "`ls $QA_HOME/work/*.dif` \n" 2>&1 | tee -a $logf


# Ending time:
t2=`date +%s`
echo -e "\n\n ===> Ending time is t2: $t2, `date`"

let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal testing time in second: $deltatime"  2>&1 | tee -a $logf 
printf "Total testing time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds 2>&1 | tee -a $logf



