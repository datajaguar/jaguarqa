# A utilty to convert the text into a runable sql command

# Script Name: Modify_jaguar_delete_tail.sh   

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
    echo "delete from db_mongo_jaguar.tab_700million where uid='$line';" >> jaguar_delete_10000_700million_tail.sql
done


