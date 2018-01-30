#hs=`./gethosts.sh`

# Added comments on ssd

FILE=clean_all_windows
logf="$QA_HOME/work/${FILE}.log"



# Clean old log:
if [ -f $logf ]; then
    rm $logf
fi

echo -e "# $FILE.log \n" 2>&1 | tee -a $logf

hs=$JAGUAR_HOME/conf/cluster.conf

cat $hs  |
#while read line
for hostname in $(cat $hs); do

    echo "cleaning `$hotname` now..."
    /bin/rm -rf $JAGUAR_HOME/data/* 
    /bin/rm -rf $JAGUAR_HOME/ndata
    /bin/rm -rf $JAGUAR_HOME/pdata
    /bin/rm -rf $JAGUAR_HOME/log/delta
    /bin/rm -rf $JAGUAR_HOME/log/cmd
    /bin/rm -rf $JAGUAR_HOME/log/core*

done

echo "Done with cleaning data and logs"  2>&1 | tee -a $logf



