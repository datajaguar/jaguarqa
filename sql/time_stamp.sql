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

insert into time_stamp (column_name) values ("demo1");
insert into time_stamp (column_name) values ("demo2");
insert into time_stamp (column_name) values ("demo3");
insert into time_stamp (column_name) values ("demo4");
insert into time_stamp (column_name) values ("demo5");
sleep 3;

select column_name as name, time_column as ts from  test.time_stamp order by ts;
sleep 3;
select * from test.time_stamp order by time_column;
sleep 3;

spool off;
quit;

