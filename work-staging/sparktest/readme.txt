Steps to test spark data load:

1) Create table by:
login < create_egift.sql

2) Single load, for example:
submit_spark.sh 10000

3) Concurent load, for sample:

./manyspark.sh 10000 5
