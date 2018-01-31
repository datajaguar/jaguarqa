
drop table if exists create_table_bank;

spool create_table_bank.out;

create table create_table_bank
(
    key:
        id uuid,
    Value:
        age int,
        job varchar (50),
        marital varchar (10),
        education varchar (50),
        default_1 varchar (3),
        balance int,
        housing varchar (10),
        loan varchar (10),
        contact varchar (10),
        day int,
        month varchar (10),
        duration int,
        campaign int,
        pdays int,
        previous int,
        poutcome varchar (10),
        y varchar (10) 
);

desc create_table_bank;

load /home/andrew/bank-full.csv into create_table_bank;
sleep 2;
select count(*) from create_table_bank;

load /home/andrew/bank-full.csv into create_table_bank;
sleep 2;
select count(*) from create_table_bank;

load /home/andrew/bank-full.csv into create_table_bank;
sleep 2;
select count(*) from create_table_bank;

select age, count(1) value from create_table_bank where age<30 group by age order by age;

spool off;

quit;


