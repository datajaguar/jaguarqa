#!/bin/bash

####################################################################################
##
##  Change Jaguar Server Any Config Paramter On All Hosts
##
##  ./change_config_on_all_hosts.sh   KEY  VALUE
##
#####################################################################################

if [[ ! -f "$HOME/.jaguarhome" ]]; then
	echo "Jaguar has not been installed, quit"
	exit 1
fi

KEY=$1
VALUE=$2
if [[ "x$VALUE" = "x" ]]; then
	echo "Usage: $0  KEY  VALUE"
	exit 1
fi

JAGUAR_HOME=`cat $HOME/.jaguarhome`
hostfile="$JAGUAR_HOME/conf/cluster.conf"
allhosts=`cat $hostfile|grep -v '#'`

if [[ ! -f "$hostfile" ]]; then
    echo "$hostfile is not found, exit"
    exit 1
fi

for h in $allhosts
do
    echo "ssh $h "
    ssh $h "sed -i 's/.*$KEY*=.*/$KEY=$VALUE/g' $JAGUAR_HOME/conf/server.conf"
done

echo "Jaguar config $KEY is changed to $VALUE on all hosts"
exit 0

