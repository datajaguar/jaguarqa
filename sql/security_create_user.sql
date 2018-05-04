# Jaguar sql: security test - create user

dropuser UID1;
dropuser UID2;

spool  $QA_HOME/work/security_create_user.out;

showusers;
createuser UID1:password;
createuser UID1:Pawd56789012;
showusers;

createuser UID1:Pawd5678901234;

createuser UID2:Pawd56789012 34;

createuser UID2:Pawd567890_&#>/^$?; 

showusers;

spool off;
quit;

