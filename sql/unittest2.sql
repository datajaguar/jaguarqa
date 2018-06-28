# Script Name: unittest2.sql   
# Features: 
# 1. function: avg, abs, log, radians, ltrim, substr, etc ; 

drop table if exists int10k;

spool  $QA_HOME/work/unittest2.out;

create table if not exists int10k ( key: k1 int, k2 float(16.3), value: addr char(32) );
insert into test.int10k values (1, 1, "Andrew");
insert into test.int10k values (2, 1, "Zola");
insert into test.int10k values (3, 1, "Mike");
select count(*) from test.int10k;
select * from test.int10k;


# load $QA_HOME/data/int10k.txt into int10k;
sleep 3;

select avg(k1+k2) from int10k;
select sum(k1) from int10k;

select k1+k2 from int10k order by k1+k2 limit 2;
select k1+k2, sin(k1-k2*2/3.0), cos(k1*k2/(k1-k2)) from int10k order by k1+k2 DESC limit 2;
select avg(k1+k2), sum(k1), stddev(k2) from int10k order by sum(k1) limit 2;

sleep 4;

spool off;

quit;

 
