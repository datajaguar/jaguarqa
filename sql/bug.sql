# SQL Name: bug064.sql  


drop table if exists bug;

spool $QA_HOME/work/bug.out; 


create table bug ( key: name char(32),  value: place char(32) ;
desc bug;
insert into bug  values (1, 100);
insert into bug  values (1-1, 220);
insert into bug  values (1_2, 300);
insert into bug  values (1d, 400);

select * from test.bug where name='1-1';
select * from test.bug where name='1_2';

spool off;

quit;


