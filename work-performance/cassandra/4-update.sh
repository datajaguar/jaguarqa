#!/bin/bash

n=$1

if [[ "x$n" = "x" ]]; then
	n=10000
fi

echo "Update $n records ..."
./jcallinfo -o yes -z 0 -n $n -r U -o yes > update.txt

date
$HOME/software/cassandra/bin/cqlsh -k mykeyspace -f update.txt > update.out
echo "Update $n records done"

date
