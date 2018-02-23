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

function checkit()
{
	key=$1
	allhosts=$2

	oldval=""
	oldh=""
	((good=1))
	((bad=0))
	((hnum=0))
	((findv=0))
	for h in $allhosts
	do
		((hnum=hnum+1))
		val=`ssh $h grep $key $JAGUAR_HOME/conf/server.conf|grep -v '#'|cut -d'=' -f2|tr -d ' '`
		if [[ "x$oldval" != "x" ]]; then
			if [[ "$val" != "$oldval" ]]; then
				echo "$key on $h is different from the one on $oldh"
				echo "Please verify it"
				((bad=bad+1))
			else
				echo "Check $key on $h ...  OK"
				((good=good+1))
			fi
			((findv=findv+1))
		fi
		oldval=$val
		oldh=$h
	done
	echo "$key check is done on all hosts"
	if ((findv>0)); then
		echo "$hnum hosts, $good OK, $bad Error"
	fi
}


####### main ####
KEY=$1
if [[ "x$KEY" = "x" ]]; then
	keys=`grep '=' $JAGUAR_HOME/conf/server.conf| grep -v '#'|cut -d'=' -f1|tr -d ' '`
else
	keys=$KEY
fi

for k in $keys; do
	checkit $k "$allhosts"
done

exit 0
