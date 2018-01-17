# Test new schema
# Script Name: column_default1.sql
# command line: loginj < column_default1.sql

drop table if exists column_default; 

spool $QA_HOME/work/column_default1.out;

create table column_default
(
    key:    Emp_ID int,
    value:  First_Name char(10),
            Last_Name char(10),
            Zip_Code char(5),
            Age int default '9',
            Sex char(2) default 'M', 
            Category bit default b'1',
            UUID uuid
);

desc column_default;

insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('101','Jason','Zhang','94588','20','M','','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('1011','Mike','','94588','40','m1','0','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('102','Andrew','Zhang','94588','','','1','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('103','Sherry','','94588','','F','2','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('104','Jerry','','94588','23','h','A','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('105','Kevein','','94588','','','a','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('106','Kevein','','94588','','','B','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('107','Kevein','','94588','','','b','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('108','Kevein','','94588','','','7','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('109','Kevein','','94588','','','8','');
insert into test.column_default (emp_id,first_name,last_name,zip_code,age,sex,category,uuid) values ('1012','Vinod','','94588','40','zz','10','');

sleep 3;

select * from test.column_default; 

spool off;
quit;

