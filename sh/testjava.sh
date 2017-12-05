#!/bin/bash
# Scrip Name: testjava.sh

. ./setpath.sh

FILE=testjava
#logf="${FILE}.log"
logf="$QA_HOME/work/${FILE}.out"

export LD_LIBRARY_PATH=$JAGUAR_HOME/lib
/bin/mkdir -p $HOME/arraydb_qatest
ls -l $LD_LIBRARY_PATH/*.so

port=`cat $JAGUAR_HOME/conf/server.conf |grep PORT|grep -v '#'|cut -d= -f2`
echo "Connect to jaguar at port $port ..." 2>&1 | tee -a $logf


### java test
echo "Java test ..." 2>&1 | tee -a $logf
jar=$JAGUAR_HOME/lib/jaguar-jdbc-2.0.jar

javac -cp .:$jar $jaguar_qatest_root/example.java           2>&1 | tee -a $logf
java -cp .:$jar $jaguar_qatest_root/example $SERVER $port    2>&1 | tee -a $logf

javac -cp .:$jar $jaguar_qatest_root/JaguarJDBCTest.java     2>&1 | tee -a $logf
java  -cp .:$jar $jaguar_qatest_root/JaguarJDBCTest  $SERVER  $port  2>&1 | tee -a $logf


#java  -cp .:$jar JaguarJDBCTest 192.168.2.200  $port    
#java  -cp .:$jar JaguarJDBCTest 192.168.2.202  $port

# nnot useful
#java -Djava.library.path=$LD_LIBRARY_PATH -cp .:$jar JaguarJDBCTest  $port
