# Script Name: performance_timer_main.sh 
# Purppse: Calculate the performance time for jaguar and other db: select, update, insert, delete etc.
# Note:
#     We may modify each test by commenting and uncommenting the test for each one


###################
# Command line:
###################

# jaguar:
########### 
# Selete: nohup performance_timer_main.sh > jaguar_select_10000from700million_tail.sh_2.out &
 #        nohup performance_timer_main.sh > jaguar_select_10000from700million_random.sh.out &

# Update: nohup performance_timer_main.sh > jaguar_update_10000from700million_tail.sh.out &
# Delete: nohup performance_timer_main.sh > jaguar_delete_10000from700million_tail.sh.out &

#  After delete, we might re-insert the 10000 line to re-start:
# insert: nohup performance_timer_main.sh > jaguar_insert_10000from700million_tail.sh.out &

# MonogoDB:
######################
# Select: nohup performance_timer_main.sh > mongoDB_select_10000_700million_tail.sql.out &
# Select from 10000 randon rows:
#       nohup performance_timer_main.sh > mongoDB_select_10000_700million_random.sql.out &  
# Update: nohup performance_timer_main.sh > mongoDB_update_10000_700million_tail.sql.out &
# Delete: nohup performance_timer_main.sh > mongoDB_delete_10000_700million_tail.sql.out &
# Inserr: nohup performance_timer_main.sh > mongoDB_insert_10000_700million_tail.sql.out &


# Note:
# Performance test should be run one script at time!

t1=`date +%s`

echo -e "\n==> Starting time is t1: $t1, `date` \n"

#loginj < jaguar_update_10000_700million_tail.sql 

# ####################################
# Part one: Jagaur Performance Test
######################################

# 1. Select

# 1-1) Select from tail
# jaguar_select_10000from700million_tail.sh
# Command Line:  nohup performance_timer_main.sh > jaguar_select_10000from700million_tail.sh_out_1 &

# 1-2) Select from random
# jaguar_select_10000from700million_random.sh
# Command Line:  nohup performance_timer_main.sh > jaguar_select_10000from700million_random.sh.out_1 &


# 2. Update
# 
# 2-1) Update from tail
# jaguar_update_10000from700million_tail.sh

# 2-2) Update from random
# jaguar_update_10000from700million_random.sh
#  Command Line:  nohup performance_timer_main.sh > jaguar_update_10000from700million_random.sh.out_1 &


# 3. Delete
# 3-1) Delete from tail
# jaguar_delete_10000from700million_tail.sh

# 3-2)  Delete from random
# jaguar_delete_10000from700million_random.sh
#  Command Line:  nohup performance_timer_main.sh > jaguar_delete_10000from700million_random.sh.out_1 &

# 4. Insert
# 4-1) Insert from tail
# jaguar_insert_10000from700million_tail.sh

# 4-2) Insert from random:
jaguar_insert_10000from700million_random.sh
#  Command Line:  nohup performance_timer_main.sh > jaguar_insert_10000from700million_random.sh.out_1 &
# sleep 4

# ####################################
# Part Two: MongoDB Performace
######################################
# A test
# mongo --host localhost < mondoDB_jagdb.xaa10000_row.select1.sql 

# 
# 1) Create Index on uid
# mongo --host localhost < mondoDB_jagdb.xaa700m_row.createIndexUID.sql

# 2) Select last 10000 rows from a 700 million row table
# mongo --host localhost < mongoDB_select_10000_700million_tail.sql
# Command Line: nohup performance_timer_main.sh  > mongoDB_select_10000_700million_tail.sql.out_Index_fist & 

# 2-1) Test selecting from the random 10000 rows:
# mongo --host localhost < mongoDB_select_10000_700million_random.sql
# Command Line: nohup performance_timer_main.sh  > mongoDB_select_10000_700million_random.sql.out_1 &

# 2-2) Test selecting from the head 10000 rows:
# mongo --host localhost < mongoDB_select_10000_700million_head.sql
# Command Line: nohup performance_timer_main.sh  > mongoDB_select_10000_700million_head.sql.out &


# 3) Update last 10000 10000 rows from a 700 million row table
#  mongo --host localhost < mongoDB_update_10000_700million_tail.sql
# mongo --host localhost < mongoDB_update_10000_700million_random.sql
# Command Line: nohup performance_timer_main.sh  > mongoDB_update_10000_700million_random.sql.out_1 &


# 4-1) Delete from tail
# mongo --host localhost < mongoDB_delete_10000_700million_tail.sql

# 4-2) Delete from random selections
# mongo --host localhost < mongoDB_delete_10000_700million_random.sql 
# Command Line:  nohup performance_timer_main.sh > mongoDB_delete_10000_700million_random.sql.out_1 &


# 5) Insert:
# 5-1) Insert from tail selections:
# mongo --host localhost < mongoDB_insert_10000_700million_tail.sql 

# 5-1) Insert from random select
# mongo --host localhost <  mongoDB_insert_10000_700million_random.sql
# Command Line:  nohup performance_timer_main.sh > mongoDB_insert_10000_700million_random.sql.out_1 &


# 6) Remove all document in a collection
# sample command: "db.xaa10000_row.remove({})"

# mongo --host localhost < mondoDB_remove_700million.sql
# Command line: nohup performance_timer_main.sh > mondoDB_remove_700million.sql.out &


# Run a python untility to sample 10000 from the 700,000,000 row table
#python  getRandom_10000.py 

wait

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

