# A utilty to convert the text into a runable sql command

# Script Name: Modify_jaguar_update_tail.sh 

# Get the first column:


# if [ $# != 1 ]; then
#    echo "You need one (and only one) argument: the text file!"
#    exit 1;
# 
#fi

# cut -d, -f1 < $1 > file_colum1.txt

cat xaa700m_row_10000_tail_col1.csv |
while read line
do
    echo "$line"
    echo "update db_mongo_jaguar.tab_700million set v1='123, Main St', v2='Fremont', v3='94358' where uid='$line';" >> jaguar_update_10000_700million_tail.sql

done

