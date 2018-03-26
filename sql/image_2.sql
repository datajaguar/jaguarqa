# SQL Name: image.sql 
# Command Line: loginj < image.sql

# Note 1: new feature for 2.8.7.1 
# Note 2: Bug044_20180213
# Note: Test file as key and query file for where... 

drop table if exists image;

spool  $QA_HOME/work/image1.out; 

create table image (key: image file , value: img_2 file );

desc image;  

insert into image values ('$QA_HOME/data/req.jpg', '$QA_HOME/data/req.jpg') );
insert into image values (1002, '$QA_HOME/data/shanghai1.jpg') );
insert into image values (1003, '$QA_HOME/data/IMG_4M.jpg') );

sleep 3;

select uid, substr(img, 1, 100) from image;
select count(*) from  image;
select * from image where image='QA_HOME/data/req.jpg';

sleep 1;

#getfile img into '$QA_HOME/work/reg-out.jpg' from image where uid=1001;
getfile img into '/home/andrew/jaguarqa/work/req.jpg' from image where uid=1001;
getfile img into '/home/andrew/jaguarqa/work/shanghai1.jpg' from image where uid=1002;
getfile img into '/home/andrew/jaguarqa/work/IMG_4M.jpg' from image where uid=1003;

spool off;
quit;


