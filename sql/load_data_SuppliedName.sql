# Script Name: load_data_Supplier.sql 

delete from SuppliedName;

spool  $QA_HOME/work/load_data_SuppliedName.out;

#load $QA_HOME/data/Supplier.txt into SuppliedName;

load /home/andrew/jaguar/bin/test.test.suppliedname.csv into SuppliedName;

sleep 5;

select count(*) from SuppliedName;
select * from SuppliedName;

spool off;
quit;
