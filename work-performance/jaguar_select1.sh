

# Check starting time
######################
t1=`date +%s`
echo "Starting time is t1: $t1\n"


######################
# Test login here:
######################
# Notice:
# 1) Assume database.table "db_mongo_jaguar.tab_400million" is already created
# 2) Data is loaded

PORT=`grep PORT $JAGUAR_HOME/conf/server.conf |grep -v '#' | awk -F= '{print $2}'`
HOST=localhost

# $JAGUAR_HOME/bin/jag -u admin -p jaguar -h $HOST:$PORT -e "create index jidx on jbench(addr)"

# This is very fast as the uid is the key
# $JAGUAR_HOME/bin/jag -u admin -p jaguar -h $HOST:$PORT -e "select * from db_mongo_jaguar.tab_400million where uid='jAyB4DekgDF2ObQ6';"

# This might take more time:
$JAGUAR_HOME/bin/jag -u admin -p jaguar -h $HOST:$PORT -e "select * from db_mongo_jaguar.tab_400million where v3='kaYfxjbH6xg2BCFm';"


#  Check final time
######################


t2=`date +%s`
let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds
