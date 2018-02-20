#!/bin/bash

##############################################################################################################
##
##  Start Jaguar Server On All Hosts
##
##  ./jaguarstart_on_all_hosts.sh
##
##############################################################################################################

if [[ ! -f "$HOME/.jaguarhome" ]]; then
	echo "Jaguar has not been installed, quit"
	exit 1
fi

JAGUAR_HOME=`cat $HOME/.jaguarhome`
hostfile="$JAGUAR_HOME/conf/cluster.conf"
allhosts=`cat $hostfile`

if [[ -f "$hostfile" ]]; then
    ## echo "OK, $hostfile is found"
	/bin/true
else
    echo "$hostfile is not found, exit"
    exit 1
fi

for h in $allhosts
do
    echo "ssh $h $JAGUAR_HOME/bin/jaguarstart"
    ssh $h "$JAGUAR_HOME/bin/jaguarstart" &
done

echo "Jaguar database server is being started on all hosts ..."

