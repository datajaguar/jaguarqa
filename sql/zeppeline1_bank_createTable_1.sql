
drop table if exists zeppeline1_bank_1;


spool $QA_HOME/work/zeppeline1_bank_creatTable_1.out;

create table zeppeline1_bank_1 
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

desc zeppeline1_bank_1;

spool off;
quit;


