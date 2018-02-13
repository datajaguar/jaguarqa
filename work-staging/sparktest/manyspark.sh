#!/bin/bash
num=$1
tot=$2
if [[ "x$tot" = "x" ]]; then
	tot=7;
fi

echo "$tot concurrent submit_spark.sh ..."
((n=1))
while ((n<=tot))
do
	./submit_spark.sh $num > "$n".log 2>&1 &
	((n=n+1))
done
