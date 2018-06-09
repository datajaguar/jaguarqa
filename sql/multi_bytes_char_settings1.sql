# Script Name: multi_bytes_char_settings.sql
# This script is to verify the bug from the test of
# multi_bytes_char_settings1.sql

dropdb Country_Name;

spool  $QA_HOME/work/multi_bytes_char_settings1.out;

createdb Country_Name;

use Country_Name;

create table City2( key: Name char(32), value: Place char(32) );
sleep 3;

desc City2;

insert into City2 values ( 'city2-1', '東京Tokyo');
insert into City2 values ( 'city2_1', '大阪Oska');
insert into City2 values ( 'city2c', 'ナゴヤドームNagoya');
insert into City2 values ( 'city2.d', '重庆Chongqing');

sleep 4;
select * from City2; 
select * from City2 where place='city2-1';
select * from City2 where place='city2_1';
select * from City2 where place='city2c1';
select * from City2 where place='city2.d';

spool off;

quit;

