# Modify the unit test caes:
 
drop table if exists unittest_old_2;
drop table if exists sales;
drop table if exists service;
drop table if exists service2;
drop table if exists starhost;
drop table if exists star1;
drop table if exists star2;
drop table if exists star3;
drop table if exists callinfo;

# multi_bytes_char_settings2.sql:
##################################

create table if not exists jbench (key: uid char(16), value: addr char(32) );
truncate table jbench;
insert into jbench values ( '李世民', '胜利街12号，北京' );
insert into jbench values ( '张明', '枫涟路123号，上海');
sleep 3;
select * from jbench where uid='李世民';
load $HOME/jaguardb_qatest/jbench_cn.txt  into jbench;
sleep 3;
select  substr(addr, 0, 3, UTF8 ) from jbench where uid='李世民';
select * from jbench where uid='李世民';
select length(uid), length(addr) from jbench limit 4;

# memtable.sql:  a bug currently
# Need to create a seperated directory 
#######################################

create  memtable mem1 (key: uid char(32), value: v1 char(16) );
insert into mem1 values ( uuu1, vvvvv1 );
insert into mem1 values ( uuu2, vvvvv2 );
sleep 3;
create index mem1_idx1 on mem1 ( v1 );

# 
####################################

create table if not exists unittest1 ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
create table if not exists unittest_old ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
create table if not exists unittest_old_2 ( key: uid char(32), ssn char(16), value: v1 char(16), v2 char(16)), v3 char(16) );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk1', vvvv1, vvvvvv2, vvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk2', vvbvv1, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk3', some, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1 ( uid, v1, v2, v3 ) values ( 'kkk4', some, vkkvvvvv2, vbvnvvvv3 );
insert into unittest1  values ( 'kkk5', somev, vkkv6v, vbvnv8vv );
sleep 3;
update unittest1 set v1='newv1' where uid='kkk1';
select * from unittest1 where uid='kkk1';
delete from unittest1 where uid='kkk1';
select * from unittest1 where uid='kkk1';
load $HOME/jaguardb_qatest/100H.txt into unittest1 ;
sleep 3;
select count(*) from unittest1;
select * from unittest1 where uid='kkk2';
select * from unittest1 where v3='vvvvv3';

create index unittest1_idx1 on unittest1( v2 );
create index unittest1_idx2 on unittest1( v3 );
select * from unittest1 where v2='vkkvvvvv2';
select * from unittest1_idx1 limit 10;
select * from unittest1_idx1 limit 10,3;
select * from unittest1_idx1 where v2='vkkvvvvv2';
#select * from unittest1 use index( unittest1_idx1 ) where unittest1.v2='vkkvvvvv2';

select * from unittest1_idx1 limit 5;

desc unittest1;
desc unittest1_idx1;
show databases;
show tables;
show indexes from unittest1;


select uid, v3 from unittest1 where uid='ddd' and v2='fdfdfdf';
select uid, v3 from unittest1 where uid='kkk2' and v2='vkkvvvvv2';
select uid, v3 from unittest1 where uid between 'sss' and 'zzz';
select uid, v3 from unittest1 where uid between 'sss' and 'zzz' and v1='fff';
update unittest1 set v3='new value' where uid='Cpple01234567890Apple01234567890';
update unittest1 set v2='new value', v1='fffff' where uid='Cpple01234567890Apple01234567890';
select * from unittest1 where uid='Cpple01234567890Apple01234567890';
delete from unittest1 where uid='kkk3';
delete from unittest1 where v1='some';
rename table unittest_old to unittest_new;
## It should be invalid. If invalid, it is correct
show tables;
desc unittest_old_2;
alter table unittest_old_2 rename ssn to socseckey;
desc unittest_old_2;
insert into unittest_old_2 ( uid, socseckey, v1, v2, v3 ) values ( 'kkk1', 123345, vvvv1, vvvvvv2, vvvvv3 );
sleep 3;
desc unittest_old_2;
select * from unittest_old_2;
truncate table unittest_old_2;

