# Test new schema
# Script Name: column_default2.sql
# command line: loginj < column_default2.sql

# Currently this test will generate a coredump
# Bug026_20171112 (failed at inserting data) 


drop table if exists column_default2;

spool $QA_HOME/work/column_default2.out;

create table column_default2
(
    Key: 
        id uuid,
    Value:
        A int default '0',
        B char(16) default 'b',
        Bitv bit default b'1',
        Bitm bit default b'0',
        Tm1 timestamp DEFAULT CURRENT_TIMESTAMP,
        Tm2 timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        Tm3 timestamp ON UPDATE CURRENT_TIMESTAMP
);

desc test.column_default2;

insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('', '', '', '', '', '', '', '');
insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('', '', '', '', '', '', '', '');
insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('', '', '', '', '', '', '', '');
insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('', '', '', '', '', '', '', '');
insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('', '', '', '', '', '', '', '');

insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('1', '', '', '', '', '', '', '');
insert into test.column_default2 (id, a, b, bitv, bitm, tm1, tm2, tm3) values ('2', '1', '1', '1', '1', '1', '1', '1');

sleep 5;

select count(*) from test.column_default2;
select * from test.column_default2; 

spool off;
quit;

