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

export ADMIN_PASSWORD=jaguar

FILE=jaguar_test_main_test
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
    echo "# Test $i `ls  $line`"  2>&1 | tee -a $logf
    echo -e "#################################################\n" 2>&1 | tee -a $logf

# Just check to see if loop to the end:
#    $line 2>&1 | tee -a $logf 
    ls  $line >&1 | tee -a $logf
wait
    
    echo -e "#################################################\n" 2>&1 | tee -a $logf
    echo "Test_$i `ls  $line` is done" 2>&1 | tee -a $logf
done

echo "done with test"

exit

echo -e "\n#################################################\n" 2>&1 | tee -a $logf
echo "# Summary:" 2>&1 | tee -a $logf
echo "# Total exexuted tests:"  2>&1 | tee -a $logf
echo "ls $QA_HOME/work/*.log" 2>&1 | tee -a $logf

echo -e "Total suc files: `ls $QA_HOME/work/*.suc |wc`"  2>&1 | tee -a $logf
echo "Total dif files: `ls $QA_HOME/work/*.dif`" 2>&1 | tee -a $logf

