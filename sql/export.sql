Done in 261 microseconds
jaguar:test> select * from table234 exportcsv;
"1003","xx","xx","x","2017-09-24 07:25:34.000000","    x","x","x",
Done in 3 milliseconds (1 row)
jaguar:test> select * from table234 exportsql;
insert into test.table234 ( partno, name, sku, manufacture, buydate, buyer, ptype, supplier, '1003', 'xx', 'xx', 'x', '2017-09-24 07:25:34.000000', '    x', 'x', 'x',
    Done in 2 milliseconds (1 row)
    jaguar:test>



# export/import
# 1) select 

select * from table234;

#ndrew@ssd)\>jagimportsql -d test -f test.data_load.sqlndrew@ssd)\>jagimportsql -d test -f test.data_load.sql 2) exportsql
/home/andrew/jaguar/bin
(andrew@ssd)\>jagexportsql -d test -t table23

# 2-1)
jaguar:test> select * from table234 exportcsv;
"1003","xx","xx","x","2017-09-24 07:25:34.000000","    x","x","x"

jaguar:test> select * from table234 exportsql;
insert into test.table234 ( partno, name, sku, manufacture, buydate, buyer, ptype, supplier ) values ( '1003', 'xx', 'xx', 'x', '2017-09-24 07:25:34.000000', '    x', 'x', 'x' );




#################################
# export, exportcsv, exportsql
#################################
# 2017/10/13
jagexportsql -d test -t data_load

jagexportcsv -d test -t data_load

jaguar:test> delete from test.data_load;

/home/andrew/jaguar/bin
(andrew@ssd)\>jagimportcsv  -d test -t data_load -f test.data_load.csv

jaguar:test> delete from test.data_load;



/home/andrew/jaguar/bin
(andrew@ssd)\>jagimportsql -d test -f test.data_load.sql


