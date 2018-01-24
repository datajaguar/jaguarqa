Picked up _JAVA_OPTIONS: -Djava.net.preferIPv4Stack=true
t.testJaguarDataSource ......................

uid: 0h0o3ZMaG8NRh64i addr: pxNCHplYlUPyC3iAjiYkfLsWRfN7jQpI
uid: 0vl1u35qIoGLpWEr addr: AI6HtsI9VwMTlb1lFkk9oqx6MdSb8uAG
uid: 1mYxqgQuG4GSL0kr addr: XgBaHZ8KnXptt80vuW0UbRpPT3HE315Y
uid: 1tmQKv19VTD7Y8IR addr: eA5ihCWsECqekrXlTh9DN8KGZnNYwtPI
uid: 2CKwnjWzSNDNBfBg addr: 9dzwrEHxVB8RAoRBYz7mQ1VINwtoL4CS
uid: 2NJYHaF71IiZljb7 addr: K5EfbRlBCGIGPsFRdpNUxq1y8hwtBFyj
uid: 2OodNRSbRQj9ns5N addr: lSQvACvi8M3yBkNB69OT0G4QvnZSN5D7
uid: 2U0huWJ8y7lQzibq addr: xi3iqLYq9JmDb9ld3juxdcDLjYBQeKgK
uid: 3QB2xnA8csZdvusv addr: tMsI1JKjfFtLK7BLVbLsylAJMxWhZnLs
uid: 4PioGD12mzrgmSFF addr: yPcHDiv4h1zQKtIOiZbZAc1WJrb4jOJP
insert into jbench values ( 'n11
line\'2', 'v11
val"ue' ) ; 
select * from jbench where uid like 'n1%';
uid: n11
line\'2 addr: v11
val"ue


t.testJaguarDataSourcePrepare ....................

uid: 0h0o3ZMaG8NRh64i m1: 
uid: 0vl1u35qIoGLpWEr m1: 
uid: 1mYxqgQuG4GSL0kr m1: 
uid: 1tmQKv19VTD7Y8IR m1: 
uid: 2CKwnjWzSNDNBfBg m1: 
uid: 2NJYHaF71IiZljb7 m1: 
uid: 2OodNRSbRQj9ns5N m1: 
uid: 2U0huWJ8y7lQzibq m1: 
uid: 3QB2xnA8csZdvusv m1: 
uid: 4PioGD12mzrgmSFF m1: 
test ResultSetMetaData after next ...
coltype=0
colname=null
coltype=0
colname=null
select * from asctable where id <=2;
select id, count(1) as cnt, sum(phone) as sum from asctable where id<2; 
*************************************
update asctable set phone=111 where id>10;
id: 5 phone: 117
delete from asctable where id>10;
select * from asctable
id: 5 phone: 117
select id, phone from asctable where id < ? and ( phone > 232 or phone > ? ) and id < 100 
id: 5 phone: 117


t.testMetaData ...................................

Database Product Name: Jaguar
Database Product Version: 2.0
Logged User: admin
JDBC Driver: Jaguar-JDBC
Driver Version: 2.0


metadata.getTables ... 
table: asc1 cat: test type: TABLE
table: asctable cat: test type: TABLE
table: base64 cat: test type: TABLE
table: def1 cat: test type: TABLE
table: def2 cat: test type: TABLE
table: egift_item_test cat: test type: TABLE
table: img cat: test type: TABLE
table: inst1 cat: test type: TABLE
table: inst2 cat: test type: TABLE
table: int10k cat: test type: TABLE
table: int10k_2 cat: test type: TABLE
table: j0 cat: test type: TABLE
table: j1 cat: test type: TABLE
table: j2 cat: test type: TABLE
table: j3 cat: test type: TABLE
table: j4 cat: test type: TABLE
table: j5 cat: test type: TABLE
table: j6 cat: test type: TABLE
table: j7 cat: test type: TABLE
table: j8 cat: test type: TABLE
table: j9 cat: test type: TABLE
table: jbench cat: test type: TABLE
table: jbench3 cat: test type: TABLE
table: join1 cat: test type: TABLE
table: join2 cat: test type: TABLE
table: mem1 cat: test type: TABLE
table: nokey cat: test type: TABLE
table: star1 cat: test type: TABLE
table: star2 cat: test type: TABLE
table: star3 cat: test type: TABLE
table: starhost cat: test type: TABLE
table: t12 cat: test type: TABLE
table: tms1 cat: test type: TABLE
table: tms2 cat: test type: TABLE
table: unittest1 cat: test type: TABLE
table: unittest2 cat: test type: TABLE
table: unittest3 cat: test type: TABLE
table: unittest_old cat: test type: TABLE
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
db: casco
metadata.getCatalogs done 


t.testDriver .........................................

drop table t12 ... 
Done create table 
Done, insert. executeQuery ...
desc t12 ...
