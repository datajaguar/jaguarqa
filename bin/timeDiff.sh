# A utility to check time passed in sec.

t1=`date +%s`
echo "Now is t1: $t1"
echo "Sleep 10 sec"

#sleep 82

# Test for 71 sec

num=71
for i in i$(seq "$num")
do
    echo "Time passed in sec: $i"
    sleep 1
done



t2=`date +%s`
echo "Now is t2: $t2"

echo "Time passed is: t2 - t2:" 

expr $t2 - $t1


