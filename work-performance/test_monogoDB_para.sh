# Script Nmae: test_monogoDB_para.sh
# Command line: "nohup test_monogoDB_para.sh xaa100m_row >  test_monogoDB_para_xaa100m_row.out & "

export FILE=$1
export CSV=${FILE}.csv
echo -e "Monogo performance starting: `date` \n"
date1=`date +%Y%m%d%H%M%S`
mongoimport --host=127.0.0.1 --db jagdb --collection  $FILE  --type csv --file $CSV  --headerline 
sleep 1
date2=`date +%Y%m%d%H%M%S`
echo -e "\nMonogo performance ending: `date` \n"

echo "Total time passwd in second: $((date2 - date1))" 
