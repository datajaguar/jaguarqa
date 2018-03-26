
# Scrip Name: concurrent_login.sh
# Purpose: Test concurrent login

num=1000
echo "Starting performance test by login $num concorrently: "
#sleep 3

source=simple_task
for i in $(seq "$num")
do  
    echo " loginj < $QA_HOME/work-performance/concurrent_login/sql/$source${i}.sql"
    loginj < $QA_HOME/work-performance/concurrent_login/sql/$source${i}.sql &
done

# Check :
# 1) by "ps -ef|gre jag | $LOGNAME |wc"
# 2) From jaguar.log, grep "connection"
# 3) From jaguare cliet, "show login" - enhencement.

