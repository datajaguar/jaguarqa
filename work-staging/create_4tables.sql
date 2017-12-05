/*
Script Name: create_3tables.sql 
Date: 11/14/2017
Features:
1. Nested insert
2. Fuction sum, avg, group by, order by, etc

*/
drop table if exists table1;
drop table if exists table2;
drop table if exists table3;
drop table if exists table4;

spool $QA_HOME/work/create_4tables.sql.out;

create table table1 
(
    key:
        uid char(16),
    value:
        adddr char(32),
);


create table table2
(
     key:
        uid2 char(16),
     value:
        adddr2 char(32),
);

create table table3
(
    key:
        col1 char(16),
        col2 int,
    value:
        v1 char(32),
);

create table table4
(
     key: 
        k1 char(16),
     value:
        col3 char(16),
        col4 int,
        v2 double(12.5),
);

desc table1;
desc table2;
desc table3;
desc table4;

# Test 1: Insert two rows data at table2:
#########################################
insert into table2 (uid2, adddr2) values("John Smith", "CA, USA");
insert into table2 (uid2, adddr2) values("Mike Lee", "WA, USA");
sleep 4;

select * from table2;
select count(*) from table1;
insert into table1 select * from table2;
sleep 4;
select count(*) from table1;
select * from table1;


# Test 2: Insert one more row into table4  
##########################################
insert into table4 (k1, col3, col4, v2) values("Bob","M","50","156.56");
insert into table4 (k1, col3, col4, v2) values("Andy","M","52","144.26");
insert into table4 (k1, col3, col4, v2) values("Zora","F","46","125.41");
insert into table4 (k1, col3, col4, v2) values("Jason","M","35","125.41");
insert into table4 (k1, col3, col4, v2) values("Jeremy","M","36","135.40");
insert into table4 (k1, col3, col4, v2) values("Bao","M","40","145.4");
insert into table4 (k1, col3, col4, v2) values("Kevin","M","24","141.98");
insert into table4 (k1, col3, col4, v2) values("Jane","F","24","125.41");

sleep 4;
select * from table4;
select count(*) from table4;
select count(*) from table3;
insert into TABLE3 ( TABLE3.col1, TABLE3.col2 ) select TABLE4.col3, TABLE4.col4 from TABLE4;
sleep 3;

select count(*) from table3;
select * from table3;

# Test 3: Test function sum and avg
##############################################
select avg(col4) from table4;
select avg(v2) from table4;
select sum(v2) from table4;

# Test 4: group by and order by
##############################################
select count(*) from table4;
select col3 as "Sex", count(col3) from table4 group by col3;

select count(*) from table4;
select col3 as "Sex", count(col3) as "Number of M/F" from table4 group by col3;

select count(*) from table4;
select * from table4 group by col4 order by k1;

# Test 5: Test the fix of Bug027_20171120(Core dump generated with wrong syntax)
# This next query result "Invalid order by syntax [20]" is not in the output from the spool?
select col3 as "Sex", count(col3) from table4 group by col3 order by k1;
sleep 2;

spool off;
quit;
