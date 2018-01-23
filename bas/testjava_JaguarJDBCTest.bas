Picked up _JAVA_OPTIONS: -Djava.net.preferIPv4Stack=true
t.testJaguarDataSource ......................

uid: k1k1 addr: v1v1 
uid: n11
line\'2 addr: v11
val"ue
insert into jbench values ( 'n11
line\'2', 'v11
val"ue' ) ; 
select * from jbench where uid like 'n1%';
uid: n11
line\'2 addr: v11
val"ue


t.testJaguarDataSourcePrepare ....................

uid: k1k1 m1: 
uid: n11
line\'2 m1: 
test ResultSetMetaData after next ...
coltype=0
colname=null
coltype=0
colname=null
select * from asctable where id <=2;
select id, count(1) as cnt, sum(phone) as sum from asctable where id<2; 
*************************************
update asctable set phone=111 where id>10;
id: 3 phone: 144
delete from asctable where id>10;
select * from asctable
id: 3 phone: 144
select id, phone from asctable where id < ? and ( phone > 232 or phone > ? ) and id < 100 
id: 3 phone: 144


t.testMetaData ...................................

Database Product Name: Jaguar
Database Product Version: 2.0
Logged User: admin
JDBC Driver: Jaguar-JDBC
Driver Version: 2.0


metadata.getTables ... 
table: asctable cat: test type: TABLE
table: column_default cat: test type: TABLE
table: column_default2 cat: test type: TABLE
table: column_default3 cat: test type: TABLE
table: column_defaultr3 cat: test type: TABLE
table: function1 cat: test type: TABLE
table: function1_pow cat: test type: TABLE
table: import_export cat: test type: TABLE
table: jbench cat: test type: TABLE
table: t1 cat: test type: TABLE
table: t12 cat: test type: TABLE
table: t2 cat: test type: TABLE
table: table1 cat: test type: TABLE
table: table2 cat: test type: TABLE
table: table3 cat: test type: TABLE
table: table4 cat: test type: TABLE
table: test_2b cat: test type: TABLE
metadata.getTables done 
metadata.getColumns ...
getcolumns: table: jbench col: uid
    datatype: 1 typename: CHAR
    size: 16 decimaldigits: 0
getcolumns: table: jbench col: addr
    datatype: 1 typename: CHAR
    size: 32 decimaldigits: 0
getcolumns: table: jbench col: spare_
    datatype: 1 typename: CHAR
    size: 14 decimaldigits: 0
metadata.getColumns done 
metadata.getCatalogs ...
db: test
db: jag_data_load
db: db_mongo-jaguar
db: db_mongo_jaguar
metadata.getCatalogs done 


t.testDriver .........................................

drop table t12 ... 
Done create table 
Done, insert. executeQuery ...
desc t12 ...
