
# Script Name: select_count_forever.sh

i=0
while :
    do
        i=$((i+1))
        echo -e "=== Runing query in a infinitive loop. Kill this process by \"Ctrl + z\" ====\n"
        echo "It's `date`"
        echo "It's ${i}th Time now...update every 1 sec."
        cqlsh --request-timeout=3600 -e "select count(*) from mykeyspace.callinfo;"
        #cqlsh  -e "select count(*) from mykeyspace.callinfo;"
        echo ""
        data 
        #sleep 5
        #clear
done
