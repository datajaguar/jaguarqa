#!/bin/bash

# Updated: 4/17/2018

export JAGUAR_HOME=$HOME
if [[ -f $HOME/.jaguarhome ]]; then
	export JAGUAR_HOME=`cat $HOME/.jaguarhome`
fi

export PORT=`grep PORT $JAGUAR_HOME/conf/server.conf |grep -v '#' | awk -F= '{print $2}'`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAGUAR_HOME/lib

export PATH=$PATH:$JAGUAR_HOME/bin:.
export SERVER=`hostname -I|cut -d' ' -f1`
un=`uname -o`
if [[ "x$un" = "xMsys" ]]; then
	export SERVER=127.0.0.1
fi
