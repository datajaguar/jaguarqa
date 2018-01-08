# script Name: load_xaa700m_row.sh
# command line: "nohup load_xaa700m_row.sh > load_xaa700m_row.sh.out &"

# load 4 million rows into itable: 


t1=`date +%s`
echo "Starting time is t1: $t1"

jag -u admin -p jaguar -h :1117 <  genrand_xaa700m_row.sql  

t2=`date +%s`
let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds




