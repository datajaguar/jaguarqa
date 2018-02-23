#!/bin/bash

####################################################################################
##
##  Delete a line containing KEY in server.conf  on al hosts
##
##  ./delete_config_on_all_hosts.sh KEY
##
#####################################################################################

if [[ ! -f "$HOME/.jaguarhome" ]]; then
	echo "Jaguar has not been installed, quit"
	exit 1
fi

KEY=$1
if [[ "x$KEY" = "x" ]]; then
	echo "Usage: $0  <KEY>"
	echo "KEY is a string in server.conf file"
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
    echo "ssh $h "
    ssh $h "sed -i '/$KEY.*=/d' $JAGUAR_HOME/conf/server.conf"  
done

echo "Line containing $KEY in server.conf is deleted on all hosts"
exit 0
