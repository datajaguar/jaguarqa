# Script Name:  security2.sql
# purpose: security test - Change password 
# 
# Currently the spooled out won't catch the error message.


spool $QA_HOME/work/security2_login_UID1.out;
createdb db_UID1;

changepass Pawd567890_&#;

spool off;
quit;

