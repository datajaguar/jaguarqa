num=1000
source=simple_task
for i in $(seq "$num")
do
    cp $source $source${i}.sql
done


