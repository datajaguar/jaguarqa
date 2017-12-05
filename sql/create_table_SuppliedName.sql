# Script Name: create_table_SuppliedName.sql 

drop table if exists SuppliedName;

spool $QA_HOME/work/create_table_SuppliedName.out;

drop table if exists SuppliedName;


create table SuppliedName 
(
    key:
        SnID int,
    value:
        Name varchar(50),
        Language varchar(30),
        Status varchar(20),
        Standard varchar(20),
        PlaceID int, 
        SupplierID int,
        DateSupplied date
);

desc SuppliedName; 

spool off;

quit;

