# Script Name: multi_bytes_char_settings1.sql

dropdb db_城市名;
dropdb db_城市名_とうきょ;
dropdb 星巴克;
drop table if exist 星巴克.礼品卡;
dropdb 国家名;

spool  $QA_HOME/work/multi_bytes_char_settings1.out;

createdb db_城市名;
createdb db_城市名_とうきょ;
createdb 星巴克;

#show databases;

use db_城市名;
use db_城市名_とうきょ;
use 星巴克;

create table 礼品卡
(
  key:
    产品_ID integer,
    编号_no char(100)),
  value:
    卡号_id char(50),
    产品_no char(50)
);

show tables;
desc 星巴克.礼品卡;

createdb 国家名; 
use 国家名;

create table 城市( key: 名 char(32), value: 地点 char(32) );
create table 城市2( key: 名 char(32), value: 地点 char(32) );
sleep 3;

desc 城市;
desc 城市2; 

insert into 城市 values ( 'ddd的基督', 'fffff');
insert into 城市 values ( '阿飞花费', 'fffff');
insert into 城市 values ( '比你高', 'fffff');

insert into 城市2 values ( 'ddd的基督', 'fffff');
insert into 城市2 values ( '阿飞花费', 'fffff');
insert into 城市2 values ( '比你高', 'fffff');

sleep 4;
select * from 城市;
select * from 城市2;
select  城市2.名, 城市2.地点from 城市2 where 名='比你高';
select  城市.名, 城市.地点 from 城市 where 地点 = 'fffff';

select * from 城市, 城市2 where 城市.名 = 城市2.名;
select 城市.名, 城市2.名, 城市2.地点  from 城市, 城市2 where 城市.名 = 城市2.名;

# Update:
update 城市 set 名='城市1', 地点='上海', where 名='ddd的基督';
update 城市 set 名='城市2', 地点='天津', where 名='阿飞花费';
update 城市 set 名='城市3', 地点='重庆', where 名='比你高';
select * from 城市;

update 城市2 set 名='城市2-1', 地点='とうきょ', where 名='ddd的基督';
update 城市2 set 名='城市2_2', 地点='大阪', where 名='阿飞花费';
update 城市2 set 名='城市2c', 地点='ナゴヤドーム', where 名='比你高';
insert into 城市2 values ( '城市2d', '重庆');

insert into 城市2 values ( 'city2-1', 'city_とうきょ');
insert into 城市2 values ( 'city2_1', 'city_大阪');

select * from 城市2;

select 城市.名, 城市.地点 from 城市 where 地点 = '天津';
select 城市.名, 城市.地点 from 城市 where 名='城市2';

select 名, 地点 from 城市2 where  地点 = '大阪';
select 城市.名, 城市.地点 from 城市2 where 地点 = 'ナゴヤドーム';

select 城市.名, 城市2.名 from 城市, 城市2 where 城市.地点 = 城市2.地点;

select 城市.名, 城市.地点 from 国家名.城市2 where 名 = '城市2c';

# This one failed:
select 城市.名, 城市.地点 from 国家名.城市2 where 名 = '城市2_1';

# How about this:
select 城市.名, 城市.地点 from 国家名.城市2 where 名 = 'city2-1';
select 城市.名, 城市.地点 from 国家名.城市2 where 名 = 'city2_1';

spool off;

quit;