show tables;
delete from unittest_old_2;
select * from unittest_old_2 limit 3;
drop table if exists unittest_old_2;
drop table if exists unittest_new;
show tables;

#
############################################

create table if not exists unittest2 ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
load $HOME/jaguardb_qatest/100H2.txt into unittest2 ;

create table if not exists unittest3 ( key: uid char(32), value: v1 char(16), v2 char(16)), v3 char(16) );
create index unittest3_idx on unittest3( v2, v1 );
load $HOME/jaguardb_qatest/100H3.txt into unittest3 ;
sleep 3;
select count(*) from unittest3;
select count(*) from unittest3_idx;

drop table if exists unittest1;
drop table if exists unittest2;
drop table if exists unittest3;

show tables;

drop table if exists int10k;
create table if not exists int10k ( key: k1 int, k2 float(16.3), value: addr char(32) );
load $HOME/jaguardb_qatest/int10k.txt into int10k;
sleep 3;
select k1+k2, sin(k1-k2*2/3.0), cos(k1*k2/(k1-k2)) from int10k limit 2;
select avg(k1+k2), sum(k1), stddev(k2) from int10k limit 2;
select first(k1+k2), last(k1) from int10k limit 2;
select abs(k1+k2), acos(k2), asin(k1), ceil(k1), cot(k2), floor(k2), log2(k2), log10(k1) from int10k limit 2;
select log(k1+k2), ln(k2), pow(k1, 2), mod(k1, 3), sqrt(k1), tan(k2) from int10k limit 2;
select radians(k1+k2), degrees(k2), radians(degrees(k1))  from int10k limit 2;
select ltrim(addr), rtrim(addr), trim(addr), upper(addr), lower(addr), substr(addr, 1, 3 ) from int10k limit 2;
select ltrim(addr), rtrim(addr), trim(addr), upper(addr), lower(addr), substr(addr, 1, 3, UTF8 ) from int10k limit 2;
select  substr(addr, 1, 3, UTF8 ) from int10k limit 2;
select  substr(addr, 1, 3, 'UTF8' ) from int10k limit 2;
select  substr(addr, 1, 3, 'UTF-8' ) from int10k limit 2;
select  substr(addr, 1, 3, 'GBK' ) from int10k limit 2;
select  substr(addr, 1, 3, 'GB18030' ) from int10k limit 2;
select  substr(addr, 1, 3, GB18030 ) from int10k limit 2;

drop table if exists int10k_2;
create table if not exists int10k_2 ( key: k1 int, k2 float(16.3), value: addr char(32) );
load $HOME/jaguardb_qatest/int10k_2.txt into int10k_2 ;
sleep 3;
select k1+k2, sin(k1-k2*2/3.0), cos(k1*k2/(k1-k2)) from int10k_2 limit 2;
select k1, sum(k2)  from int10k_2 group by k1 limit 4;
select k1, sum(k2)  from int10k_2 group by k1;
select k1, sum(k2), count(1)  from int10k_2 group by k1 limit 2,2;

create table if not exists sales ( key: uid int, daytime datetime, value: amt float(3.1), unit float(3.1), utype char(1) );
load $HOME/jaguardb_qatest/sales.txt into sales ;
insert into sales values (10, '2014-04-23 08:59:52.000000', 0.1, 0.1, 'C' );
insert into sales values (10, '2014-04-23 08:59:59.000000', 0.1, 0.1, 'C' );
insert into sales values (10, '2014-04-29 08:59:59.000000', 0.1, 0.1, 'C' );

create table if not exists service ( key: uid int, daytime datetime, value: phone char(10), reason char(16) );
load $HOME/jaguardb_qatest/service.txt into service ;
sleep 3;
select dayofmonth( daytime), dayofweek( daytime ), dayofyear(daytime) from service limit 1;
select curdate(), curtime(), now() from service limit 1;

