# SQL Name: image.sql 
# Command Line: loginj < image.sql

# Note: new feature for 2.8.7.1 

drop table if exists image;

spool  $QA_HOME/work/image.out; 

create table image (key: uid bigint, value: picture char(100000) );

desc image;  

insert into image values (1001, '$QA_HOME/data/req.jpg') );
insert into image values (1002, '$QA_HOME/data/shanghai1.jpg') );
insert into image values (1003, '$QA_HOME/data/IMG_4M.jpg') );

sleep 3;

select uid, substr(picture, 2, 100) from image;
select count(*) from  image;
select * from image;

sleep 1;

getfile picture into '$QA_HOME/work/reg-out.jpg' from image where uid=1001;


spool off;
quit;


