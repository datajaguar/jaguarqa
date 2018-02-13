#hs=`./gethosts.sh`

# Added comments on ssd

hs=$JAGUAR_HOME/conf/cluster.conf

cat $hs  |
#while read line
for hostname in $(cat $hs); do

  #  echo "$hostname "/bin/rm -rf $JAGUAR_HOME/data/*" > log
    echo "cleaning `$hotname` now..."
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/data/*" 
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/ndata"
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/pdata"
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/log/delta"
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/log/cmd"
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/log/core*"
    ssh $hostname "/bin/rm -rf $JAGUAR_HOME/log/jaguar.*"
    ssh $hostname "ls -l $JAGUAR_HOME/log"
done

echo "donw with cleaning"