create table if not exists callinfo ( key: lNumberKey  int, value:  tApplyTime date, tExpirtTime date, szCallNumber char(132),iHomeArea int, szStatus char(12), lMainAccountKey int, lAccT_balance_id int, lAcctid int, szSecond_ower_type  char(4), iBalance_Type_ID int, lAmount int, lInitialAmount int, lReserveAmount      int, lSettleAmount int, szOrigin_type char(4), lOriginID int, szInitialType char(4), lInitial_D int, content char(40), lReserve0 int, tReserve0 date, lReserve1 int, tReserve1 date, lReserve2 int, tReserve2 date, lReserve3 int, tReserve3 date, lReserve4 int, tReserve4 date );

create index idx_callinfo_szCallNumber on callinfo(szCallNumber);
load $HOME/jaguardb_qatest/callinfo.txt into callinfo quote terminated by '\'';
sleep 3;

select * from idx_callinfo_szCallNumber limit 3;

create table if not exists service2 ( key: uid uuid, value: phone char(10), reason char(16) );
insert into service2 ( reason, phone ) values ( 'sick', '4082230989' );
insert into service2 ( reason, phone ) values ( 'holiday', '4082230989' );
insert into service2  values ( '13482829', 'us-holiday' );

### star join
create table if not exists starhost ( key: k1 char(16), k2 char(16),k3 char(16), value: v1 char(16), v2 char(16), v3 char(16) );
load $HOME/jaguardb_qatest/starhost.txt into starhost ;
sleep 3;
select k1+k2, k1 from starhost limit 3;
select k1+k2, k1 from starhost where k1>='awweee' and k1<'p9292' and k2>='mm' and k2 <='q999' limit 5;

create table if not exists star1 ( key: v1 char(16), value: v2 char(16), v3 char(16) );
load $HOME/jaguardb_qatest/star1.txt into star1 ;

create table if not exists star2 ( key: v2 char(16), value: v3 char(16), v1 char(16) );
load $HOME/jaguardb_qatest/star2.txt into star2 ;

create table if not exists star3 ( key: v3 char(16), value: v1 char(16), v2 char(16) );
load $HOME/jaguardb_qatest/star3.txt into star3 ;
sleep 3;


show tables; 
desc callinfo; 
show databases;

