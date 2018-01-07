# Script Name: performance_timer_main.sh 
# Purppse: Test performance timer for jaguar and other db: select, update, insert, delete etc.
# Command line:

# jaguar:
########### 
# Selete: nohup performance_timer_main.sh > jaguar_select_10000from700million_tail.sh.out &
# Update: nohup performance_timer_main.sh > jaguar_update_10000from700million_tail.sh.out &
# Delete: nohup performance_timer_main.sh > jaguar_delete_10000from700million_tail.sh.out &
# After delete, we might re-insert the 10000 line to re-start:
#    insert: nohup performance_timer_main.sh > jaguar_insert_10000from700million_tail.sh.out &


# Note:
# Performance test should be run one script at time!

t1=`date +%s`

echo -e "\n==> Starting time is t1: $t1, `date` \n"

#loginj < jaguar_update_10000_700million_tail.sql 

# ####################################
# Part one: Jagaur Performance Test
######################################
# 1-Select
# jaguar_select_10000from700million_tail.sh

# 2-Update
# jaguar_update_10000from700million_tail.sh

# 3-Delete
jaguar_delete_10000from700million_tail.sh

# 4-Insert
#jaguar_insert_10000from700million_tail.sh
wait

# ####################################
# Part Two: MongoDB Performace
######################################


# Calc the time required:
t2=`date +%s`
echo -e "\n\n ===> Ending time is t2: $t2, `date`"

let deltatime=t2-t1
let hours=deltatime/3600
let minutes=(deltatime/60)%60
let seconds=deltatime%60

echo -e "\nTotal time in second: $deltatime"
printf "Total time in hour:min:sec: %d:%02d:%02d \n" $hours $minutes $seconds


# We can test multiple time by replace some data by:
# sed s/pattern/replace_string/g file > file2 

