# Script Name: multi_bytes_char_settings2.sql 
drop table if exists jbench;

spool  $QA_HOME/work/multi_bytes_char_settings2.out;

createdb db_jbench;

create table if not exists jbench (key: uid char(16), value: addr char(32) );
truncate table jbench;

insert into jbench values ( '李世民', '胜利街12号，北京' );
insert into jbench values ( '张明', '枫涟路123号，上海');
sleep 2;

select * from jbench where uid='李世民';
sleep 2;
select * from jbench ;
sleep 2;

load $QA_HOME/data/jbench_cn.txt  into jbench;
sleep 3;

select count(*) from jbench;
sleep 2;

select  substr(addr, 0, 3, UTF8 ) from jbench where uid='李世民';
select * from jbench where uid='李世民';
select length(uid), length(addr) from jbench limit 4;

sleep 2;

spool off;

quit;

