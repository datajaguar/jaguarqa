#!/bin/bash

##############################################################################################################
##
##  Stop Jaguar Server On All Hosts
##
##  ./jaguarstop_on_all_hosts.sh
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

arr=($allhosts)
numhosts=${#arr[@]}
#echo "there are $numhosts hosts hosts=[$allhosts]"
for h in $allhosts
do
    echo "ssh $h $JAGUAR_HOME/bin/jaguarstop"
    ssh $h "$JAGUAR_HOME/bin/jaguarstop" &
done


### wait until all jaguars have been stopped
((cnt=1))
while true
do
	$JAGUAR_HOME/bin/jaguarstatus_on_all_hosts.sh
	notrunning=$?
	((running=numhosts-notrunning))
	if (( running > 0 ))
	then
		date
	    echo "There are still $running jaguar servers running, wait ..."
	    sleep 5
		if (( cnt == 10 )); then
			for h in $allhosts; do
    		    ssh $h "$JAGUAR_HOME/bin/jaguarstop" &
			done
			((cnt=1))
		fi
		((cnt=cnt+1))
	else
		break
	fi
	
done

echo "Jaguar database has been stopped on all $numhosts hosts"

