#Script Name: load_data_Place.sql
delete from Place;

spool  $QA_HOME/work/load_data_Place.out;

load $QA_HOME/data/Place.txt into Place;
sleep 5;

select count(*) from Place;

select * from Place;

spool off;
quit;

