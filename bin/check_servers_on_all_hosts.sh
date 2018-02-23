#!/bin/bash

####################################################################################
##
##  Check if cluster.conf contains same servers on all hosts
##
##  ./check_servers_on_all_hosts.sh
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
	allhosts=$1

	oldval=""
	oldh=""
	((good=1))
	((bad=0))
	((hnum=0))
	for h in $allhosts
	do
		((hnum=hnum+1))
		val=`ssh $h cat $JAGUAR_HOME/conf/cluster.conf`
		if [[ "x$oldval" != "x" ]]; then
			if [[ "$val" != "$oldval" ]]; then
				echo "cluster.conf on $h is different from the one on $oldh"
				echo "Please verify it"
				((bad=bad+1))
			else
				echo "Check cluster.conf on $h ...  OK"
				((good=good+1))
			fi
		fi
		oldval=$val
		oldh=$h
	done
	echo "$hnum hosts, $good OK, $bad Error"
}


####### main ####
allhosts=`cat $JAGUAR_HOME/conf/cluster.conf`
checkit "$allhosts"

exit 0
