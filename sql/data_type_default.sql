# SQL Name: data_type_default.sql  

# Failed :
# v25_String string,

drop table if exists data_type_default;

spool  $QA_HOME/work/data_type_default.out;

create table data_type_default 
( 
    key: 
        key1 integer,
        key2 char(32), 
    value: 
        v1_Char char(32), 
        v2_Boolean boolean, 
        v3_Ingeter integer,
        v3_1_Int int,
        v4_Big_Integer bigint,
        v5_Small_Integer smallint,
        v6_Tiny_int tinyint,
        v7_Medium_Integer MEDIUMINT,
        v8_Float float,
        v9_Double double,
        v11_DateTimeNano datetimenano,
        v12_Date date,
        v13_Time time,
        v14_TimeNamn TimeNano, 
        v15_Timestamp timestamp, 
        v16_Real real,
        v17_Text text,
        v18_TinyText TinyText,
        v19_MediumText MediumText, 
        v20_LongText, LongText,
        v21_Blob Blob,        
        v22_TinyBlob TinyBlob,
        v23_MediumBlob MediumBlob,
        v24_LongBlob LongBlob,
        v25_String string,
        v26_Varchar varchar(32),
        v27_Bit bit
);

desc data_type_default;

spool off;

quit;




