#!/bin/bash
# Scrip Name: testjava.sh

. ./setpath.sh

FILE=testjava
logf="$QA_HOME/work/${FILE}.log"
#SAVE_LOG="2>&1 | tee -a $logf"

#clean old log
if [ -f $logf ]
        then rm $logf
fi

echo "##########################" 2>&1 | tee -a $logf
echo "# ${FILE}.log" 2>&1 | tee -a $logf
echo -e "############################\n" 2>&1 | tee -a $logf

export LD_LIBRARY_PATH=$JAGUAR_HOME/lib
#/bin/mkdir -p $HOME/arraydb_qatest
echo "Check lib files... "   2>&1 | tee -a $logf
ls -l $LD_LIBRARY_PATH/*.so  2>&1 | tee -a $logf 

port=`cat $JAGUAR_HOME/conf/server.conf |grep PORT|grep -v '#'|cut -d= -f2`
echo -e "\nConnect to jaguar at port $port ..." 2>&1 | tee -a $logf

### java test
echo -e "\nJava test ..." 2>&1 | tee -a $logf
jar=$JAGUAR_HOME/lib/jaguar-jdbc-2.0.jar
echo "jar file is at: $jar" 2>&1 | tee -a $logf

# Part 1: test exmple.java
# Might nned to run jbencj_insert.sh first

echo -e "\n# Command Line: javac -cp .:$jar example.java"           2>&1 | tee -a $logf
javac -cp .:$jar example.java                       2>&1 | tee -a $logf

echo -e "\n Command Line: java -cp .:$jar example $SERVER $port"   2>&1 | tee -a $logf
java -cp .:$jar example $SERVER $port > $QA_HOME/work/testjava_example.out 2>&1 | tee -a $logf

# Part 2: JaguarJDBCTest.java
echo -e "\n# Command Line: javac -cp .:$jar JaguarJDBCTest.java " 2>&1 | tee -a $logf 
javac -cp .:$jar JaguarJDBCTest.java                2>&1 | tee -a $logf

echo -e "\n# Command Line: java  -cp .:$jar JaguarJDBCTest $SERVER $port" 2>&1 | tee -a $logf
java  -cp .:$jar JaguarJDBCTest  $SERVER  $port > $QA_HOME/work/testjava_JaguarJDBCTest.out 2>&1 | tee -a $logf

# Compare the test result
compare_result $QA_HOME/work/testjava_example.out $QA_HOME/bas/testjava_example.bas 2>&1 | tee -a $logf
compare_result $QA_HOME/work/testjava_JaguarJDBCTest.out  $QA_HOME/bas/testjava_JaguarJDBCTest.bas 2>&1 | tee -a $logf

#java  -cp .:$jar JaguarJDBCTest 192.168.2.200  $port    
#java  -cp .:$jar JaguarJDBCTest 192.168.2.202  $port

# nnot useful
#java -Djava.library.path=$LD_LIBRARY_PATH -cp .:$jar JaguarJDBCTest  $port
