# Script Name: Bug033.sql 
# Date: 12/01/2017
# Features:
# 1. Automate bug fix for Bug033_20171130
# 2. Need to restart to verify the select syntax.
# Updated: 12/28/2017

spool Bug033.out;

createdb new_database2;
use new_database2;

create table new_database2.table2
(
     key:
        uid2 char(16),
     value:
        adddr2 char(32),
);

desc new_database2.table2;

# Test 1: Insert two rows data at table2:
#########################################
insert into new_database2.table2 (uid2, adddr2) values("John Smith", "CA, USA");
insert into new_database2.table2 (uid2, adddr2) values("Mike Lee", "WA, USA");

select * from new_database2.table2;
select * from new_database2.table2 where uid2="Mike Lee";

sleep 4;

spool off;
quit;
