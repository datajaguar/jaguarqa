#!/bin/bash

####################################################################################
##
##  Disable datacenter replicate
##
##  ./disable_datacenter_on_all_hosts.sh
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

conf="$JAGUAR_HOME/conf/datacenter.conf"
disable="$JAGUAR_HOME/conf/datacenter.conf.disable"
for h in $allhosts; do
	echo "$h: /bin/mv -f $conf $disable"
	ssh $h "if [ -f $conf ]; then /bin/mv -f $conf $disable; else echo Error: datacenter not setup; fi "
done

exit 0
