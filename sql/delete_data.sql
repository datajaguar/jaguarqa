# SQL Name: delete_data.sql 

#Commented the following due to the bug B

dropdb jag_delete_data;

spool  $QA_HOME/work/delete_data.out; 

createdb jag_delete_data;
use jag_delete_data;

create table delete_data ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );

desc delete_data; 

load $QA_HOME/data/10kLine.txt into delete_data;

sleep 5;

select count(*) from  data_load;
sleep 2;

select * from delete_data where v3 = "Apple31234567890";

select count(*) from  data_load;
sleep 1;

delete from delete_data where v3 = 'Apple31234567890';

select count(*) from delete_data;

delete from delete_data;
select count(*) from delete_data;

sleep 2;

spool off;

quit;


