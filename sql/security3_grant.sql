# Script Name:  security2.sql
# purpose: security test - Change password 
# Bug069

spool $QA_HOME/work/security_create_user.out;

showusers;
chanegepassword jaguar789012;

spool off;
quit;

