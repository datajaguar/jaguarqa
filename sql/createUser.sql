# Jaguar sql: security test - create user
spool  $QA_HOME/work/createUser.sql.out;


createUser :
createuser UID:password;

changepass mypassword888;

showusers;
show user
dropuser UID;

spool off;
quit;

