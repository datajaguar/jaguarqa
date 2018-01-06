# For the new feature after 2.8.3.1
# data type: enum
spool enum.out;

drop table f exits t1 ;
create table t1 ( key: uid int, value: c2 enum('aa1', 'aa2' ), c3 char(32) default  'dddd' );

desc t1;

drop table f exits t2;

create table t2 ( key: uid int, value: c2 enum('aa1', 'aa2' ) default 'aa1', c3 char(32) default  'dddd' );

desc t2;

spool off;

quit;


