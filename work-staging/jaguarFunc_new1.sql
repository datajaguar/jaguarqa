# Automation1 for ArrayDB Acceptance Test 
# Create on: 06/11/2015
# Updated on: 08/28/2015
# Created by: Andrew Zhang
# Purpose: Minimum test cases covers all the basic SQL syntax for jaguar.
#
# Command Line:
#  jag -u user_myArrayDB1 -p password -d myArrayDB1 -h 127.0.0.1:8888 -v yes < mycommands.sql > testBatchSQL.log
# Updated on: 08/s4/2015



spool jaguarFunc_new1.out;

# Test 1-1. Create tables
#########################

show tables;
createdb jaguarFunc_new1;
show database;
use jaguarfunc_new1;
show tables;




drop table jaguarFunc1 ;
drop table jaguarFunc2 ;
drop table jaguarFunc3 ;
drop table jaguarFunc4:
drop table jaguarFunc5;

create table jaguarFunc1  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );
create table jaguarFunc2  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );
create table jaguarFunc3  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );
create table jaguarFunc4  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );
create table jaguarFunc5  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );

show tables;

# Test 1-2.  Delete table
###########################
desc jaguarFunc1;
show tables;
drop table jaguarFunc1;
show tables;

# Test 1-3. Check table schema
desc jaguarFunc1;

# Test 2-1: Load a 10k row text file in foramt H:
#################################################
load $HOME/jaguarTestData/10iine.txt into jaguarFunc2;

# Test 2-2: Basic query 
##########################
select * from jaguarFunc2 where uid = FQfbHNKNcgPORWNs;
select * from jaguarFunc2 where v2=c3BRPlD1BsNsnAT3;

# Test 3: Insert data and select
#################################
select count(*) from jaguarFunc2;
insert into jaguarFunc2 (uid, v1, v2, v3) values (4, 'xxx', 'yyyy', 'zzz');
select count(*) from jaguarFunc2;
## Expect 10006 rows found



update jaguarFunc2 set v2='v2 is From yyyy to y2y2y2' where uid=4;
select * from jaguarFunc2 where  uid=4;


show tables;

spool off;

quit;


