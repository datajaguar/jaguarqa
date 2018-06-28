#!/bin/bash

###################################################################################
##
##  Check the three main config files from all the servers across the data centers:
##  cluster.conf, datacenter.conf, and server.conf
##
##  ./check_conf_all_DC.sh 
##
##
## A sample output looks like the following 
## (and with information for one data center with one GATE and one server)
##
## Current Data Center Configurations: 
## =================================== 
## DC1: ssd(GATE) hp1 hp2 

## DC2: dell1(GATE) dell1 dell2 

## DC3: hd7(GATE) hd7 hd8 
## ===================================

## ssh [ssd]
## -----------
## 1-cluster.conf:
## ssd
## 2-datacenter.conf:
## dell1:1117:GATE
## hd6:1117:GATE
## ssd:1117:GATE
## hp1:1117:HOST|hp2:1117:HOST
## 3-server.conf:
## IS_GATE=yes
## REPLICATION=2
## SERVER_TOKEN=lNIhMFGpzqbjkMQIFnN1HXmn0vTJJdK9
## =============================================

## ssh [hp1]
## -----------
## 1-cluster.conf:
## hp1
## hp2
## 2-datacenter.conf:
## ssd:1117:GATE
## 3-server.conf:
## REPLICATION=2
## SERVER_TOKEN=lNIhMFGpzqbjkMQIFnN1HXmn0vTJJdK9
## =============================================

###################################################################################

echo -e "\nCurrent Data Center Configurations:"
echo -e "==================================="
echo -e "DC1: ssd(GATE) hp1 hp2
       \nDC2: dell1(GATE) dell1 dell2
       \nDC3: hd7(GATE) hd7 hd8 \n"
echo -e "===================================\n"

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

