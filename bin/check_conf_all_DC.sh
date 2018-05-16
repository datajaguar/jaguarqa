#!/bin/bash

###########################################################################
##
##  Check the two config files from all the servers on all DC(s):
##  cluster.conf and datacenter.conf
##
##  ./sshall "command"
##
##
############################################################################

echo -e "\nCurrent Data Center Configurations:"
echo -e "==================================="
echo -e "DC1: ssd(GATE) hp1 hp2
       \nDC2: dell1(GATE) dell1 dell2
       \nDC3: hd7(GATE) hd7 hd8 \n"

for h in ssd hp1 hp2 dell1 dell2 dell3 hd6 hd7 hd8; do
    echo "ssh [$h] "
    ssh $h "echo -----------; \
        echo 1-cluster.conf:; \
        cat $JAGUAR_HOME/conf/cluster.conf; \
        echo 2-datacenter.conf:; \
        cat $JAGUAR_HOME/conf/datacenter.conf; \
        echo 3-server.conf:; \
        grep IS_GATE $JAGUAR_HOME/conf/server.conf; \
        grep REPLICATION $JAGUAR_HOME/conf/server.conf; \
        grep SERVER_TOKEN $JAGUAR_HOME/conf/server.conf"
    echo -e "=============================================\n"
done

