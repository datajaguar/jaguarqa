# Test new schema
# Script Name: column_default.sql
# command line: loginj < time_stamp.sql 


spool $QA_HOME/work/time_stamp.out;

drop table if exists time_stamp; 

create table time_stamp 
(
    key:    column_name varchar(32),
    value:  time_column TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

# desc time_stamp ;

insert into time_stamp (column_name) values ("demo");

sleep 3;

select column_name as name, time_column as ts from  test.time_stamp;

select * from test.time_stamp;

spool off;
quit;

