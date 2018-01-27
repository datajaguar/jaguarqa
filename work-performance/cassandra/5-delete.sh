#!/bin/bash

n=$1

if [[ "x$n" = "x" ]]; then
	n=10000
fi

date
echo "Delete $n records ..."
./jcallinfo -o yes -z 0 -n $n -r D -o yes > delete.txt

$HOME/software/cassandra/bin/cqlsh -k mykeyspace -f delete.txt > delete.out
echo "Delete $n records done"

date
