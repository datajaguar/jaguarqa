# Script Name: load_data_Supplier.sql 
delete from Supplier;
spool  $QA_HOME/work/load_data_Supplier.out;
load $QA_HOME/data/Supplier.txt into Supplier;
sleep 5;
select count(*) from Supplier;
select * from Supplier;
spool off;
quit;
