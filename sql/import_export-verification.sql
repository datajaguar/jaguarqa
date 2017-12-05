# SQL Name: import_export-verification.sql

spool  $QA_HOME/work/import_export-verification_sql.out; 

select count(*) from import_export;
select * from import_export  where v3 = "Apple31234567890";
select * from import_export  where v3 = 'Apple31234567890';

spool off;
quit;


