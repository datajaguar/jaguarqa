#!/bin/bash

####################################################################################
##
##  Display config parameter and values in server.conf on all hosts
##
##  ./list_configs_on_all_hosts.sh
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

for h in $allhosts; do
    echo "ssh $h ----------------------------- "
    ssh $h "grep '=' $JAGUAR_HOME/conf/server.conf |grep -v grep|grep -v '#'"  
done

exit 0
