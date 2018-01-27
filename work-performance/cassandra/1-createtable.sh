#!/bin/bash
# Script Name: 1_createtable.sh

echo "drop keyspace mykeyspace ..."
keypace="drop KEYSPACE mykeyspace;"
# cqlsh -e "$keyspace"
cqlsh -e "drop KEYSPACE mykeyspace;"
#exit

echo "Create keyspace mykeyspace ..."
keypace="CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor' : 3 };"
#cqlsh -e "$keyspace"
cqlsh -e "CREATE KEYSPACE mykeyspace WITH REPLICATION = { 'class': 'SimpleStrategy', 'replication_factor' : 3 };"

#exit

echo "drop table  callinfo"
keypace="drop table callinfo;"
#cqlsh -e "$keyspace"
cqlsh -e "drop table callinfo;"

#exit

echo "Create table callinfo ..."
createTab="create table callinfo ( lNumberKey  bigint PRIMARY KEY, tApplyTime timestamp, tExpirtTime timestamp, szCallNumber ascii, iHomeArea int, szStatus ascii, lMainAccountKey bigint, lAccT_balance_id bigint, lAcctid bigint, szSecond_ower_type  ascii, iBalance_Type_ID int, lAmount bigint, lInitialAmount bigint, lReserveAmount bigint, lSettleAmount bigint, szOrigin_type ascii, lOriginID bigint, szInitialType ascii, lInitial_D bigint, content ascii, lReserve0 bigint, tReserve0 timestamp, lReserve1 bigint, tReserve1 timestamp, lReserve2 bigint, tReserve2 timestamp, lReserve3 bigint, tReserve3 timestamp, lReserve4 bigint, tReserve4 timestamp)"
cqlsh -k mykeyspace -e  "$createTab"


#echo "Create local secondary index ..."
#index="create index idx_callinfo_szCallNumber on callinfo(szCallNumber)"
#cqlsh -k mykeyspace -e  "$index"

