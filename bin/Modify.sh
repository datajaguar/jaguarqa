# A utilty to convert the text into a runable sql command


# Get the first column:


if [ $# != 1 ]; then
    echo "You need one (and only one) argument: the text file!"
    exit 1;
fi

cut -d, -f1 < $1 > file_colum1.txt

cat file_colum1.txt |
while read line
do
    echo "$line"
    echo "select * from db_mongo_jaguar.tab_700million where uid='$line';" >> select.sql

done

# We can modifile the sytax, such as:
# echo "db.tab_400million.find({uid: "NkFJfNgWhfqW4aIX"})
