#!/bin/bash

function usage()
{
	p=$1
	echo
	echo "Usage:"
	echo
	echo "$p -m  mysql_schema_file  > mysql_select_max_file "
	echo "    Output is select max(length(COL)) from tab123; // COL: text/blob columns "
	echo
	echo "$p -s  mysql_schema_file  > jaguar_schema_file "
	echo "    jaguar_schema_file is create table statements in jaguar"
	echo
}

function procselmax()
{
	tabfile=$1
	#echo "# procselmax s229 tabfile=[$tabfile] ..."
	for f in .primary_key .unique_key .foreign_key_comment .keys .values; do
		[[ -f $f ]] && /bin/rm -f $f
	done

    while read line
    do
		#echo "****** dbg8283 line=[$line]"
		if [[ "x$line" = "x" || "x$line" = "x " ]]; then
			continue
		fi

    	if echo $line |grep -qE '\s*create\s+table'; then
    		tabname=`echo $line| awk '{print $3}'`
			continue
    	fi

		if echo $line|grep -qE "^\s*\w+\s+blob"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+tinyblob"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+mediumblob"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+longblob"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		fi

		if echo $line|grep -qE "^\s*\w+\s+text"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+tinytext"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+mediumtext"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		elif echo $line|grep -qE "^\s*\w+\s+longtext"; then
			col=`echo $line|cut -d' ' -f1`
			echo "select max(length($col)) from $tabname;"
			continue
		fi

    
    done < $tabfile
}


function procfile()
{
	tabfile=$1
	for f in .primary_key .unique_key .foreign_key_comment .keys .values; do
		[[ -f $f ]] && /bin/rm -f $f
	done

	sed -ie "s/ tinyint(.*)/ tinyint/g" $tabfile
	sed -ie "s/ smallint(.*)/ smallint/g" $tabfile
	sed -ie "s/ int(.*)/ int/g" $tabfile
	sed -ie "s/ mediumint(.*)/ mediumint/g" $tabfile
	sed -ie "s/ bigint(.*)/ bigint/g" $tabfile
	sed -ie "s/ bit(.*)/ bit/g" $tabfile

    while read line
    do
		#echo "****** dbg8283 line=[$line]"
		if [[ "x$line" = "x" || "x$line" = "x " ]]; then
			continue
		fi

		#### convert auto_increment to uuid
    	if echo $line |grep -qE "\s+auto_increment"; then
			col=`echo $line | awk '{print $1}'`
			line="$col uuid,"
		fi

		((special=0))
    	if echo $line |grep -qE '\s*create\s+table'; then
			((special=1))
    		tabname=`echo $line| awk '{print $3}'`
    	fi
    
    	if echo $line |grep -qE "\s*primary\s+key"; then
			((special=1))
			#echo "#s8383 line=[$line]"
    		col1=`echo $line|awk '{print $3}'`
    		col=`echo $col1|tr -d '('|tr -d ')'`
    		echo "$tabname|$col" > .primary_key
    	fi
    
    	if echo $line |grep -qE '\s*unique\s+key'; then
			((special=1))
    		## UNIQUE KEY ITEM_ACCESS (ITEM_ACCESS,ASN_AP_ITEM_ID),
    		uniquekeyname=`echo $line|awk '{print $3}'`
    		uniquekeycols=`echo $line|awk -F'(' '{print $2}'| tr -d ')'`
			echo "$uniquekeyname|$uniquekeycols" >> .unique_key
    	fi

    	if echo $line |grep -qE '^\s*key '; then
			((special=1))
			if echo $line |grep -q 'key fk'; then
				echo $line >> .foreign_key_comment
			else
    			keyname=`echo $line|awk '{print $2}'`
    			keycols=`echo $line|awk -F'(' '{print $2}'| tr -d ')'`
				echo "$keyname|$keycols" >> .keys
			fi
		fi

		if echo $line |grep  -qE '^\s*constraint '; then
			((special=1))
			echo $line >> .foreign_key_comment
		fi

		if echo $line |grep  -iqE '^\s*\);'; then
			((special=1))
		fi

		### value cols:
		if (( special == 0 )); then
			#echo "## s7723 line=[$line] goto .values file"
			echo $line >> .values
		fi
    
    	### if there is primary key; put it in key:, if there is unique key, put it in create index
    	### if there is no primary key, put unique key as key:
    	### CONSTRAINT put as # CONSTRAINT
    	### KEY FK  as  #KEY FK ...
    	### KEY xxx as create index xxx on tab(keys);
    done < $tabfile

	#/bin/rm -f .primary_key .unique_key .foreign_key_comment .keys
	## create table
	echo "create table $tabname " 
	echo "("
	echo "  key:"
	if [[ -f .primary_key ]]; then
    	#echo "$tabname|$col" > .primary_key
		keycol=`awk -F'|' '{print $2}' .primary_key`
		IFS=',' read -r -a arr <<< "$keycol"
		for elem in "${arr[@]}"; do
			line=`grep -E "^\s*$elem\s+" .values`
			#echo "## d7373 line=[$line] elem=[$elem]"
			echo "    $line"
			sed -ie "/^\s*$elem\s*/d" .values
		done
	else
		if [[ -f .unique_key ]]; then
			line=`head -1 .unique_key`
			uniquekeyname=`echo $line|awk -F'|' '{print $1}'`
			uniquekeycols=`echo $line|awk -F'|' '{print $2}'`
			IFS=',' read -r -a arr <<< "$uniquekeycols"
			for elem in "${arr[@]}"; do
				line=`grep -E "^\s*$elem\s+" .values`
				echo "    $line"
				sed -ie "/^\s*$elem\s*/d" .values
				### sed does not take \s+
			done
			sed -ie "/^\s*$uniquekeyname|/d" .unique_key
		else
			if [[ -f .keys ]]; then
				line=`head -1 .keys`
				keyname=`echo $line|awk -F'|' '{print $1}'`
    			keycols=`echo $line|awk -F'|' '{print $2}'`
    			IFS=',' read -r -a arr <<< "$keycols"
    			for elem in "${arr[@]}"; do
    				line=`grep -E "^\s*$elem\s+" .values`
    				echo "    $line"
    				sed -ie "/^\s*$elem\s*/d" .values
    				### sed does not take \s+
    			done
				sed -ie "/^\s*$keyname|/d" .keys
			fi
			
		fi

	fi

	echo "  value:"
	while read line; do
		echo "    $line"
	done < .values
	echo ");"

	if [[ -f .foreign_key_comment ]]; then
		while read line; do
			echo "# $line"
		done < .foreign_key_comment
	fi

	if [[ -f .unique_keys ]]; then
		### UNIQUE KEY ITEM_ACCESS (ITEM_ACCESS,ASN_AP_ITEM_ID),
		#echo "$uniquekeyname|$uniquekeycols" >> .unique_key
		while read line; do
			keyname=`echo $line | awk -F'|' '{print $1}'`
			keycols=`echo $line | awk -F'|' '{print $2}'`
			echo "create index $keyname on $tabname( $keycols ); "
		done < .unique_keys
	fi

	if [[ -f .keys ]]; then
		### UNIQUE KEY ITEM_ACCESS (ITEM_ACCESS,ASN_AP_ITEM_ID),
		#echo "$uniquekeyname|$uniquekeycols" >> .unique_key
		while read line; do
			keyname=`echo $line | awk -F'|' '{print $1}'`
			keycols=`echo $line | awk -F'|' '{print $2}'`
			echo "create index $keyname on $tabname( $keycols ); "
		done < .keys
	fi

	echo

}

