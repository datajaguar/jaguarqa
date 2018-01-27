#!/bin/bash

n=$1

if [[ "x$n" = "x" ]]; then
	n=500000
fi

echo "Select $n records ..."
# ./jcallinfo -o yes -z 0 -n $n -r S -o yes > select.txt

./jcallinfo -o yes -k 1 -z 0 -n $n -r S -o yes > select.txt

date
$HOME/software/cassandra/bin/cqlsh -k mykeyspace -f select.txt > select.out
echo "Select $n records done"
date
