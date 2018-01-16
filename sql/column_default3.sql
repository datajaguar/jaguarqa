# Test new schema
# Script Name: column_default3.sql
# command line: loginj < column_default3.sql 
# Bug fix for 2.8.4.1

drop table if exists column_default3;

spool $QA_HOME/work/column_default3.out;

create table column_default3
(
    Key:    k1 int,
    Value:  k2 char(16),
            k3 datetime default current_timestamp,
            k4 timestamp default current_timestamp,
            k5 char(16)
);
    
desc column_default3;

spool off;
quit;
