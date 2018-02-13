#!/bin/bash
num=$1
/bin/rm -rf /tmp/sparkout.txt

export LD_LIBRARY_PATH=$HOME/jaguar/lib
JAR=$HOME/jaguar/lib/jaguar-jdbc-2.0.jar
PROJJAR=$HOME/sparktest/target/scala-2.10/testscalajdbc_2.10-1.0.jar
export SPARK_HOME=/opt/cloudera/parcels/CDH-5.9.0-1.cdh5.9.0.p0.23/lib/spark

date
t1=`date +'%s'`

/opt/cloudera/parcels/CDH-5.9.0-1.cdh5.9.0.p0.23/lib/spark/bin/spark-submit \
	--class TestScalaJDBC \
	--jars $JAR \
    --master local[1] \
	--driver-library-path $LD_LIBRARY_PATH \
    $PROJJAR 192.168.7.151 8888 $num

t2=`date +'%s'`
((dt=t2-t1))
date
echo "Total $t1 --- $t2  $dt seconds"
