
# Script Name: select_count_forever_jaguar_callinfo.sh 

i=0
while :
    do
        i=$((i+1))
        echo -e "=== Runing query in a infinitive loop. Kill this process by \"Ctrl + z\" ====\n"
        echo "It's `date`"
        echo "It's ${i}th Time now...update every 5 sec."
        #cqlsh --request-timeout=3600 -e "select count(*) from mykeyspace.callinfo;"
        #cqlsh  -e "select count(*) from mykeyspace.callinfo;"
        $HOME/jaguar/bin/jag -u admin -p jaguar -h localhost:9999 -e "select count(*) from test.callinfo;" 
        $HOME/jaguar/bin/jag -u admin -p jaguar -h localhost:9999 -e "select count(*) from test.jbench;"
        $HOME/jaguar/bin/jag -u admin -p jaguar -h localhost:9999 -e "select count(*) from test.jidx;"
        echo ""
        date 
        sleep 5
        #clear
done
