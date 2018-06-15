# Script Name: security1_create_grant.sql
# 1) Create users 
# 2) Change password for 

dropuser UID1;
dropuser UID2;
dropuser UID_g1;
dropuser UID_g2;
dropuser UID_g3;
dropuser UID_g4;
dropuser UID_g5;
dropuser UID_g6;
dropuser UID_g7;
dropuser UID_g8;
dropuser UID_g9;
dropuser UID_g10;

spool  $QA_HOME/work/security1_create_grant.out;

showusers;
#createuser UID1:password;
#createuser UID1:Pawd56789012; # If run this one, will cause the UID1 failed to login by the correct password.
showusers;

createuser UID1:Pawd5678901234; 

createuser UID2:Pawd56789012 34;

createuser UID2:Pawd567890_&#>/^$?; 

createuser UID_g1:Pawd5678901234; 
grant all on all to UID_g1;

createuser UID_g2:Pawd5678901234; 
grant all on jag_data_load to UID_g2:

# Please show me the following grant for UID_g3:
createuser UID_g4:Pawd5678901234; 
grant create on jag_data_load to UID_g3; 

createuser UID_g5:Pawd5678901234; 
grant insert on jag_data_load.data_load to UID_g4;

createuser UID_g5:Pawd5678901234;
grant select on jag_data_load.data_load to UID_g5;

createuser UID_g6:Pawd5678901234;
grant update on jag_data_load.data_load to UID_g6;

createuser UID_g7:Pawd5678901234;
grant delete on jag_data_load.data_load to UID_g7;

createuser UID_g8:Pawd5678901234;
grant delete on jag_data_load.data_load to UID_g8;


createuser UID_g9:Pawd5678901234;
grant alter on jag_data_load.data_load to UID_g9;

createuser UID_g10:Pawd5678901234;
grant truncate on jag_data_load.data_load to UID_g10;

showusers;

show grants for UID_g1;
show grants for UID_g2;
show grants for UID_g3;
show grants for UID_g4;
show grants for UID_g5;
show grants for UID_g6;
show grants for UID_g7;
show grants for UID_g8;
show grants for UID_g9;
show grants for UID_g10;

spool off;
quit;

