# Jaguar sql: security test - create user
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

spool  $QA_HOME/work/security1_create_user.out;

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
grant all on jag_data_load.data_load to UID_g2:

createuser UID_g4:Pawd5678901234; 
grant select on jag_data_load.data_load to UID_g3; 

createuser UID_g5:Pawd5678901234; 
# Test for grant all on all to user.

showusers;

spool off;
quit;

