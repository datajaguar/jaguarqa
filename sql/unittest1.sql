# Script Name: unittest1.sql   

drop table if exists unittest1;

spool  $QA_HOME/work/unittest1.out;


create table if not exists unittest1 ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
create table if not exists unittest_old ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
create table if not exists unittest_old_2 ( key: uid char(32), ssn char(16), value: v1 char(16), v2 char(16)), v3 char(16) );

insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk1', vvvv1, vvvvvv2, vvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk2', vvbvv1, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk3', some, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk4', some, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1  values ( 'kkk5', somev, vkkv6v, vbvnv8vv );

sleep 3;

select count(*) from unittest1;

sleep 3;

update unittest1 set v1='newv1' where uid='kkk1';
select * from unittest1 where uid='kkk1';
delete from unittest1 where uid='kkk1';
select * from unittest1 where uid='kkk1';

sleep 3;
select count(*) from unittest1;

load $QA_HOME/data/100H.txt into unittest1 ;
sleep 3;

select count(*) from unittest1;
sleep 2;

create index unittest1_idx1 on unittest1( v2 );
create index unittest1_idx2 on unittest1( v3 );
select * from unittest1 where v2='vkkvvvvv2';
select * from unittest1_idx1 limit 10;
select * from unittest1_idx1 limit 10,3;
select * from unittest1_idx1 where v2='vkkvvvvv2';
select * from unittest1 use index( unittest1_idx1 ) where unittest1.v2='vkkvvvvv2';

select * from unittest1_idx1 limit 5;

desc unittest1;
desc unittest1_idx1;
show indexes from unittest1;

spool off;

quit;


select uid, v3 from unittest1 where uid='ddd' and v2='fdfdfdf';
select uid, v3 from unittest1 where uid='kkk2' and v2='vkkvvvvv2';
select uid, v3 from unittest1 where uid between 'sss' and 'zzz';
select uid, v3 from unittest1 where uid between 'sss' and 'zzz' and v1='fff';
update unittest1 set v3='new value' where uid='Cpple01234567890Apple01234567890';
update unittest1 set v2='new value', v1='fffff' where uid='Cpple01234567890Apple01234567890';
select * from unittest1 where uid='Cpple01234567890Apple01234567890';

#delete from unittest1 where uid='kkk3';
#delete from unittest1 where v1='some';
#rename table unittest_old to unittest_new;

spool off;

quit;


desc unittest_old_2;
alter table unittest_old_2 rename ssn to socseckey;
desc unittest_old_2;
insert into unittest_old_2 ( uid, socseckey, v1, v2, v3 ) values ( 'kkk1', 123345, vvvv1, vvvvvv2, vvvvv3 );
sleep 3;
desc unittest_old_2;
select * from unittest_old_2;
truncate table unittest_old_2;

delete from unittest_old_2;
select * from unittest_old_2 limit 3;

drop table if exists unittest_old_2;
drop table if exists unittest_new;

#spool off;

#quit;



