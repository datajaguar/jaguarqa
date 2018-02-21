#!/bin/bash

n=$1

if [[ "x$n" = "x" ]]; then
	n=10000000
fi

echo "Insert $n records ..."

# Use jcallinfo, a cassandra command,

./jcallinfo -o yes -z 0 -n $n -r I -o yes > insert.txt

date
$HOME/software/cassandra/bin/cqlsh -k mykeyspace -f insert.txt
echo "Insert $n records done"

date
