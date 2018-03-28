
# Script Name: performance_test.sh

t1=`date +%s`
echo "Now is t1: $t1"

 mongo <  mongo_xaa100m_row.range_query.sql

# mongo --host  localhost < mongo_xaa100m_row.range_query.sql 

t2=`date +%s`
let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds


