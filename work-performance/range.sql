# Script Name: range.sql

select * from db_mongo_jaguar.tab_700million where uid like '9d%' limit 100000;
select * from db_mongo_jaguar.tab_700million where uid >=  '9d%' limit 100000;
select * from db_mongo_jaguar.tab_700million where uid  between '3d%' and '9d%' limit 100000; 
select * from db_mongo_jaguar.tab_700million group by uid limit 100000;

# Done Done in 60 seconds (1 row): Why?
select count(*) from db_mongo_jaguar.tab_700million where uid  between '3d%' and '9d%' limit 5;

# Done in 753 milliseconds (5 rows): why?
select * from db_mongo_jaguar.tab_700million where uid  between '3d%' and '9d%' limit 5;
