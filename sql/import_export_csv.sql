# SQL Name: import_export_csv.sql

drop table import_export;
spool  $QA_HOME/work/import_export_csv.out; 

create table import_export ( key: uid char(32), value: v1 char(16), v2 char(16), v3 char(16) );

load $QA_HOME/data/10kLine.txt into import_export;

spool off;
quit;


