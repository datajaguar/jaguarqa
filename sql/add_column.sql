
spool  $QA_HOME/work/add_column.out;
desc test.import_export;

alter table test.import_export add v_new3 char(10);

desc test.import_export;

select count(*) from test.import_export;
insert into test.import_export ( uid, v1, v2, v3, v_new1 ) values ( 'zqNlCIpr68etDoiZ', 'A0uuWpv83ctjXXMv', 'nzQYffnklBNYY3Yy', '3q00Nw6QIx7GuT9Q' , 'Jaguar_DB1');
select count(*) from test.import_export;
desc test.import_export;

spool off;

exit;

