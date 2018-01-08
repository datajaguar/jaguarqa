# Script Name: genrand_xaa700m_row.sql

# Automation1 for jaguar performance test (load 100 million rows) 
# Create on: 12/13/2017
# Created by: Andrew Zhang
# Purpose: performance test.
#
# Command Line:
#  jag -u user_myArrayDB1 -p password -d myArrayDB1 -h 127.0.0.1:8888 -v yes < mycommands.sql > testBatchSQL.log
# Updated on: 08/s4/2015

spool genrand_xaa700m_row.sql.out;
# createdb db_mongo-jaguar;

createdb db_mongo_jaguar;
use db_mongo_jaguar;

drop table if exists  tab_700million;

create table tab_700million(key:uid char(16),value:v1 char(16),v2 char(16),v3 char(16));

load  /home/andrew/QA_HOME/test_100milion/xaa700m_row.csv into db_mongo_jaguar.tab_700million;
# select count(*) from db_mongo_jaguar.tab_700million;

spool off;

quit;

