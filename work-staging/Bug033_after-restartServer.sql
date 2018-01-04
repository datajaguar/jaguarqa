# Script Name: Bug033.sql 
# Date: 12/01/2017
# Features:
# 1. Automate bug fix for Bug033_20171130
# 2. Need to restart to verify the select syntax.
# 3.

spool Bug033_after-restartServer.out;

select * from new_database2.table2;
select * from new_database2.table2 where uid2="Mike Lee";

sleep 4;

spool off;
quit;
