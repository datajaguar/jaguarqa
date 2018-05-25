
# Test Name:  create_db1_egift 
# Test select:
# Sample: "select * from jaguarFunc2;"


# Note:
# Need two system environments:
# JAGUAR_HOME and QA_HOME  

# env settings
FILE=create_db1_egift
PORT=`cat $HOME/jaguar/conf/server.conf |grep PORT|grep -v oport|grep -v '#'|cut -d= -f2`
HOST=127.0.0.1
USER=admin
PASSWORD=jaguarjaguarjaguar

# $JAGUAR_TEST_HOME/sh/select1.sh

function compare_result 
{
    diff $1 $2 
    # 2>&1 | tee -a  $JAGUAR_TEST_HOME/work/diff
    if [ $? -eq 0 ]
    then
         echo ""
         echo Success comparing $1
         touch $QA_HOME/work/${FILE}.suc
    else
         echo ""
         echo Failure comparing $1
         diff $1 $2 > $QA_HOME/work/${FILE}.diff
    fi
}

logf="$QA_HOME/work/${FILE}.log"

#clean old log
if [ -f $logf ]
    then rm $logf
fi

$JAGUAR_HOME/bin/jag  -u $USER -p $PASSWORD  -h $HOST:$PORT -v yes < $QA_HOME/sql/create_db1_egift.sql 2>&1 | tee -a $logf


compare_result  $QA_HOME/work/${FILE}.out  $QA_HOME/bas/${FILE}.bas 2>&1 | tee -a $logf

