# Script Name: create_table_Supplier.sql 

drop table if exists Supplier;

spool $QA_HOME/work/create_table_Supplier.out;

drop table if exists Supplier;


create table Supplier 
(
    key:
        SupplierID int,
    value:
        Nmae varchar(50),
        Country varchar(20),
        ReliabilityScore int,
        ContactInfo varchar(50)
);

desc Supplier;

spool off;

quit;

