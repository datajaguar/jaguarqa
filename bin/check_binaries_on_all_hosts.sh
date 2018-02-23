#!/bin/bash

####################################################################################
##
##  Check if Jaguar server and jql  binaries are same on all hosts
##
##  ./check_binaries_on_all_hosts.sh
##
#####################################################################################

if [[ ! -f "$HOME/.jaguarhome" ]]; then
	echo "Jaguar has not been installed, quit"
	exit 1
fi

JAGUAR_HOME=`cat $HOME/.jaguarhome`
hostfile="$JAGUAR_HOME/conf/cluster.conf"
allhosts=`cat $hostfile|grep -v '#'`

if [[ ! -f "$hostfile" ]]; then
    echo "$hostfile is not found, exit"
    exit 1
fi

function checkit()
{
	prog=$1
	allhosts=$2

	oldmd5="0"
	oldh=""
	for h in $allhosts; do
    	md5=`ssh $h md5sum  $JAGUAR_HOME/bin/$prog` 
		if [[ "x$oldmd5" != "x0" ]]; then
			if [[ "$md5" != "$oldmd5" ]]; then
				echo "$prog on $h is different from the one on $oldh"
				echo "Please fix it"
				exit 1
			fi
		fi
		echo "Check $prog on $h ...  OK"
		oldmd5=$md5
		oldh=$h
	done
}


uo=`uname -o`
if [[ "x$uo" = "xGNU/Linux" ]]; then
	checkit jaguar.bin "$allhosts"
	checkit jql.bin "$allhosts"
else
	checkit jaguar.exe "$allhosts"
	checkit jql.exe "$allhosts"
fi

exit 0
