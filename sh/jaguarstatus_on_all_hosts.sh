#!/bin/bash

##############################################################################################################
##
##  Start Jaguar Server On All Hosts
##
##  ./jaguarstatus_on_all_hosts.sh
##
##  exit code 0: true if all servers running
##       code = N:  N servers not running
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

((rc=0))
((hnum=0))
((good=0))
((bad=0))
badhosts=""
for h in $allhosts
do
	((hnum=hnum+1))
    echo "ssh $h $JAGUAR_HOME/bin/jaguarstatus"
    ssh $h "$JAGUAR_HOME/bin/jaguarstatus" 
	### exit code 0 fo true, meaning running.  1 as false for not running
	ecode=$?
	((rc=rc+ecode))
	if ((ecode==0)); then
		((good=good+1))
	else
		((bad=bad+1))
		badhosts="$badhosts $h"
	fi
done

echo "jaguarstatus_on_all_hosts.sh  total hosts=$hnum  jaguar on=$good  jaguar off=$bad"
if ((bad>0)); then
	echo "Jaguar off hosts: $badhosts"
fi
exit $rc

