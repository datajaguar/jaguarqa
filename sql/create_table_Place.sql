# Script Name: create_table_Place.sql

drop table if exists Place;

spool $QA_HOME/work/create_table_Place.out;

drop table if exists Place;


create table Place
(
    key:
        PlaceID int,
    value:
        Latitude double(10,7),
        Longitude double(10,7),
        Elevation int,
        Population int,
        Type varchar(50),
        Country varchar (10)
);

desc Place;

spool off;

quit;

