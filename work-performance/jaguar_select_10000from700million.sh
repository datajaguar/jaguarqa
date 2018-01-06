# Script Name: jaguar_select_10000_700million.sh
# Purppse: Test select performance for jaguar: select 10,000 rows from a 700 million row table

t1=`date +%s`
echo "Now is t1: $t1"

loginj < jaguar_select_10000_700million.sql

t2=`date +%s`
let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds

