#!/bin/bash

# Script Name: test_kill_mixdel2_start_3.sh
# Tasks:
# 1. kill hp1, hp2 and dell2 after starting inserting 4,000,000 rows;
# 2. delete all data of hp1 and dell2;
# 3. Start server  hp1 and dell2 only(keep hp2 down):
# 4. Check the count(*), run grep_all and check_all
# 5. Re-start hp2 after reached 4 million lines.

function countit
{
    $HOME/jaguar/bin/jql -u admin -p jaguar -h 192.168.7.151:8888 -e "select count(*) from jbench"
    $HOME/jaguar/bin/jql -u admin -p jaguar -h 192.168.7.151:8888 -e "select count(*) from jidx"
}

date

countit
echo "kill jaguars ..."
### stop servers
for h in hp1 hp2 dell2
do
    echo "kill jaguar on $h ..."
    ssh $h "/home/$USER/jaguar/bin/jaguarstop -f"
    sleep 30
done

countit
sleep 30

# delete data  on the servers
echo "delete data/log ..."
countit
for h in hp1  dell2
do
    echo "Delete data/log on $h ..."
    ssh $h "/bin/rm -rf /home/$USER/jaguar/data/*"
    ssh $h "/bin/rm -rf /home/$USER/jaguar/ndata"
    ssh $h "/bin/rm -rf /home/$USER/jaguar/pdata"
    ssh $h "/bin/rm -rf /home/$USER/jaguar/log"
done

echo "sleep 30 ..."
sleep 30

echo "start servers ..."
countit
## start servers 
#for h in hp1 hp2 dell2 
for h in hp1 dell2 
do
    echo "$h jaguar ..."
    ssh $h "/home/$USER/jaguar/bin/jaguarstart"
    sleep 1
done

echo "Done"
countit
date
