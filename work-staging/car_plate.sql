# create a table to laod car plate with some random data:
# Script Name: car_plate.sql

drop table if exists test.carPlate;

spool  $QA_HOME/work/carPlate.out;

create table test.carPlate
(
      key:
        id_num char(32),
        random1 double(30,28),
        random2 double(30,28),
        random3 double(30,28),
        random4 double(30,28),
        random5 double(30,28),
        value:
        spare_ char(57)
);
desc test.carPlate;

load  $QA_HOME/data/carPlate.txt into test.carPlate;

sleep 4;

select count(*) from test.carPlate;

spool off;

quit;



