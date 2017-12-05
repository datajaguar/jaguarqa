# SQL name: import_export-clean_data.sql 
# Purpose: Clean data in the table of import_export

spool  $QA_HOME/work/import_export-clean_data.out; 
delete from import_export;

spool off;
quit;

