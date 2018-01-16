# A utilty to convert the text into a runable sql command

# Script Name: Modify_jaguar_insert_random.sh

# Get the first column:


# if [ $# != 1 ]; then
#    echo "You need one (and only one) argument: the text file!"
#    exit 1;
# 
#fi

# cut -d, -f1 < $1 > file_colum1.txt

cat xaa700m_row_10000_random_col1.csv |
while read line
do
    echo "$line"
    echo "insert into db_mongo_jaguar.tab_700million ( uid, v1, v2, v3 ) values ( '$line', '1118 Guyson ct', 'Pleasanton', '94588' );" >> jaguar_insert_10000_700million_random.sql
done


