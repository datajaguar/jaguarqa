# SQL Name: data_load.sql

spool test_spool_out.sql.out;
select * from data_load  where v3 = "Apple31234567890";
select * from data_load  where v3 = 'Apple31234567890';

select * from data_load limit 2;

show create table data_load;

spool off;

quit;


