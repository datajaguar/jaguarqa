# A utility to check time passed in sec and hour:min:sec.

t1=`date +%s`
echo "Now is t1: $t1"

# Some tests here....

# A test:
num=2
for i in $(seq "$num")
do
    echo "Time passed in sec: $i"
    sleep 1
done

t2=`date +%s`
let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds



