#!/bin/bash

####################################################################################
##
##  Check if every config in server.conf is same on all hosts
##
##  ./check_config_on_all_hosts.sh [KEY]
##
##  If KEY is provoded, checks KEY only. Otherwise, checks all keys
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

####### main ####
NUM=$1
if [[ "x$NUM" = "x" ]]; then
	NUM=10
fi

for h in $allhosts; do
	echo "Host $h ..."
	ssh $h "tail -$NUM $JAGUAR_HOME/log/jaguar.log"
done

exit 0
