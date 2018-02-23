#!/bin/bash

####################################################################################
##
##  Enable datacenter replicate
##
##  ./enable_datacenter_on_all_hosts.sh
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
	echo "$h: /bin/mv -f $disable $conf"
	ssh $h "if [ -f $disable ]; then /bin/mv -f $disable $conf; elif [ ! -f $conf ]; then echo Error: datacenter not setup; fi "
	#  if [ -f /tmp/fff ]; then echo yes; else echo ggg; fi
done

date
echo "Done"

exit 0
