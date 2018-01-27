echo "starting: `date`"
cqlsh --request-timeout=3600 -e "select count(*) from mykeyspace.callinfo;"
echo "Ending: `date`"