select avg(lNumberKey) as avg_key from callinfo limit 3; 
select avg(lNumberKey) avg_key, min(tApplyTime) min_apptime, max(tApplyTime) as maxtime from callinfo limit 3; 
select daytime, datediff(day, daytime, '2014-09-30 23:00:00.0001' ) from sales limit 3;
select daytime, datediff(day, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, datediff(month, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, datediff(year, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, datediff(second, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, datediff(hour, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, datediff(minute, '2022-12-12', '2014-09-30 23:00:00' ) from sales limit 3;
select daytime, date(daytime) from sales limit 1;
select daytime, month(daytime) from sales limit 1;
select daytime, year(daytime) from sales limit 1;
select daytime, hour(daytime) from sales limit 1;
select daytime, minute(daytime) from sales limit 1;
select daytime, second(daytime) from sales limit 1;
select daytime, dayofmonth(daytime) from sales limit 1;
select daytime, dayofweek(daytime) from sales limit 1;
select daytime, dayofyear(daytime) from sales limit 1;
select daytime, curdate(), curtime(), now() from sales limit 1;
select * from sales limit 10;
select * from sales limit 10000000,3;
select uid, sum(amt)  from sales group by uid limit 4;

load $HOME/jaguardb_qatest/jbench_cn.txt  into jbench;

changepass newpass;
createuser test123:test1234test1234test1234;
changepass test123:jaguar000000000000;
dropuser test123;

drop table tms1;
drop table tms2;

create table if not exists tms1 ( key: ts timestamp, value: addr char(18) );
insert into tms1 values ( '2016-12-18 12:21:00', '123 B St' );
insert into tms1 values ( '2016-12-14 13:21:00', '124 B St' );
insert into tms1 values ( '2016-12-14 14:21:00', '124 B St' );
insert into tms1 values ( '2016-12-12 15:21:00', '125 B St' );
insert into tms1 values ( '2016-12-13 15:21:00', '125 B St' );
sleep 3;
select * from tms1;
select * from tms1 where addr in ( '123 B St', '125 B St' );
create index tms1_idx1 on tms1 ( addr );
select * from tms1_idx1;
select * from tms1_idx1 group by addr;
select * from tms1_idx1 group by addr limit 1;
select * from tms1_idx1 group by addr limit 2,3;

update tms1 set addr='new addr111' where ts='2016-12-14 12:21:00';
select * from tms1;
select * from tms1_idx1;
delete from tms1 where ts='2016-12-14 12:21:00';
select * from tms1;
select * from tms1_idx1;

create table if not exists tms2 ( key asc: ts timestamp, value: addr char(18), updt timestamp );
insert into tms2 values ( '2016-11-18 12:21:00', 'aa1', '2016-11-18 12:21:00'  );
insert into tms2 values ( '2016-11-18 12:21:02', 'aa2', '2015-12-14 12:21:00' );
insert into tms2 values ( '2016-11-18 12:21:03', 'aa3', '2012-10-12 12:21:00' );
insert into tms2 values ( '2016-11-18 12:21:04', 'aa4', '2011-10-12 12:21:00.123456789' );
insert into tms2 values ( '2016-11-18 12:21:05', 'aa5', '2017-10-11 14:21:00.22345678' );
insert into tms2 values ( '2016-11-18 12:21:06', 'aa6', '2017-10-11 14:21:00.22345678' );
insert into tms2 values ( '2016-11-18 12:21:07', 'aa6', '2017-10-11 14:21:00.22345678' );
insert into tms2 values ( '2016-11-18 12:21:08', 'aa6', '2017-10-11 14:21:00.22345678' );
sleep 3;
select * from tms2;

create index tms2_idx1 on tms2 ( updt );
select * from tms2_idx1;

create index tms2_idx2 on tms2 ( updt, addr );
select * from tms2_idx2;

update tms2 set addr='new addr222' where updt='2017-10-11 14:21:00.22345678';
select * from tms2;
select * from tms2_idx1;
select * from tms2_idx2;
select * from tms2_idx2 where updt between '2011-10-12 12:21:00' and '2016-11-18 12:21:00';

delete from tms2 where updt='2017-10-11 14:21:00.22345678';
select * from tms2;
select * from tms2_idx1;
select * from tms2_idx2;
select * from tms2_idx2 group by updt order by addr;
select * from tms2_idx2 group by updt order by updt;
select * from tms2_idx2 group by updt order by updt limit 2;
select * from tms2_idx2 where addr > 'Z' group by updt order by updt limit 2;
select * from tms2_idx2 where addr > 'Z' order by updt limit 2;
select * from tms2_idx2 where addr > 'Z' order by addr limit 2;
select * from tms2_idx2 where addr > 'Z' order by addr;
select * from tms2_idx2 where addr > 'Z' or uid = 'aaa'  order by addr;
select * from tms2_idx2 where addr > 'Z' or uid = 'aaa'  order by addr, uid;
select * from tms2_idx2 where addr > 'Z' and uid = 'aaa'  order by addr, uid;
select * from tms2_idx2 where addr > 'Z' and uid = 'aaa' group by updt  order by addr, uid;

## Below are error cases on invalid columns:
update tms2_idx2 set uid='ppp' where addr='v1';
update tms2_idx2 set uid='ppp' where uid='v1';
update tms2_idx2 set addr='ppp' where uid='v1';
update tms2_idx2 set addr='ppp' where addr='v1' and uid='ppp';
delete from tms2_idx2 where addr='v1' and uid='ppp';
delete from tms2_idx2 where addr='v1';
delete from tms2_idx2 where addr='v1' or uid='ppp';
insert into tms2_idx2 values ( '2017-10-11 14:21:00.22345678', '1111111' );
insert into tms2_idx1 values ( '2027-10-11 14:21:00.52345678' );

### ok now
update tms2_idx2 set addr='ppp' where updt='2017-10-11 14:21:00.22345678';
delete from tms2_idx2 where addr='v1';


drop index tms2_idx1 on tms2;
desc tms2_idx1;
select * from tms2_idx1;


create table if not exists asc1 (key asc: uid char(12), value: addr char(32) );
insert into asc1 values ( k1, v1 );
insert into asc1 values ( k2, v2 );
insert into asc1 values ( k3, v3 );
insert into asc1 values ( k4, v4 );
insert into asc1 values ( k5, v5 );
insert into asc1 values ( k6, v );
insert into asc1 values ( k7, v );
insert into asc1 values ( k8, v2 );
insert into asc1 values ( k9, v3 );
insert into asc1 values ( k10, v4 );
insert into asc1 values ( k40, v124 );
insert into asc1 values ( k30, v5 );
sleep 3;

select * from asc1;
select * from asc1 where uid='k1';
select * from asc1 where uid='k3';
select * from asc1 where uid='k2';
select * from asc1 where uid='k4';

delete from asc1 where uid='k22';
delete from asc1 where uid='k4';
update asc1 set addr='newnewnew' where uid='k3';
update asc1 set addr='newnewnew' where uid='k4';
update asc1 set addr='newnewnew' where uid='k1';
select * from asc1;

### uuid as key
create table if not exists nokey ( a int, b int, c real, d text );
insert into nokey values ( 11, 22, 12.4, 'hi there rjehre re' );
insert into nokey values ( 11, 22, 12.4, 'hi there rjehre re' );
insert into nokey values ( 12, 22, 12.5, 'h there rjehre re' );
sleep 3;
select * from nokey;
select a, sum(b) from nokey group by a;



## show
show databases;
show tables;
show indexes;
show currentdb;
show task;
show indexes from tms2;
show indexes in tms2;
show server version;
show client version;
show user;
show status;

select  updt, max(ts), addr, substr(addr, 100, 2) as kk from tms2;

### error cases
slekf  from fjkfgf;
update fkff set gg=333 from tms2;
delete from tms2 where ddd=334;
select  updt, max(ts), addr, substr(addr, 100, 2) ass kk from tms2;
select  updt, max(ts), addr, substr2(addr, 100, 2) as kk from tms2;
select  updt, max2(ts), addr, substr2(addr, 100, 2) as kk from tms2;
select jjj, updt, max2(ts), addr, substr2(addr, 100, 2) ass kk from tms2;
select cos( upd ), sin( updt ) from tms2_idx2 where updt between '2011-10-12 12:21:00' and '2016-11-18 12:21:00';


### join test cases
drop table if exists j0;
drop table if exists j1;
drop table if exists j2;
drop table if exists j3;
drop table if exists j4;
drop table if exists j5;
drop table if exists j6;
drop table if exists j7;
drop table if exists j8;
drop table if exists j9;
create table if not exists j0 ( key: k01 int, k02 char(3), value: v01 int, v02 char(3) );
create table if not exists j1 ( key: k11 int, k12 char(3), value: v11 int, v12 char(3) );
create table if not exists j2 ( key: k21 int, k22 char(3), value: v21 int, v22 char(3) );
create table if not exists j3 ( key: k31 int, k32 char(3), value: v31 int, v32 char(3) );
create table if not exists j4 ( key: k41 int, k42 char(3), value: v41 int, v42 char(3) );
create table if not exists j5 ( key: k51 int, k52 char(3), value: v51 int, v52 char(3) );
create table if not exists j6 ( key: k61 int, k62 char(3), value: v61 int, v62 char(3) );
create table if not exists j7 ( key: k71 int, k72 char(3), value: v71 int, v72 char(3) );
create table if not exists j8 ( key: k81 int, k82 char(3), value: v81 int, v82 char(3) );
create table if not exists j9 ( key: k91 int, k92 char(3), value: v91 int, v92 char(3) );
insert into j0 values ( '100', 'aaa', '100', 'bbb' );
insert into j0 values ( '100', 'ccc', '100', 'ddd' );
insert into j0 values ( '100', 'eee', '100', 'fff' );
insert into j0 values ( '100', 'ggg', '100', 'hhh' );
insert into j0 values ( '100', 'iii', '100', 'jjj' );
insert into j0 values ( '100', 'kkk', '100', 'lll' );
insert into j0 values ( '100', 'mmm', '100', 'nnn' );
insert into j0 values ( '100', 'ooo', '100', 'ppp' );
insert into j0 values ( '100', 'qqq', '100', 'rrr' );
insert into j0 values ( '100', 'sss', '100', 'ttt' );
insert into j1 values ( '100', 'uuu', '100', 'vvv' );
insert into j1 values ( '100', 'www', '100', 'xxx' );
insert into j1 values ( '100', 'yyy', '100', 'zzz' );
insert into j1 values ( '100', '!!!', '100', '@@@' );
insert into j1 values ( '100', '###', '100', '$$$' );
insert into j1 values ( '100', '%%%', '100', '^^^' );
insert into j1 values ( '100', '&&&', '100', '***' );
insert into j1 values ( '100', '(((', '100', ')))' );
insert into j1 values ( '100', '---', '100', '+++' );
insert into j1 values ( '100', '___', '100', '===' );
insert into j2 values ( '100', 'aaa', '100', 'bbb' );
insert into j2 values ( '100', 'ccc', '100', 'ddd' );
insert into j2 values ( '100', 'eee', '100', 'fff' );
insert into j2 values ( '100', 'ggg', '100', 'hhh' );
insert into j2 values ( '100', 'iii', '100', 'jjj' );
insert into j2 values ( '200', 'kkk', '200', 'lll' );
insert into j2 values ( '200', 'mmm', '200', 'nnn' );
insert into j2 values ( '200', 'ooo', '200', 'ppp' );
insert into j2 values ( '200', 'qqq', '200', 'rrr' );
insert into j2 values ( '200', 'sss', '200', 'ttt' );
insert into j3 values ( '100', 'uuu', '100', 'vvv' );
insert into j3 values ( '100', 'www', '100', 'xxx' );
insert into j3 values ( '100', 'yyy', '100', 'zzz' );
insert into j3 values ( '100', '!!!', '100', '@@@' );
insert into j3 values ( '100', '###', '100', '$$$' );
insert into j3 values ( '200', '%%%', '200', '^^^' );
insert into j3 values ( '200', '&&&', '200', '***' );
insert into j3 values ( '200', '(((', '200', ')))' );
insert into j3 values ( '200', '---', '200', '+++' );
insert into j3 values ( '200', '___', '200', '===' );
insert into j4 values ( '100', 'aaa', '100', 'bbb' );
insert into j4 values ( '100', 'ccc', '100', 'ddd' );
insert into j4 values ( '300', 'eee', '300', 'fff' );
insert into j4 values ( '300', 'ggg', '300', 'hhh' );
insert into j4 values ( '500', 'iii', '500', 'jjj' );
insert into j4 values ( '500', 'kkk', '500', 'lll' );
insert into j4 values ( '700', 'mmm', '700', 'nnn' );
insert into j4 values ( '700', 'ooo', '700', 'ppp' );
insert into j4 values ( '900', 'qqq', '900', 'rrr' );
insert into j4 values ( '900', 'sss', '900', 'ttt' );
insert into j5 values ( '000', 'uuu', '000', 'vvv' );
insert into j5 values ( '100', 'www', '100', 'xxx' );
insert into j5 values ( '200', 'yyy', '200', 'zzz' );
insert into j5 values ( '300', '!!!', '300', '@@@' );
insert into j5 values ( '400', '###', '400', '$$$' );
insert into j5 values ( '500', '%%%', '500', '^^^' );
insert into j5 values ( '600', '&&&', '600', '***' );
insert into j5 values ( '700', '(((', '700', ')))' );
insert into j5 values ( '800', '---', '800', '+++' );
insert into j5 values ( '900', '___', '900', '===' );
insert into j6 values ( '100', 'aaa', '100', 'bbb' );
insert into j6 values ( '100', 'ccc', '100', 'ddd' );
insert into j6 values ( '100', 'eee', '100', 'fff' );
insert into j6 values ( '100', 'ggg', '100', 'hhh' );
insert into j6 values ( '200', 'iii', '200', 'jjj' );
insert into j6 values ( '200', 'kkk', '200', 'lll' );
insert into j6 values ( '200', 'mmm', '200', 'nnn' );
insert into j6 values ( '300', 'ooo', '300', 'ppp' );
insert into j6 values ( '300', 'qqq', '300', 'rrr' );
insert into j6 values ( '400', 'sss', '400', 'ttt' );
insert into j7 values ( '100', 'uuu', '100', 'vvv' );
insert into j7 values ( '100', 'www', '100', 'xxx' );
insert into j7 values ( '100', 'yyy', '100', 'zzz' );
insert into j7 values ( '100', '!!!', '100', '@@@' );
insert into j7 values ( '200', '###', '200', '$$$' );
insert into j7 values ( '200', '%%%', '200', '^^^' );
insert into j7 values ( '200', '&&&', '200', '***' );
insert into j7 values ( '300', '(((', '300', ')))' );
insert into j7 values ( '300', '---', '300', '+++' );
insert into j7 values ( '400', '___', '400', '===' );
insert into j8 values ( '000', 'aaa', '050', 'bbb' );
insert into j8 values ( '100', 'ccc', '150', 'ddd' );
insert into j8 values ( '200', 'eee', '250', 'fff' );
insert into j8 values ( '300', 'ggg', '350', 'hhh' );
insert into j8 values ( '400', 'iii', '450', 'jjj' );
insert into j8 values ( '500', 'kkk', '550', 'lll' );
insert into j8 values ( '600', 'mmm', '650', 'nnn' );
insert into j8 values ( '700', 'ooo', '750', 'ppp' );
insert into j8 values ( '800', 'qqq', '850', 'rrr' );
insert into j8 values ( '900', 'sss', '950', 'ttt' );
insert into j9 values ( '050', 'uuu', '000', 'vvv' );
insert into j9 values ( '250', 'www', '200', 'xxx' );
insert into j9 values ( '450', 'yyy', '400', 'zzz' );
insert into j9 values ( '650', '!!!', '600', '@@@' );
insert into j9 values ( '850', '###', '800', '$$$' );
insert into j9 values ( '100', '%%%', '150', '^^^' );
insert into j9 values ( '300', '&&&', '350', '***' );
insert into j9 values ( '500', '(((', '550', ')))' );
insert into j9 values ( '700', '---', '750', '+++' );
insert into j9 values ( '900', '___', '950', '===' );
sleep 3;

select * from j0 order by k01, v01, k02;
select * from j1 order by k11, v11, k12;
select * from j2 order by k21, v21, k22;
select * from j3 order by k31, v31, k32;
select * from j4 order by k41, v41, k42;
select * from j5 order by k51, v51, k52;
select * from j6 order by k61, v61, k62;
select * from j7 order by k71, v71, k72;
select * from j8 order by k81, v81, k82;
select * from j9 order by k91, v91, k92;
#join cmds
select * from j0, j1 where j0.k01=j1.k11;
select * from j0 join j1 on j0.k01=j1.k11;
select * from j0, j1 where j0.k01=j1.v11;
select * from j0 join j1 on j0.k01=j1.v11;
select * from j0, j1 where j0.v01=j1.k11;
select * from j0 join j1 on j0.v01=j1.k11;
select * from j0, j1 where j0.v01=j1.v11;
select * from j0 join j1 on j0.v01=j1.v11;
select * from j1, j0 where j0.k01=j1.k11;
select * from j1 join j0 on j0.k01=j1.k11;
select * from j1, j0 where j0.k01=j1.v11;
select * from j1 join j0 on j0.k01=j1.v11;
select * from j1, j0 where j0.v01=j1.k11;
select * from j1 join j0 on j0.v01=j1.k11;
select * from j1, j0 where j0.v01=j1.v11;
select * from j1 join j0 on j0.v01=j1.v11;
select * from j2, j3 where j2.k21=j3.k31;
select * from j2 join j3 on j2.k21=j3.k31;
select * from j2, j3 where j2.k21=j3.v31;
select * from j2 join j3 on j2.k21=j3.v31;
select * from j2, j3 where j2.v21=j3.k31;
select * from j2 join j3 on j2.v21=j3.k31;
select * from j2, j3 where j2.v21=j3.v31;
select * from j2 join j3 on j2.v21=j3.v31;
select * from j3, j2 where j2.k21=j3.k31;
select * from j3 join j2 on j2.k21=j3.k31;
select * from j3, j2 where j2.k21=j3.v31;
select * from j3 join j2 on j2.k21=j3.v31;
select * from j3, j2 where j2.v21=j3.k31;
select * from j3 join j2 on j2.v21=j3.k31;
select * from j3, j2 where j2.v21=j3.v31;
select * from j3 join j2 on j2.v21=j3.v31;
select * from j4, j5 where j4.k41=j5.k51;
select * from j4 join j5 on j4.k41=j5.k51;
select * from j4, j5 where j4.k41=j5.v51;
select * from j4 join j5 on j4.k41=j5.v51;
select * from j4, j5 where j4.v41=j5.k51;
select * from j4 join j5 on j4.v41=j5.k51;
select * from j4, j5 where j4.v41=j5.v51;
select * from j4 join j5 on j4.v41=j5.v51;
select * from j5, j4 where j4.k41=j5.k51;
select * from j5 join j4 on j4.k41=j5.k51;
select * from j5, j4 where j4.k41=j5.v51;
select * from j5 join j4 on j4.k41=j5.v51;
select * from j5, j4 where j4.v41=j5.k51;
select * from j5 join j4 on j4.v41=j5.k51;
select * from j5, j4 where j4.v41=j5.v51;
select * from j5 join j4 on j4.v41=j5.v51;
select * from j6, j7 where j6.k61=j7.k71;
select * from j6 join j7 on j6.k61=j7.k71;
select * from j6, j7 where j6.k61=j7.v71;
select * from j6 join j7 on j6.k61=j7.v71;
select * from j6, j7 where j6.v61=j7.k71;
select * from j6 join j7 on j6.v61=j7.k71;
select * from j6, j7 where j6.v61=j7.v71;
select * from j6 join j7 on j6.v61=j7.v71;
select * from j7, j6 where j6.k61=j7.k71;
select * from j7 join j6 on j6.k61=j7.k71;
select * from j7, j6 where j6.k61=j7.v71;
select * from j7 join j6 on j6.k61=j7.v71;
select * from j7, j6 where j6.v61=j7.k71;
select * from j7 join j6 on j6.v61=j7.k71;
select * from j7, j6 where j6.v61=j7.v71;
select * from j7 join j6 on j6.v61=j7.v71;
select * from j8, j9 where j8.k81=j9.k91;
select * from j8 join j9 on j8.k81=j9.k91;
select * from j8, j9 where j8.k81=j9.v91;
select * from j8 join j9 on j8.k81=j9.v91;
select * from j8, j9 where j8.v81=j9.k91;
select * from j8 join j9 on j8.v81=j9.k91;
select * from j8, j9 where j8.v81=j9.v91;
select * from j8 join j9 on j8.v81=j9.v91;
select * from j9, j8 where j8.k81=j9.k91;
select * from j9 join j8 on j8.k81=j9.k91;
select * from j9, j8 where j8.k81=j9.v91;
select * from j9 join j8 on j8.k81=j9.v91;
select * from j9, j8 where j8.v81=j9.k91;
select * from j9 join j8 on j8.v81=j9.k91;
select * from j9, j8 where j8.v81=j9.v91;
select * from j9 join j8 on j8.v81=j9.v91;

create table if not exists def1 ( key: uid int, value: b int default '1', c varchar(32) default 'C' );
insert into def1 ( uid ) values ( 100 );
insert into def1 values ( 200 );
insert into def1 values ( 200, 1000 );
sleep 2;
select * from def1;

create table if not exists def2 ( key: uid int, value: b int default '1', tm timestamp default current_timestamp on update current_timestamp );
insert into def2 ( uid ) values ( 100 );
insert into def2 values ( 200 );
insert into def2 values ( 300, 1000 );
sleep 2;
select * from def2;
update def2 set b=999 where uid=100;
select * from def2;



quit;
