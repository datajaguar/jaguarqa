# SQL Name: bug065.sql   


drop table if exists bug065;

spool bug065.out; 

create table bug065 ( key: a float(26,3), value: b float(26,3), c float(26,3), d float(26,3) );
desc bug065;
insert into bug065 (a, b, c, d) values (100, 100, 100, 100);
select * from bug065;

insert into bug065 (a, b, c, d) values (100, 100iu, ABC, 100);
select * from bug065;

insert into bug065 (a, b, c, d) values (FQfbH,G7V2oxR,c3BRPl,FM33kU );

update bug065 set b  = abc where a = 100;
select * from bug065 where a = 100;

update bug065 set b  = 122 where a = 100;
select * from bug065;

#load $QA_HOME/data/10kLine.txt into bug065;

create table bug065_int ( key: a int, value: b int, c int, d int );

select count(*) from bug065;

load $QA_HOME/data/10kLine.txt into bug065_int;


spool off;

quit;


