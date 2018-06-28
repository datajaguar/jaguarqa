# Script Name: unittest3.ql   
# Features: 
# 1. Data type: datetime, timestamp 
# 2. 
drop table if exists sales;

spool  $QA_HOME/work/sales.out;

create table if not exists sales ( key: uid int, daytime datetime, value: amt float(3.1), unit float(3.1), utype char(1) );
load $QA_HOME/data/sales.txt into sales ;

insert into sales values (10, '2014-04-23 08:59:52.000000', 0.1, 0.1, 'C' );
insert into sales values (10, '2014-04-23 08:59:59.000000', 0.1, 0.1, 'C' );
insert into sales values (10, '2014-04-29 08:59:59.000000', 0.1, 0.1, 'C' );

create table if not exists service ( key: uid int, daytime datetime, value: phone char(10), reason char(16) );
load $QA_HOME/data/service.txt into service ;

select dayofmonth( daytime), dayofweek( daytime ), dayofyear(daytime) from service limit 1;

sleep 4;

create table if not exists tms1 ( key: ts timestamp, value: addr char(18) );




spool off;

quit;

 
