# Script Name: memtable.sql  
# 06/15/2018: Feature is not completed yet.

drop table if exists mem1;

spool  $QA_HOME/work/memtable.out;

create  memtable mem1 (key: uid char(32), value: v1 char(16) );
insert into mem1 values ( uuu1, vvvvv1 );
insert into mem1 values ( uuu2, vvvvv2 );
sleep 3;
create index mem1_idx1 on mem1 ( v1 );
sleep 2;
select * from mem1;
sleep 2;

spool off;

quit;