########################### main #######################################
##   The scripts reads a mysql schema file and creates jaguar schema file
##
##   $0 -m  mysql_schema_file   >  mysql_selec_max
##   $0 -s  mysql_schema_file   >  jaguar_schema.sql
##
########################################################################

cmd=$1
((cmdn=0))
if [[ "x$cmd" = "x-m" ]]; then
	((cmdn=10))
elif [[ "x$cmd" = "x-s" ]]; then
	((cmdn=20))
else
	usage $0
	exit 1
fi

fn=$2
if [[ ! -f $fn ]]; then
    usage $0
	echo "Schema file $fn not found, exit"
	exit 1
fi

tmpfile1="${fn}.$$.newsql"
cat $fn | tr -d '`' |grep -v '\-\-' |grep -v '\/*!' > $tmpfile1
tmpfile2="${fn}.$$.newsql.2"
tr '[:upper:]' '[:lower:]' < $tmpfile1 > $tmpfile2

sed -ie "s/)\s*engine=.*/);/g" $tmpfile2
sed -ie "s/\t/ /g" $tmpfile2
sed -ie "s/default\s*null//g" $tmpfile2
sed -ie "s/not\s*null//g" $tmpfile2

#cat .output.txt.$$

while read line
do
		#echo "****** dbg1283 line=[$line]"
		if [[ "x$line" = "x" || "x$line" = "x " ]]; then
			continue
		fi

		if (( cmdn == 20 )); then
    		if echo $line |grep -qE "^\s*drop\s+table\s*"; then
    			echo "$line"
    		fi
		fi

    	if echo $line |grep -qE "^\s*create\s+table\s*"; then
    		/bin/rm -f .segfile
    	fi
		echo $line >> .segfile

    	if echo $line |grep -q ');'; then
			if (( cmdn == 10 )); then
    			procselmax .segfile
			elif (( cmdn == 20 )); then
    			procfile .segfile
			fi
    	fi
done <  $tmpfile2

/bin/rm -f $tmpfile1
/bin/rm -f $tmpfile2
/bin/rm -f ${tmpfile2}e
/bin/rm -f .segfile

if (( cmdn == 20 )); then
	/bin/rm -f .segfilee
fi

