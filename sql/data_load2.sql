# SQL Name: data_load2.sql
# 

spool  $QA_HOME/work/data_load2.out; 

select * from jag_data_load.data_load  where v3 = 'Apple31234567890';
select count(*) from  data_load;

use jag_data_load;

select * from data_load  where v3 = "Apple31234567890";
select * from jag_data_load.data_load  where v3 = 'Apple31234567890';

spool off;
quit;


