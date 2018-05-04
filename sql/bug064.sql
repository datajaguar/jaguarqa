# SQL Name: bug064.sql  


drop table if exists bug064;

spool $QA_HOME/work/bug064.out; 


create table bug064 ( key: uid int, value: addr1_int int, addr2_f float, addr3_d double );
desc bug064;
insert into bug064 (uid, addr1_int, addr2_f, addr3_d) values (100, 100, 100, 100);

select * from bug064;

update bug064 set addr1_int = addr1_int * 10 where uid = 100;
update bug064 set addr2_f = addr2_f  * 10 where uid = 100;
update bug064 set addr3_d = addr3_d  * 10 where uid = 100;

select * from bug064;

update bug064 set addr1_int = addr1_int + '10' where uid = 100;
update bug064 set addr2_f = addr2_f + '10' where uid = 100;
update bug064 set addr3_d = addr3_d + '10' where uid = 100;

select * from bug064;

update bug064 set addr1_int = addr1_int + 1.0 where uid = 100;
update bug064 set addr2_f = addr2_f + 1.0 where uid = 100;
update bug064 set addr3_d = addr3_d + 1.0 where uid = 100;

select * from bug064;

spool off;

quit;


