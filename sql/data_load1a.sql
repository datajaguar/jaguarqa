# SQL Name: data_load1.sql

#Commented the following due to Bug034
#dropdb jag_data_load;

drop table if exists data_load;

spool  $QA_HOME/work/data_load1.out; 

createdb jag_data_load;
use jag_data_load;

create table data_load  ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );

desc data_load;  

load $QA_HOME/data/10kLine.txt into data_load;

sleep 5;

select count(*) from  data_load;
select * from data_load  where v3 = "Apple31234567890";
select * from jag_data_load.data_load  where v3 = 'Apple31234567890';

show create table data_load;

use test;
sleep 2;

spool off;

quit;


